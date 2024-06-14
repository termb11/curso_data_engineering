{{
    config(
        materialized='incremental',
        unique_key='address_id',
        tags='incremental'
    )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server', 'addresses') }}
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

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}
    