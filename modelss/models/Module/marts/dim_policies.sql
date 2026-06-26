{{
    config(
        materialized='table'
    )
}}

WITH latest_policy AS (
    SELECT
        policy_id,
        policy_number,
        policy_type,
        status,
        premium_amount,
        coverage_amount,
        updated_at,

        ROW_NUMBER() OVER (
            PARTITION BY policy_id
            ORDER BY updated_at DESC
        ) AS rn

    FROM {{ ref('stg_raw_policies') }}
)

SELECT
    MD5(CAST(policy_id AS VARCHAR)) AS policy_dim_key,

    policy_id,
    policy_number,
    policy_type,
    status,
    premium_amount,
    coverage_amount,


    CURRENT_TIMESTAMP() AS dbt_updated_at,
    'stg_policies' AS record_source

FROM latest_policy
WHERE rn = 1   
