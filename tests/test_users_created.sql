SELECT *
FROM {{ ref('stg_sql_server__users') }}
WHERE updated_at < created_at 