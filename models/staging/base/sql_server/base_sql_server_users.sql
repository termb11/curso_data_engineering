WITH src_users_orders AS (
    SELECT user_id,
    count(*) as total_order
    FROM {{ source('sql_server', 'orders') }}
    group by user_id
    ),

users as (
    SELECT * 
    FROM {{ source('sql_server', 'users') }}
)

select  u.USER_ID
         , u.UPDATED_AT::date as UPDATED_AT
         , u.ADDRESS_ID
         , u.LAST_NAME
         , u.CREATED_AT::date as CREATED_AT
         , u.PHONE_NUMBER
         , coalesce(o.total_order,0) as TOTAL_ORDERS
         , u.FIRST_NAME
         , u.EMAIL
         ,coalesce(nullif(u._fivetran_deleted, ''), false) as _fivetran_deleted
         ,CONVERT_TIMEZONE('UTC',u._fivetran_synced) AS _fivetran_synced_UTC
from users u
left join src_users_orders o 
on u.user_id = o.user_id

