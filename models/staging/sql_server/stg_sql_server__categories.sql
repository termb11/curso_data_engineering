WITH base_cat AS (
    SELECT * 
    FROM {{ ref('base_sql_server_categories') }}
    )

SELECT  category_id,
        category_name,
        created_at::date as created_at,
        CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC
FROM base_cat