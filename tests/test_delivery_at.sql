SELECT *
FROM {{ ref('stg_sql_server__orders') }}
WHERE delivery_at < created_at AND estimated_delivery_at < created_at