{{ config(materialized='view') }}

SELECT

    *,

    (por_value - total_povalue) AS cost_saving,

    CASE 
        WHEN por_value = 0 OR por_value IS NULL THEN 0
        ELSE ((por_value - total_povalue) / por_value) * 100
    END AS cost_saving_pct,

    COALESCE(grn_quantity + pending_qty, 0) AS total_order_qty,


    COALESCE(grn_quantity, 0) AS actual_order_qty,

    CASE 
        WHEN grn_date IS NOT NULL 
             AND delivery_date IS NOT NULL 
             AND grn_date <= delivery_date
        THEN 1
        ELSE 0
    END AS on_time_grn,

   
    CASE 
        WHEN pending_qty > 0 THEN 1
        ELSE 0
    END AS pending_grn,


    CASE 
        WHEN (grn_quantity + pending_qty) = 0 THEN 0
        ELSE (grn_quantity / (grn_quantity + pending_qty)) * 100
    END AS delivery_performance,


    DATEDIFF('day', created_date, ringi_submitted_date) AS tat_days,


    CASE 
        WHEN DATEDIFF('day', created_date, ringi_submitted_date) < 5 THEN 'Less than 5 days'
        WHEN DATEDIFF('day', created_date, ringi_submitted_date) BETWEEN 5 AND 7 THEN '5 to 7 days'
        ELSE 'More than 7 days'
    END AS tat_bucket

FROM {{ ref('INT_fact_joins') }}