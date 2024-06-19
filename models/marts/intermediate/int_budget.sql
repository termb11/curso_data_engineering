WITH budget AS (
    SELECT product_id,
           month(month) as month,
           sum(quantity) as expected_quantity_sold,
           _fivetran_synced,
           _row
    FROM {{ ref('stg_google_sheets__budget') }}
    GROUP BY product_id, month, _fivetran_synced, _row
    ),


orders as (
    SELECT oi.product_id,
    sum(oi.quantity) as real_quantity_sold,
    month(o.created_at) as month
    FROM {{ ref('stg_sql_server__orders') }} o
    LEFT JOIN {{ ref('stg_sql_server__order_items') }} oi
    ON oi.order_id=o.order_id
    group by oi.product_id, month
),

product as (
    SELECT product_id,
           price_product
    FROM {{ ref('stg_sql_server__products') }}
)

select b.product_id,
       b._fivetran_synced,
       b.month,
       b._row,
       p.price_product,
       b.expected_quantity_sold,
       IFF(o.month=b.month, o.real_quantity_sold, null) as real_quantity_sold,
       CASE when o.real_quantity_sold>b.expected_quantity_sold then o.real_quantity_sold-b.expected_quantity_sold
       else 0
       end as more_product_sold,
       CASE when o.real_quantity_sold<b.expected_quantity_sold then b.expected_quantity_sold-o.real_quantity_sold
       else 0
       end as less_product_sold
from orders o
left join budget b
on o.product_id=b.product_id
left join product p
on p.product_id=o.product_id

       

