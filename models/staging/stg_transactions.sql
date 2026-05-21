{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'raw_transactions') }}
),

renamed as (
    select
        transaction_id,
        client_id,
        amount,
        transaction_date::date as transaction_date,
        lower(trim(transaction_type)) as transaction_type,
        merchant_category
    from source
    where amount > 0
      and client_id is not null
)

select * from renamed
