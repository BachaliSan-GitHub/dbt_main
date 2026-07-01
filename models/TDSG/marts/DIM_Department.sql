{{
    config(
        materialized='table'
    )
}}

select
    
    departmentkey,
    spid,
    costcenterkey,
    divisionkey,
    purchasinggroupkey,
    departmentname,
    departmenthead,
    activeflag,
    createddate,
    {{ scd_dates() }},
    {{ is_current('dbt_valid_to') }}


from {{ ref('department_scd2') }}