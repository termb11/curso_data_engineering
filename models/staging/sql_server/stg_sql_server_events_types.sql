WITH src_event_type AS (
    SELECT * 
    FROM {{ ref('base_sql_server_events') }}
    ),

renamed_casted AS (
    SELECT distinct event_type,
    event_type_id
    FROM src_event_type
    )

SELECT * FROM renamed_casted