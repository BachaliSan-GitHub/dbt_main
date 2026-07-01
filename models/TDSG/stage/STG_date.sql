{{ config(materialized="table") }} 


select

FULL_DATE,
DAY_OF_MONTH,
IS_WEEKDAY,
MONTH,
YEAR,
QUARTER,
IS_HOLIDAY,
IS_WORKING_DAY

from {{ source("raw_data", "DATE") }}
