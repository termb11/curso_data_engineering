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
        address_id,
        quantity,
        PRICE_PRODUCT,
        SHIPPING_PER_ITEM,
        DISCOUNT_PER_ITEM,
        TOTAL_PER_PRODUCT_PER_ORDER

       FROM int_orders
)
SELECT * FROM fct