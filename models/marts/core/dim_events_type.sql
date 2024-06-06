with
        stg_events as (
        select * from {{ ref("stg_sql_server_events_types") }} 
    )

select *
from stg_events