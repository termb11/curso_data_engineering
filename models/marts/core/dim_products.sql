with
        stg_users as (
        select * from {{ ref("stg_sql_server__products") }} 
    )

select product_id,
price_product,
name_product,
INVENTORY
from stg_users