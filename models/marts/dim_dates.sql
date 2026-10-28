with days as (
    {{  dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1992-01-01' as date)",
        end_date="cast('1999-01-01' as date)"
    )
    
    }}
)

select 
    cast(date_day as date)                      as date_day,
    extract(year from date_day)                 as year_number,
    extract(quarter from date_day)              as quarter_number,
    extract(month from date_day)                as month_number,
    cast(date_trunc('month', date_day) as date) as month_start_date
from days