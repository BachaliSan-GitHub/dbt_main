{{
    config(
        materialized='table'
    )
}}

select 

claim_id,
policy_id,
customer_id,
claim_number,
claim_date,
incident_date,
claim_type,
claim_status,
claim_amount as gross_claim_amount,
approved_amount as net_approved_amount,
(approved_amount - deductible)  as claim_net_payout_amount,
datediff(day, TO_DATE(claim_date,'DD-MM-YYYY'), TO_DATE(resolution_date,'DD-MM-YYYY')) as processing_days,
deductible,
adjuster_id,
description,
resolution_date,
created_at,updated_at,
 case
    when claim_status ='Approved' then true
    else false
end as is_approved,

 case
        when approved_amount < 3000 then 'Low'
        when approved_amount >= 3000 and approved_amount <= 10000 then 'Medium'
        when approved_amount > 10000 then 'High'
        else 'Unknown'
    end as severity_tier

from {{ source('insurance_raw', 'raw_claims') }}