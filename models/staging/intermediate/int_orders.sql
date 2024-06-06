WITH src_items_orders AS (
    SELECT order_id,
    count(*) as item_per_order
    FROM {{ ref('stg_sql_server__order_items') }}
    group by order_id
    ),

order_items AS (
    SELECT 
        order_id,
        quantity,
        product_id
    FROM 
        {{ ref('stg_sql_server__order_items') }}
),

products as (
    SELECT price,
    product_id
    FROM {{ ref('stg_sql_server__products') }}
),

orders as (
    SELECT order_id,
    promo_id,
    order_total,
    order_cost,
    shipping_cost, 
    user_id,
    address_id
    FROM {{ ref('stg_sql_server__orders') }}
),

promos as (
    SELECT promo_id,
    discount_euros
    FROM {{ ref('stg_sql_server__promos') }}
)

SELECT  
        oi.order_id,
        o.user_id,
        o.address_id,
        oi.quantity,
        oi.product_id,
        soi.item_per_order,
        p.price AS price_product,
        o.shipping_cost/soi.item_per_order as shipping_per_item,
        oi.quantity*p.price as price_per_quantity,
        sum(oi.quantity*p.price)over(partition by oi.order_id) as price_per_order,
        prom.discount_euros/soi.item_per_order as discount_per_item,
        prom.promo_id,
        (oi.quantity*p.price)-(prom.discount_euros/soi.item_per_order)+(o.shipping_cost/soi.item_per_order) as total_per_product_per_order
FROM 
    order_items oi
LEFT JOIN 
    src_items_orders soi ON oi.order_id = soi.order_id
LEFT JOIN 
    products p ON oi.product_id = p.product_id
LEFT JOIN 
    orders o ON o.order_id = oi.order_id
LEFT JOIN 
    promos prom ON prom.promo_id = o.promo_id




