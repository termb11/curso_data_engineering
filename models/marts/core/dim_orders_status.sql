with
        stg_address as (
        select * from {{ ref("stg_sql_server_orders_status") }} 
    )

select *
from stg_address