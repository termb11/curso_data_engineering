with
        stg_date as (
        select * from {{ ref("stg_sql_server_shipping") }} 
    )

select *
from stg_date