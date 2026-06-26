{{
    config(
        materialized='incremental',
        unique_key='claim_surrogate_key',
        incremental_strategy='merge'
    )
}}

select

    {{ generate_surrogate_key(['claim_id','policy_id']) }}
        as claim_surrogate_key,

    claim_id,
    policy_id,
    customer_id,
    
 COALESCE(
        TRY_TO_TIMESTAMP(claim_date, 'DD-MM-YYYY HH24:MI'),
        TRY_TO_TIMESTAMP(claim_date, 'DD-MM-YYYY')
    ) AS claim_date,

    claim_type,
    claim_status,
    severity_tier,

    gross_claim_amount,
    net_approved_amount,
    claim_net_payout_amount,

    is_approved,
    processing_days,

    current_timestamp() as dbt_updated_at,

    '{{ invocation_id }}' as dbt_run_id

from {{ ref('stg_raw_claims') }}

{% if is_incremental() %}

WHERE 
    COALESCE(
        TRY_TO_TIMESTAMP(updated_at, 'DD-MM-YYYY HH24:MI'),
        TRY_TO_TIMESTAMP(updated_at, 'DD-MM-YYYY')
    )
    >
    (
        SELECT MAX(dbt_updated_at)
        FROM {{ this }}
    )

{% endif %}