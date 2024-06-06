WITH src_shipping AS (
    SELECT * 
    FROM {{ ref('base_sql_server_orders') }}
    ),

renamed_casted AS (
    SELECT distinct shipping_service_id,
    shipping_service
    FROM src_shipping
    )

SELECT * FROM renamed_casted