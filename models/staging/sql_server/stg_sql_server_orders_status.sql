WITH src_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_orders') }}
    ),

renamed_casted AS (
    SELECT distinct status,
    status_id
    FROM src_orders
    )

SELECT *
FROM renamed_casted