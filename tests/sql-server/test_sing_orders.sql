SELECT *
FROM {{ ref('stg_sql_server__orders') }}
WHERE DELIVERED_AT < CREATED_AT