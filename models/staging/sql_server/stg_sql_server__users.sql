WITH src_users AS (
    SELECT * 
    FROM {{ ref('base_sql_server_users') }}
    ),

renamed_casted AS (
    SELECT *
    FROM src_users
    )

SELECT * FROM renamed_casted