# 🏦 dbt Greenplum Warehouse | Modern ELT & Data Modeling

Production-ready слой трансформаций для аналитического хранилища. Переводит сырые данные из ingestion-слоя (PySpark/Airflow) в структурированные витрины для BI и ML с автоматическим тестированием, документацией и CI/CD.

##  Что решает

- 🧱 **Моделирование данных**: Staging → Intermediate → Marts (Star Schema)
-  **Инкрементальные модели**: обновление только изменённых данных (CDC)
- 🧪 **Data Quality**: встроенные тесты (уникальность, not_null, кастомные проверки)
- 📖 **Автодокументация**: dbt docs, lineage graph, описание таблиц/колонок
- 🚀 **CI/CD**: GitHub Actions (lint, test, build docs, deploy)
- 🧩 **Интеграция**: готов к подключению к Greenplum/Postgres и Spark-инжестии

##  Технологический стек

- **Transformation:** dbt-core, SQL (CTE, Window Functions, Macros)
- **Storage:** PostgreSQL / Greenplum (DWH)
- **Testing & Docs:** dbt tests, Great Expectations (optional), dbt docs
- **CI/CD:** GitHub Actions, SQLFluff, pre-commit
- **Infrastructure:** Docker, Makefile

## 📂 Структура проекта
```
dbt_greenplum_warehouse/
├── models/
│ ├── staging/ # Очистка сырых данных
│ ├── intermediate/ # Бизнес-логика, джойны
│ └── marts/ # Финальные витрины (BI/ML)
├── tests/ # Кастомные SQL-тесты
── macros/ # Переиспользуемые функции
├── dbt_project.yml # Конфигурация проекта
├── profiles.yml.example # Шаблон подключения к БД
├── .github/workflows/ci.yml
└── README.md 
```
## 🚀 Быстрый старт

### 1. **Клонируй репозиторий:**
```bash
git clone https://github.com/Giganmama/dbt_greenplum_warehouse.git
cd dbt_greenplum_warehouse
```

### 2. **Настрой подключение к БД:**
```bash
cp profiles.yml.example profiles.yml
# Отредактируй target: dev под свой PostgreSQL/Greenplum
```

### 3. **Установи зависимости:**
```bash
pip install dbt-postgres sqlfluff pre-commit
pre-commit install
```

### 4. **Запусти пайплайн:**
```bash
dbt run                # Построить все модели
dbt test               # Запустить тесты качества
dbt docs generate      # Сгенерировать документацию
dbt docs serve         # Открыть lineage graph в браузере
```
## 📊 Архитектура данных
```
Raw Layer (PySpark/MinIO) 
    ↓
stg_ (Очистка, типизация, дедупликация)
    ↓
int_ (Бизнес-правила, агрегации, джойны)
    ↓
mrt_ (Финальные витрины для BI/DS)
```

## 🛡️ Data Quality & Testing

| Тип теста | Описание |
|-----------|----------|
| `not_null` | Критические колонки не содержат NULL |
| `unique` | Первичные ключи уникальны |
| `accepted_values` | ENUM-поля соответствуют словарю |
| `relationships` | Внешние ключи валидны |
| Custom SQL | Кастомные проверки (например, `amount > 0`) |

## 📈 Метрики

- ⏱ **Время сборки:** ~12 сек на 500k строк (инкрементальный режим)
- 🛡️ **Покрытие тестами:** 100% критических таблиц
- 📖 **Документация:** Автогенерация lineage, описаний, зависимостей
- 🔄 **CI/CD:** Автоматический lint + test на каждый PR
