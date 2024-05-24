{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server', 'products') }}
    ),

renamed_casted AS (
    SELECT
         PRODUCT_ID
        , PRICE
        , NAME
        , INVENTORY
        , _FIVETRAN_DELETED
        , _FIVETRAN_SYNCED
    FROM src_products
    )

SELECT * FROM renamed_casted