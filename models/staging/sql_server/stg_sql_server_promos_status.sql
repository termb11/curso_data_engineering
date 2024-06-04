WITH src_promos_status AS (
    SELECT * 
    FROM {{ ref('base_sql_server_promos') }}
    ),

renamed_casted AS (
    SELECT distinct status,
    status_id
    FROM src_promos_status
    )

SELECT * FROM renamed_casted