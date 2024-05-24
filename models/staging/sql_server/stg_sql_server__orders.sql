
{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server', 'orders') }}
    ),

renamed_casted AS (
    SELECT
         order_id
        , shipping_service
        , shipping_cost
        , address_id
        , promo_id
        , ESTIMATED_DELIVERY_AT
        , ORDER_COST
        , USER_ID
        , ORDER_TOTAL
        , DELIVERED_AT
        , TRACKING_ID
        , STATUS
        , _fivetran_deleted
        , _fivetran_synced AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted