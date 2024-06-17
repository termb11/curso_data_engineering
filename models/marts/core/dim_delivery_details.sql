with
        stg_date as (
        select * from {{ ref("stg_sql_server__delivery_details") }} 
    )

select *
from stg_date