{{ config(
    materialized='incremental',
    unique_key = 'user_id'
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

  where _fivetran_synced_utc > (select max(_fivetran_synced_utc) from {{ this }})

{% endif %}