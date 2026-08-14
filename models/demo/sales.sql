{{
    config
    (
        materialized = 'incremental',
        incremental_strategy = 'append'
    )
}}

with sales_src as (
    select
        *,
        CURRENT_TIMESTAMP as INSERT_DTS
    from {{source('sales', 'SALES_SRC')}}

    {% if is_incremental() %}
    where CREATED_AT > (select max(INSERT_DTS) from {{this}})
    {% endif %}
)

select * from sales_src