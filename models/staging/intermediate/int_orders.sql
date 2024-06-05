WITH src_items_orders AS (
    SELECT *
    FROM {{ ref('stg_sql_server__order_items') }}
    ),

products as (
    SELECT price,
    product_id
    FROM {{ ref('stg_sql_server__products') }}
),

orders as (
    SELECT order_id,
    order_total,
    order_cost,
    shipping_cost
    FROM {{ ref('stg_sql_server__orders') }}
)

select  o.*,
        u.price,
        ord.order_total,
        ord.order_cost,
        ord.shipping_cost,
        o.quantity*u.price as price_per_cuantity,
        sum(o.quantity*u.price)over(partition by ord.order_id) as price_per_oder
from products u
left join src_items_orders o 
on o.product_id = u.product_id
left join orders ord
on ord.order_id = o.order_id




