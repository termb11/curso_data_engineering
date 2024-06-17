{{ config(
    materialized='incremental',
    unique_key = 'address_id'
    ) 
    }}

WITH src_addresses AS (
    SELECT * 
    FROM {{ ref('base_sql_server_addresses') }}
    ),

renamed_casted AS (
    SELECT address_id,
    zipcode,
    country,
    address,
    state,
    coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted,
     CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC
    FROM src_addresses
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced_utc) from {{ this }})

{% endif %}