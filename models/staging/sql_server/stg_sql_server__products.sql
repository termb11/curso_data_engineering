{{
    config(
        materialized='incremental',
        unique_key='product_id',
        tags='incremental'
    )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server', 'products') }}
    ),


categories as (
    SELECT * 
    FROM {{ ref('stg_sql_server__categories') }}
),


renamed_casted AS (
    SELECT p.PRODUCT_ID,
    p.PRICE,
    p.NAME as name_product,
    p.INVENTORY,
    c.category_id,
    coalesce(nullif(p._fivetran_deleted, ''), false) as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC',p._fivetran_synced) AS _fivetran_synced_UTC,
    FROM src_products p
    join categories c
    on c.category_name=p.category
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}