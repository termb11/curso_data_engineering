{{
    config(
        materialized='incremental',
        unique_key='event_id',
        tags='incremental'
    )
}}

WITH src_events AS (
    SELECT *
    FROM {{ ref('base_sql_server_events') }}
    ),

renamed_casted AS (
    SELECT event_id,
           page_url,
           event_type_id,
           user_id,
           product_id,
           session_id,
           created_at,
           order_id,
           _fivetran_deleted,
           _fivetran_synced_utc::date
    FROM src_events
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}
    