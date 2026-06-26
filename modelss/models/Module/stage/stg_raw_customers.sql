{{
    config(
        materialized='table'
    )
}}

select 
customer_id,
concat(first_name,last_name) as full_name ,
TO_DATE(date_of_birth, 'DD-MM-YYYY') AS date_of_birth,
gender,
email,
phone,
address,
city,
state,
zip_code,
TO_DATE(customer_since,'DD-MM-YYYY')as customer_since,
credit_score,
risk_tier,
DATEDIFF(
        year,
        TO_DATE(date_of_birth, 'DD-MM-YYYY'),
        CURRENT_DATE()
    ) AS customer_age,

created_at,
updated_at, 
 CURRENT_TIMESTAMP() AS loaded_at,


  case
        when credit_score < 650
             or risk_tier = 'High'
        then true
        else false
    end as is_high_risk,

case
        when gender = 'M' then 'Male'
        when gender = 'F' then 'Female'
        else 'Unknown'
    end as gender_label,

  case
        when datediff(year, TO_DATE(date_of_birth, 'DD-MM-YYYY'), current_date()) < 30 then 'Youth'
        when datediff(year, TO_DATE(date_of_birth, 'DD-MM-YYYY'), current_date()) <= 60 then 'Adult'
        else 'Senior'
    end as age_band,


from {{ source('insurance_raw', 'raw_customers') }}