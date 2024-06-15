WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server', 'promos') }}
    ),

renamed_casted AS (
    SELECT promo_id as promo_name,
    MD5(promo_id) as promo_id,
    status,
    case when status='active' then 1
    else 0
    end as status_id,
    discount as discount_usd,
    _fivetran_deleted,
    _FIVETRAN_SYNCED
    from src_promos
    )

SELECT * FROM renamed_casted
