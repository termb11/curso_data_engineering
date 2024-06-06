with
        stg_promos as (
        select * from {{ ref("stg_sql_server__promos") }} 
    )

select promo_name,
promo_id,
status_id,
discount_euros
from stg_promos