with
        stg_seller as (
        select * from {{ ref("stg_sql_server__sellers") }} 
    )

select *
from stg_seller