{{ config(materialized="table") }}


select

    coalesce(
        to_date(try_to_timestamp(holidaydate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as holiday_date,

    coalesce(id, -1) as id

from {{ source("raw_data", "HolidayCalander") }}
