WITH src_items_orders AS (
    SELECT delivery_details_id,
    delivery_details
    FROM {{ ref('stg_sql_server__orders') }}
    )