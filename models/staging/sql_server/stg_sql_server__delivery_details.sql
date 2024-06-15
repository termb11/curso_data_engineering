WITH src_items_orders AS (
    SELECT distinct delivery_details_id,
    delivery_details
    FROM {{ ref('base_sql_server_orders') }}
    )
select * from src_items_orders