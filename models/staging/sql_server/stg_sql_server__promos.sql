

WITH src_promos AS (
    SELECT * 
    FROM {{ ref('base_sql_server_promos') }}
    ),

renamed_casted AS (
    SELECT *
    FROM src_promos
    )

SELECT * FROM renamed_casted