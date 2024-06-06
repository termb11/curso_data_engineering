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
        , NULLIF(product_id,'') as product_id
        , session_id
        , CONVERT_TIMEZONE('UTC',created_at)::date as date_id
        , NULLIF(order_id, '') as order_id
        , coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted
        , CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC
    FROM src_events
    )

SELECT * FROM renamed_casted