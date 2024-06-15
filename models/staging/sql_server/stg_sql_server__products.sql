WITH src_products AS (
    SELECT * 
    FROM {{ ref('base_sql_server_products') }}
    ),


renamed_casted AS (
    SELECT product_id,
           price_product,
           name_product,
           inventory,
           category_id,
           coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted,
           CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC

    FROM src_products 
    )

SELECT * FROM renamed_casted

