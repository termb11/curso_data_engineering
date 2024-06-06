with
        stg_address as (
        select * from {{ ref("stg_sql_server__addresses") }} 
    )

select address_id,
zipcode,
country,
address,
state
from stg_address