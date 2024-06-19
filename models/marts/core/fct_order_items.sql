{{ config(
    materialized='incremental',
    unique_key = 'order_id'
    ) 
    }}

WITH int_orders AS(
SELECT *
    FROM {{ ref('int_orders') }}
), 
fct AS (
SELECT  
        product_id,
        order_id,
        category_id,
        promo_id,
        user_id,
        seller_id,
        address_id,
        quantity,
        PRICE_PRODUCT,
        round(SHIPPING_PER_ITEM,2) as shipping_per_item,
        round(DISCOUNT_PER_ITEM,2) as discount_per_item,
        _fivetran_synced_UTC

       FROM int_orders
)
SELECT * FROM fct

{% if is_incremental() %}

  where _fivetran_synced_utc > (select max(_fivetran_synced_utc) from {{ this }})

{% endif %}