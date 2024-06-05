with
        stg_users as (
        select * from {{ ref("base_sql_server_users") }} 
    ),

    renamed_casted as (
        select distinct
            user_id,
            first_name,
            last_name,
            email,
            phone_number,
            total_orders
        from stg_users
    )

select *
from renamed_casted