WITH user_sessions AS (
    SELECT
        user_id,
        session_id,
        MIN(created_at_utc) AS session_start_time,
        MAX(created_at_utc) AS session_end_time,
        DATEDIFF(minute, MIN(created_at_utc), MAX(created_at_utc)) AS duration_session_min,
    FROM {{ ref("fct_events") }} 
    GROUP BY user_id, session_id
),

events_with_session_info AS (
    SELECT
        e.user_id,
        e.session_id,
        e.duration_session_min,
        a.checkout_amount,
        a.package_shipped_amount,
        a.add_to_cart_amount,
        a.page_view_amount
    FROM user_sessions e
    JOIN {{ ref("int_amount_events") }} a ON e.user_id = a.user_id
)

SELECT *
FROM events_with_session_info
