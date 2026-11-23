# Tasty Bites dbt Analytics Engineering Project

An end-to-end dbt project built with Snowflake and dbt Cloud to transform raw Tasty Bites data into tested, documented and analytics-ready models.

## Project overview

The project models food-truck ordering data across staging, intermediate and mart layers. It demonstrates how an analytics engineer turns raw warehouse tables into reliable outputs for reporting and business analysis.

```text
Raw Snowflake sources
        ↓
Staging models
        ↓
Intermediate transformations
        ↓
Dimensions and fact tables
        ↓
Tests, snapshots and documentation
        ↓
Business-ready marts
```

## Technology stack

- Snowflake — warehouse and execution engine
- dbt Cloud — transformation, testing, documentation and development
- SQL — model transformations and business logic
- Jinja — reusable macros and dynamic dbt configuration
- Git/GitHub concepts — branches, commits, Pull Requests and CI/CD

## Source data

The raw data comes from the Tasty Bytes sample dataset.

### Raw POS tables

- `order_header` — one row per order
- `order_detail` — one row per item within an order
- `menu` — menu-item descriptions and costs
- `truck` — food-truck attributes
- `location` — location attributes

### Raw customer table

- `customer_loyalty` — customer profile and loyalty attributes

## Project layers

### Staging

Staging models select and lightly clean raw source data:

```text
stg_orders
stg_order_items
stg_menu
stg_customers
stg_trucks
stg_locations
```

### Intermediate

Intermediate models contain reusable business transformations. For example, `int_order_items_priced` calculates:

- Cost of goods
- Gross profit
- Margin percentage

### Dimensions

Dimension models provide descriptive context:

- `dim_customer`
- `dim_truck`
- `dim_menu`
- `dim_date`

### Facts

`fct_orders` has one row per order and contains order-level measures such as totals, item count and total quantity.

`fct_order_items` has one row per order line and contains item-level measures such as quantity, revenue, cost, gross profit and margin percentage.

## Data quality and testing

The project demonstrates:

- `unique`
- `not_null`
- `accepted_values`
- `relationships`
- Singular business-rule tests
- Test severity
- Stored failures
- Source freshness checks

Tests protect the project from duplicate keys, missing values, invalid categories, broken relationships and failed business rules.

## Historical data with snapshots

The `customers_snapshot` model demonstrates SCD Type 2 history. When a tracked customer attribute changes, dbt preserves the old version and creates a new current version.

This allows the project to answer questions such as:

> Which customer attributes were valid when an order was placed?

## Reusable transformations

The `margin_pct` macro calculates margin percentage consistently across models:

```sql
{% macro margin_pct(revenue, cost) %}

round(
    100.0 * ({{ revenue }} - {{ cost }})
    / nullif({{ revenue }}, 0),
    4
)

{% endmacro %}
```

## Documentation and lineage

The project includes model and column descriptions, documentation blocks and relationship tests. dbt documentation presents these details together with the DAG/lineage graph, showing how raw sources flow into final marts.

## Git and CI/CD workflow

The intended development workflow is:

```text
Ticket
  ↓
Feature branch
  ↓
Code change
  ↓
dbt build and tests
  ↓
Commit and push
  ↓
Pull Request
  ↓
CI checks and code review
  ↓
Merge into main
  ↓
UAT and production deployment
```

CI can run SQL linting with SQLFluff and dbt builds/tests before a Pull Request is merged.

## Skills demonstrated

- dbt project organization
- Snowflake data transformation
- SQL joins, CTEs and aggregation
- Data modeling and grain
- Dimension and fact-table design
- Surrogate keys and relationships
- Incremental models
- SCD Type 2 snapshots
- Jinja and dbt macros
- Seeds and documentation blocks
- Generic and singular tests
- Source freshness
- DAG and lineage interpretation
- Git branches, commits, pushes and Pull Requests
- CI/CD concepts for data projects
