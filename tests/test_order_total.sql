SELECT
    o.order_cost_usd,
    o.shipping_cost_usd,
    o.order_total_usd,
    p.discount_usd,
    ROUND(o.order_cost_usd + o.shipping_cost_usd - p.discount_usd, 2) as estimated_order_total
FROM {{ ref('stg_sql_server__orders') }} o
JOIN {{ ref('stg_sql_server__promos') }} p
ON o.promo_id=p.promo_id
WHERE estimated_order_total != o.order_total_usd