{{ config(
    materialized='incremental',
    unique_key='order_item_id',
    on_schema_change='append_new_columns'
) }}

with order_items as (
    select * from {{ ref('int_order_items__priced') }}
)

select
    order_item_id,
    order_id,
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }}   as customer_key,
    order_date,
    ship_date,
    order_status,
    return_flag,
    quantity,
    gross_amount,
    discount_amount,
    net_amount,
    tax_amount
from order_items

{% if is_incremental() %}
where order_date >= (select max(order_date) from {{ this }})
{% endif %}
