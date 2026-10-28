with line_items as (
    select * from {{ ref('stg_tpch__line_items') }}
),

orders as (
    select * from {{ ref('stg_tpch__orders') }}
)

select
    line_items.order_item_id,
    line_items.order_id,
    orders.customer_id,
    orders.order_date,
    orders.order_status,
    line_items.ship_date,
    line_items.return_flag,
    line_items.quantity,
    line_items.extended_price   as  gross_amount,
    round(line_items.extended_price * line_items.discount_rate, 2) as discount_amount,
    round(line_items.extended_price * (1 - line_items.discount_rate), 2) as net_amount,
    round(line_items.extended_price * (1 - line_items.discount_rate) * line_items.tax_rate, 2) as tax_amount
from line_items
inner join orders on line_items.order_id = orders.order_id