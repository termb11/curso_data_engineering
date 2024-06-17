WITH src_promos AS (
    SELECT * 
    FROM {{ ref('base_sql_server_promos') }}
    ),

renamed_casted AS (
    SELECT promo_name,
    promo_id,
    discount_usd,
    status_id,
    coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC',_FIVETRAN_SYNCED) as _FIVETRAN_SYNCED_UTC
    from src_promos
    union all
    select 'unknown',
    md5('unknown'),
    0,
    1,
    false,
    CONVERT_TIMEZONE('UTC',current_date),
    )

SELECT * FROM renamed_casted

