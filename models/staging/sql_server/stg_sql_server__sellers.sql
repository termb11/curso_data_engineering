WITH src_seller AS (
    SELECT * 
    FROM {{ ref('base_sql_server_sellers') }}
    ),

orders as (
    SELECT seller_id,
    count(*) as orders_by_seller
    FROM {{ ref('base_sql_server_orders') }}
    group by seller_id
)

SELECT s.*,
        o.orders_by_seller
from orders o
left join src_seller s
on o.seller_id=s.seller_id
        

