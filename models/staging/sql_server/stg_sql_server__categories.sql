WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server', 'categories') }}
    )

SELECT  {{dbt_utils.generate_surrogate_key(['category_name'])}} as category_id,
        category_name,
        created_at::date as created_at
FROM src_promos