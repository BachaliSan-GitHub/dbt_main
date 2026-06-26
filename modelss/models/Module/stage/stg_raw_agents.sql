{{
    config(
        materialized='table'
    )
}}

select 
agent_id,
agent_name,
agent_email,
region,

DATEDIFF(
        year,
        TO_DATE(hire_date, 'DD-MM-YYYY'),
        CURRENT_DATE()
    ) AS tenure_years,

concat(cast(commission_rate *100 as varchar),'%') as commission_pct,
cast(is_active as boolean) as is_active_agent ,
manager_id,
created_at


from {{ source('insurance_raw', 'raw_agents') }}