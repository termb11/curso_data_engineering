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
created_at,
order_id
from stg_events