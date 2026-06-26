{{
    config(
        materialized='ephemeral'
    )
}}

WITH policies_data AS (
    SELECT * FROM {{ ref('stg_raw_policies') }}
),

claim_data AS (
    SELECT * FROM {{ ref('stg_raw_claims') }}
),

customer_data AS (
    SELECT * FROM {{ ref('stg_raw_customers') }}
),

agent_data AS (
    SELECT * FROM {{ ref('stg_raw_agents') }}
),

final_data AS (
    SELECT 
        p.policy_id,
        p.customer_id,
        p.agent_id,

        COUNT(cl.claim_id) AS claim_frequency,

        AVG(
            cl.net_approved_amount / NULLIF(cl.gross_claim_amount, 0)
        ) AS loss_ratio

    FROM policies_data p  
    LEFT JOIN claim_data cl 
        ON p.policy_id = cl.policy_id

    LEFT JOIN customer_data cu 
        ON cu.customer_id = p.customer_id

    LEFT JOIN agent_data a  
        ON a.agent_id = p.agent_id

    GROUP BY
        p.policy_id,
        p.customer_id,
        p.agent_id
)

SELECT *,
    CASE
        WHEN claim_frequency >= 2 THEN 'High Frequency'
        ELSE 'Normal'
    END AS claim_trend

FROM final_data