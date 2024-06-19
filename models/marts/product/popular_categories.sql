WITH src_items_orders AS (SELECT
    category_id,
    SUM(total_per_product_per_order) AS total_sales
FROM 
    {{ref('int_orders')}}
GROUP BY 
    category_id
ORDER BY 
    total_sales DESC
)

select * from src_items_orders