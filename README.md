# retail_dw

A small retail data warehouse built with dbt on Snowflake.

## What it does

- Reads raw orders, order lines and customers from Snowflake's TPC-H sample data
- Cleans them in a staging layer, applies pricing logic in an intermediate layer
- Publishes a star schema: `dim_customers`, `dim_dates`, `fct_order_items`
- Tracks customer history with a snapshot (slowly changing dimension, type 2)
- Runs 30 data tests and 1 unit test on every build

## How it is run

| Environment | Database | Trigger |
| --- | --- | --- |
| Development | `ANALYTICS_DEV` | By hand: `dbt build` |
| CI | `ANALYTICS_CI` | Every pull request, in a throwaway schema |
| Production | `ANALYTICS_PROD` | Every merge to `main`, and daily at 06:00 UTC |

## Run it yourself

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
dbt deps
dbt build
```

You need a Snowflake account and a `~/.dbt/profiles.yml` with a `retail_dw` profile.
