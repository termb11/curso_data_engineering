WITH budget AS (
    SELECT product_id,
           month(month) as month,
           sum(quantity) as expected_quantity_sold
    FROM {{ ref('stg_google_sheets__budget') }}
    GROUP BY product_id, month
    ),


orders as (
    SELECT oi.product_id,
    sum(oi.quantity) as real_quantity_sold,
    month(o.created_at) as month
    FROM {{ ref('stg_sql_server__orders') }} o
    LEFT JOIN {{ ref('stg_sql_server__order_items') }} oi
    ON oi.order_id=o.order_id
    group by oi.product_id, month
)

select b.product_id,
       b.month,
       b.expected_quantity_sold,
       IFF(o.month=b.month, o.real_quantity_sold, null) as real_quantity_sold,
       o.real_quantity_sold-b.expected_quantity_sold as dif_quantity
from orders o
left join budget b
on o.product_id=b.product_id
order by month

       

