WITH src_shipping AS (
    SELECT * 
    FROM {{ ref('base_sql_server_orders') }}
    ),

renamed_casted AS (
    SELECT distinct shipping_service,
    shipping_service_id
    FROM src_shipping
    )

SELECT * FROM renamed_casted