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
_fivetran_synced_utc
from stg_users
