{{ config(materialized="table") }}


select

    coalesce(id, -1)                    as id,
    coalesce(kpiyear, -1)               as kpiyear,
    coalesce(kpimonth, -1)              as kpimonth,
    coalesce(nullif(trim(kpi),''), 'UNK')          as kpi,
    coalesce(target, -1)                as target,
    coalesce( try_to_timestamp(createdat, 'DD-MM-YYYY HH24:MI'),to_timestamp('1900-01-01 00:00:00')) as createdat,
    coalesce(nullif(trim(isactive), ''),'UNK')as is_active

from {{ source("raw_data", "KPIIndicator") }}
