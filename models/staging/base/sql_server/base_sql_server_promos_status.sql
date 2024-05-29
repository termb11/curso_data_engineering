WITH src_promos_status AS (
    SELECT * 
    FROM {{ source('sql_server', 'promos') }}
    ),

renamed_casted AS (
    SELECT *
    FROM src_promos_status
    )

SELECT * FROM renamed_casted