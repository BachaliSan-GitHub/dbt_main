{{ config(materialized="table") }}


select

    coalesce(ringipormapkey, -1) as ringi_por_mapkey,
    coalesce(porid, -1) as por_id,
    coalesce(ringiid, -1) as ringi_id,
    coalesce(try_to_number(finalvendorid), -1) as final_vendor_id,
    isdeleted as is_deleted,
    coalesce(try_to_number(amount), -1) as amount,

    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as created_date

from {{ source("raw_data", "RINGIPORMAP") }}
