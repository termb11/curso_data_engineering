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
    SELECT price_product,
    product_id,
    category_id
    FROM {{ ref('stg_sql_server__products') }}
),

orders as (
    SELECT *
    FROM {{ ref('stg_sql_server__orders') }}
),

promos as (
    SELECT promo_id,
    discount_usd
    FROM {{ ref('stg_sql_server__promos') }}
)

SELECT  
        oi.order_id,
        o.user_id,
        o.seller_id,
        o.shipping_service,
        o.shipping_service_id,
        o.created_at,
        o.days_after,
        o.status_id,
        o.status,
        o.days_before,
        o.delivered_at,
        o.estimated_delivery_at,
        o.delivery_details,
        o.delivery_details_id,
        o.address_id,
        oi.quantity,
        oi.product_id,
        p.category_id,
        soi.item_per_order,
        p.price_product,
        o.shipping_cost_usd/soi.item_per_order as shipping_per_item,
        oi.quantity*p.price_product as price_per_quantity,
        sum(oi.quantity*p.price_product)over(partition by oi.order_id) as price_per_order,
        prom.discount_usd/soi.item_per_order as discount_per_item,
        prom.promo_id,
        (oi.quantity*p.price_product)-(prom.discount_usd/soi.item_per_order)+(o.shipping_cost_usd/soi.item_per_order) as total_per_product_per_order
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




