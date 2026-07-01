{{ config(materialized="table") }}


select

    coalesce(try_to_number(ringipormapkey), -1) as ringipormapkey,
    coalesce(try_to_number(porid), -1) as porid,
    coalesce(try_to_number(ringiid), -1) as ringiid,
    coalesce(try_to_number(finalvendorid), -1) as finalvendorid,
    coalesce(try_to_number(isdeleted), 0) as isdeleted,
    coalesce(try_to_number(amount), -1) as amount,
    coalesce(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI'),to_timestamp('1900-01-01 00:00:00')) as createddate

from {{ source("raw_data", "RINGIPORMAP") }}
