WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server', 'promos') }}
    ),

renamed_casted AS (
    SELECT promo_id as promo_name,
    MD5(promo_id) as promo_id,
    status,
    discount as discount_euros,
    case when status='active' then 1
        else 0
    end as status_id
    , case when _FIVETRAN_DELETED is null then false
    else _fivetran_deleted
    end as _fivetran_deleted
    , CONVERT_TIMEZONE('UTC',_FIVETRAN_SYNCED) as _FIVETRAN_SYNCED_UTC
    from src_promos
    union all
    select 'unknown',
    md5('unknown'),
    'active',
    0,
    1,
    false,
    CONVERT_TIMEZONE('UTC',current_date),
    )

SELECT * FROM renamed_casted
