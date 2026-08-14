{{
    config
    (
        materialized = 'table'
    )
}}

with clean_orders as (
    select
        *,
        CURRENT_TIMESTAMP as INSERT_DTS
    from {{ ref('clean_orders') }}
)

select * from clean_orders