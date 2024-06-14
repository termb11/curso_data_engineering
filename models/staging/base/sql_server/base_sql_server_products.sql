WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server', 'products') }}
    )

SELECT product_id,
       price,
       name,
       inventory,
       category,
       _fivetran_deleted,
       _fivetran_synced
FROM src_promos