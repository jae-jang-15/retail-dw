-- This test fails if it returns any rows.
-- A discount can only lower the price, so net must never be above gross.
select
    order_item_id,
    gross_amount,
    net_amount
from {{ ref('fct_order_items') }}
where net_amount > gross_amount
