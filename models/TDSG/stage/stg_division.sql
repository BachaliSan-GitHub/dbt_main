{{
    config(
        materialized='table'
    )
}}

select

    coalesce(divisionkey, -1)                             as division_key,
    coalesce(spid, -1) as spid,
    coalesce(trim(divisionshortcode), 'UNK')              as division_short_code,
    coalesce(trim(divisionname), 'UNK')                   as division_name,
    coalesce(divisionhead, -1)                            as division_head,
    coalesce(deputydivisionhead, -1)                     as deputy_division_head,
    coalesce(activeflag, -1)                             as active_flag,
    coalesce(to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')), to_date('1900-01-01')) as created_date

from {{ source("raw_data", "Division") }}
