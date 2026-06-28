{{ config(materialized="table") }}


select

    coalesce(id, -1)                    as id,
    coalesce(kpiyear, -1)               as kpiyear,
    coalesce(kpimonth, -1)              as kpimonth,
    coalesce(trim(kpi), 'UNK')          as kpi,
    coalesce(target, -1)                as target,
    coalesce( to_date(try_to_timestamp(createdat, 'DD-MM-YYYY HH24:MI')),to_date('1900-01-01')) as created_at,
    coalesce(isactive, -1)              as is_active

from {{ source("raw_data", "KPIIndicator") }}
