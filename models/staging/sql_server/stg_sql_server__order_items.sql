{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server', 'order_items') }}
    ),

renamed_casted AS (
    SELECT
        order_id
        , PRODUCT_ID
        , QUANTITY
        , _fivetran_deleted
        , _fivetran_synced AS date_load
    FROM src_order_items
    )

SELECT * FROM renamed_casted