{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ ref('base_sql_server_events') }}
    ),

renamed_casted AS (
    SELECT *
    FROM src_events
    )

SELECT * FROM renamed_casted