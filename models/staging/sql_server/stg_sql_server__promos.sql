{{
    config(
        materialized='incremental',
        unique_key='promo_id',
        tags='incremental'
    )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ ref('base_sql_server_promos') }}
    ),

renamed_casted AS (
    SELECT promo_name,
           promo_id,
           status_id,
           discount_usd,
           _fivetran_deleted,
           _fivetran_synced_utc
    FROM src_promos
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}