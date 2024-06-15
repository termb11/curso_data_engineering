with
        stg_promos as (
        select * from {{ ref("stg_sql_server__promos") }} 
    )

select promo_name,
promo_id,
discount_usd
from stg_promos