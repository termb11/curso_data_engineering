WITH src_events AS (
    SELECT *
    FROM {{ ref('base_sql_server_events') }}
    ),

renamed_casted AS (
    SELECT event_id,
           page_url,
           event_type,
           event_type_id,
           user_id,
           NULLIF(product_id,'') as product_id,
           session_id,
           CONVERT_TIMEZONE('UTC',created_at)::date as created_at,
           CONVERT_TIMEZONE('UTC',created_at)::time as created_at_utc,
           NULLIF(order_id, '') as order_id,
           coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted,
           CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_utc
    FROM src_events
    )

SELECT * FROM renamed_casted
