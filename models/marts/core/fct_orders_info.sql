with
        fct_orders_i as (
        select * from {{ ref("int_orders") }} 
    )

select order_id,
       shipping_service_id,
       status_id,
       delivery_details_id,
       created_at,
       delivered_at,
       estimated_delivery_at,
       days_after,
       days_before
from fct_orders_i