with
        stg_users as (
        select * from {{ ref("stg_sql_server__users") }} 
    )

select user_id,
last_name,
FIRST_NAME,
EMAIL,
phone_number,
created_at,
updated_at,
TOTAL_ORDERS 
from stg_users