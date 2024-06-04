
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
    COALESCE(NULLIF(shipping_service,''),'unknown') AS shipping_service,
    md5(COALESCE(NULLIF(shipping_service,''),'unknown')) AS shipping_service_id,
    shipping_cost,
    address_id,
    case when promo_id='' then md5('unknown')
         else md5(promo_id)
    end as promo_id,
    CONVERT_TIMEZONE('UTC',estimated_delivery_at) AS estimated_delivery_at_UTC,
    order_cost,
    user_id,
    order_total,
    CONVERT_TIMEZONE('UTC',delivered_at) AS delivery_at_UTC,
    tracking_id,
    status,
    case when status='delivered' then md5('delivered')
         when status='preparing' then md5('preparing')
         when status='shipped' then md5('shipped')
         else status
    end as status_id,
    case when _fivetran_deleted is null then false
         else _fivetran_deleted
    end as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC',_fivetran_synced) AS _fivetran_synced_UTC
    FROM src_orders
    )

SELECT *
FROM renamed_casted