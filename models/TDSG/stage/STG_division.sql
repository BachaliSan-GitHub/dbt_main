{{
    config(
        materialized='table'
    )
}}

select

    coalesce(divisionkey, -1)                             as divisionkey,
    coalesce(spid, -1)                                    as spid,
   coalesce(nullif(trim(divisionshortcode), ''), 'UNK') as divisionshortcode,
    coalesce(divisionhead, -1)                            as divisionhead,
    coalesce(nullif(trim(divisionname), ''), 'UNK') as divisionname,
     coalesce(activeflag, 0) as activeflag,
   coalesce(
    try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI'),
    to_timestamp('1900-01-01 00:00:00')
) as createddate

from {{ source("raw_data", "Division") }}
