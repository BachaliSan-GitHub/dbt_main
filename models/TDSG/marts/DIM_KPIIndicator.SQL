{{ config(
    materialized='table'
) }}

select

    id                  as kpikey,
    kpiyear,
    kpimonth,
    kpi,
    target,
    createdat,
    is_active,

    current_timestamp() as lastupdateddate

from {{ ref('stg_KPIIndicator') }}