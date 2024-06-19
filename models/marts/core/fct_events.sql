with
        stg_events as (
        select 
        event_id,
           page_url,
           event_type_id,
           user_id,
           product_id,
           session_id,
           created_at,
           created_at_utc,
           order_id,
           _fivetran_deleted,
           _fivetran_synced_utc
         from {{ ref("stg_sql_server__events") }} 
    )

select *
from stg_events