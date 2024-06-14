{{
    config(
        materialized='incremental',
        unique_key='order_id',
        tags='incremental'
    )
}}


WITH src_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_orders') }}
    ),

renamed_casted AS (
    SELECT order_id,
           shipping_service_id,
           shipping_cost_usd,
           address_id,
            case when estimated_delivery_at<delivery_at then 'delayed'
            when estimated_delivery_at>delivery_at then 'earlier than expected'
            when estimated_delivery_at=delivery_at then 'on time'
            else 'not delivered'
            end as delivery_details,
           promo_id,
           estimated_delivery_at,
           order_cost_usd,
           user_id, 
           created_at,
           order_total_usd,
           delivery_at,
           status_id,
           _fivetran_deleted,
           _fivetran_synced_utc

    FROM src_orders
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}