{{
    config
    (
        materialized = 'incremental',
        incremental_strategy = 'delete+insert',
        unique_key = 'PRODUCT_ID'
    )
}}

with product_src as (
    select
        *,
        CURRENT_TIMESTAMP as INSERT_DTS    
    from {{source('product', 'PRODUCT_SRC')}}

    {% if is_incremental() %}
    where CREATED_AT > (select max(INSERT_DTS) from {{this}})
    {% endif %}
)

select * from product_src