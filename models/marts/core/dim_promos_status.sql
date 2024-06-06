with
        stg_users as (
        select * from {{ ref("stg_sql_server_promos_status") }} 
    )

select *
from stg_users