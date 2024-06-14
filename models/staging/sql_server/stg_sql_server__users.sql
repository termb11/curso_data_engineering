{{
    config(
        materialized='incremental',
        unique_key='user_id',
        tags='incremental'
    )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ ref('base_sql_server_users') }}
    ),

renamed_casted AS (
    SELECT *
    FROM src_users
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}