WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server', 'events') }}
    ),

renamed_casted AS (
    SELECT
        event_id
        , page_url
        , event_type
        , md5(event_type) AS event_type_id
        , user_id
        , product_id
        , session_id
        , created_at
        , order_id
        , _fivetran_deleted
        , _fivetran_synced
    FROM src_events
    )

SELECT * FROM renamed_casted