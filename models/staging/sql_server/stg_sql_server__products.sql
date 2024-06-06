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
    SELECT PRODUCT_ID,
    PRICE,
    NAME as name_product,
    INVENTORY,
    coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC
    FROM src_products
    )

SELECT * FROM renamed_casted