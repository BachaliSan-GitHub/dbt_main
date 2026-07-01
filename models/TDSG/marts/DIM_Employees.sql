{{
    config(
        materialized='table'
    )
}}

select

    employeekey,
    departmentkey,
    reportingmanagerkey,
    plantkey,
    employeecode,
    employeename,
    costcenter,
    empdesignation,
    employeetype,
    roleid,
    isadmin,
    isvendorsync,
    createddate,
     {{ scd_dates() }},
    {{ is_current('dbt_valid_to') }}

from {{ ref('Employess_scd2') }}