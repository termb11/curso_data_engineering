SELECT *
FROM {{ ref('stg_sql_server__orders') }}
WHERE delivered_at < created_at AND estimated_delivery_at < created_at