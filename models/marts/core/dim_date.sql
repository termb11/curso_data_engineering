with
        stg_date as (
        select * from {{ ref("stg_sql_server_dates") }} 
    )

select *
from stg_date