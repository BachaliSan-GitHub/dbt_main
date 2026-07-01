{{
    config(
        materialized='table'
    )
}}

select
    divisionkey,
    spid,
    divisionshortcode,
    divisionname,
    divisionhead,
    deputydivisionhead,
    activeflag ,
    createddate,
     {{ scd_dates() }},
    {{ is_current('dbt_valid_to') }}

from {{ ref('division_scd2') }}