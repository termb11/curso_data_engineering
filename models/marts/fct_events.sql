with
        stg_events as (
        select * from {{ ref("stg_sql_server__events") }} 
    )

select event_id,
page_url,
event_type_id,
user_id,
product_id,
session_id,
date_id,
order_id
from stg_events