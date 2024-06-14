with
        stg_date as (
        select * from {{ ref("stg_sql_server__categories") }} 
    )

select *
from stg_date