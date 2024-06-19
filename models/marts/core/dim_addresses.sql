{{ config(
    materialized='incremental',
    unique_key = 'address_id'
    ) 
    }}

with
        stg_address as (
        select * from {{ ref("stg_sql_server__addresses") }} 
    )

select address_id,
zipcode,
country,
address,
state,
_fivetran_synced_utc
from stg_address

{% if is_incremental() %}

  where _fivetran_synced_utc > (select max(_fivetran_synced_utc) from {{ this }})

{% endif %}