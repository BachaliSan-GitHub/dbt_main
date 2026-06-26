{{
    config(
        materialized='table',
        database='DB_NAME',
        schema='STAGE'
        
    )
}}

select 
policy_id,
customer_id,
policy_number,
policy_type,


DATEDIFF(
        day,
        TO_DATE(start_date, 'DD-MM-YYYY'),
        TO_DATE(end_date, 'DD-MM-YYYY')
    ) AS policy_duration_days,

cast(premium_amount as NUMERIC(12,2))     as premium_amount ,
cast(coverage_amount as NUMERIC(12,2))    as coverage_amount,
status,
agent_id,
created_at,
updated_at,
current_timestamp() as loaded_at ,
'insurance_core' as source_system


from {{ source('insurance_raw', 'raw_policies') }}