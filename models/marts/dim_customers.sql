with customers as (
    select * from {{ ref('stg_tpch__customers') }}
),

nations as (
    select * from {{ ref('stg_tpch__nations') }}
),

regions as (
    select * from {{ ref('stg_tpch__regions') }}
),

segments as (
    select * from {{ ref('market_segments') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['customers.customer_id']) }} as customer_key,
    customers.customer_id,
    customers.customer_name,
    customers.market_segment,
    segments.segment_group,
    nations.nation_name,
    regions.region_name,
    customers.account_balance
from customers
left join nations
    on customers.nation_id = nations.nation_id
left join regions
    on nations.region_id = regions.region_id
left join segments
    on customers.market_segment = segments.market_segment
