WITH src_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_orders') }}
    ),

renamed_casted AS (
    SELECT order_id,
    seller_id,
    shipping_service,
    shipping_service_id,
    shipping_cost_usd,
    address_id,
    promo_id,
    delivery_details,
    delivery_details_id,
    estimated_delivery_at,
    order_cost_usd,
    user_id,
    created_at,
    order_total_usd,
    delivered_at,
    tracking_id,
    status,
    status_id,
    days_after,
    days_before,
    _fivetran_deleted,
    _fivetran_synced_UTC


    FROM src_orders
    )

SELECT * FROM renamed_casted