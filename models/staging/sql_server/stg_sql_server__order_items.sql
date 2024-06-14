{{
    config(
        materialized='incremental',
        unique_key='order_item_id',
        tags='incremental'
    )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server', 'order_items') }}
    ),

renamed_casted AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['order_id', 'product_id'])}} as order_item_id
        , order_id
        , PRODUCT_ID
        , QUANTITY
        , coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted
        , SUM(quantity)OVER(PARTITION BY order_id) as products_per_order
        , CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC
    FROM src_order_items
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}