WITH popular_products AS (
    SELECT
        e.product_id,
        COUNT(*) AS total_events
    FROM {{ ref("fct_events") }} e
    WHERE e.event_type_id = md5('page_view')
    GROUP BY e.product_id
    ORDER BY total_events DESC
),

sales_products AS (
    SELECT
        o.product_id,
        COUNT(*) AS total_checkouts
    FROM {{ ref("int_orders") }} o
    JOIN {{ ref("fct_events") }} e ON o.order_id = e.order_id
    WHERE e.event_type_id = md5('checkout')
    GROUP BY o.product_id
)

SELECT
    COALESCE(pp.product_id, sp.product_id) AS product_id,
    COALESCE(pp.total_events, 0) AS total_events,
    COALESCE(sp.total_checkouts, 0) AS total_checkouts
FROM popular_products pp
FULL OUTER JOIN sales_products sp ON pp.product_id = sp.product_id
ORDER BY total_events DESC
