select
    r_regionkey as region_id,
    r_name      as region_name
from {{ source('tpch', 'region') }}
