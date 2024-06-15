WITH src_prod AS (
    SELECT * 
    FROM {{ source('sql_server', 'products') }}
    )

SELECT product_id,
       price as price_product,
       name as name_product,
       inventory,
       category,
       {{dbt_utils.generate_surrogate_key(['category'])}} as category_id,
       _fivetran_deleted,
       _fivetran_synced
FROM src_prod