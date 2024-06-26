
{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server', 'orders') }}
    ),

renamed_casted AS (
    SELECT order_id,
    seller_id,
    COALESCE(NULLIF(shipping_service,''),'unknown') AS shipping_service,
    md5(COALESCE(NULLIF(shipping_service,''),'unknown')) AS shipping_service_id,
    shipping_cost as shipping_cost_usd,
    address_id,
    case when promo_id='' then md5('unknown')
         else md5(promo_id)
    end as promo_id,
    case when estimated_delivery_at<delivered_at then 'delayed'
            when estimated_delivery_at>delivered_at then 'earlier than expected'
            when estimated_delivery_at=delivered_at then 'on time'
            else 'not delivered'
    end as delivery_details,
    md5(delivery_details) as delivery_details_id,
    CONVERT_TIMEZONE('UTC',estimated_delivery_at)::date AS estimated_delivery_at,
    order_cost as order_cost_usd,
    user_id,
    created_at::date as created_at,
    order_total as order_total_usd,
    CONVERT_TIMEZONE('UTC',delivered_at)::date AS delivered_at,
    nullif(tracking_id, '') as tracking_id,
    status,
    case when status='delivered' then md5('delivered')
         when status='preparing' then md5('preparing')
         when status='shipped' then md5('shipped')
         else status
    end as status_id,
    CASE
        WHEN delivered_at > estimated_delivery_at THEN DATEDIFF(day, estimated_delivery_at, delivered_at)
        ELSE 0
    END AS days_after,
    CASE
        WHEN delivered_at < estimated_delivery_at THEN DATEDIFF(day, delivered_at, estimated_delivery_at)
        ELSE 0
    END AS days_before,
    coalesce(nullif(_fivetran_deleted, ''), false) as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC
    FROM src_orders
    )

SELECT *
FROM renamed_casted