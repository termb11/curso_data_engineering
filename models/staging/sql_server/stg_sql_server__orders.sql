
WITH src_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_orders') }}
    ),

renamed_casted AS (
    SELECT order_id,
           shipping_service_id,
           shipping_cost_usd,
           address_id,
           promo_id,
           estimated_delivery_at,
           order_cost_usd,
           user_id, 
           created_at,
           order_total_usd,
           delivery_at,
           status_id,
           _fivetran_deleted,
           _fivetran_synced_utc

    FROM src_orders
    )

SELECT * FROM renamed_casted