{{ config(
    materialized='incremental',
    unique_key='client_id',
    incremental_strategy='merge'
) }}

with base as (
    select * from {{ ref('stg_transactions') }}
    {% if is_incremental() %}
        where transaction_date > (select max(transaction_date) from {{ this }})
    {% endif %}
),

aggregated as (
    select
        client_id,
        sum(amount) as total_amount,
        avg(amount) as avg_amount,
        count(*) as transaction_count,
        min(transaction_date) as first_transaction,
        max(transaction_date) as last_transaction,
        max(case when amount > 100000 then 1 else 0 end) as has_large_transaction,
        avg(case when transaction_type = 'atm_withdrawal' then 1 else 0 end) as atm_usage_ratio
    from base
    group by client_id
)

select
    client_id,
    total_amount,
    avg_amount,
    transaction_count,
    first_transaction,
    last_transaction,
    datediff(day, last_transaction, current_date) as days_since_last,
    has_large_transaction,
    atm_usage_ratio
from aggregated
