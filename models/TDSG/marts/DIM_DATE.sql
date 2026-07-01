{{ config(materialized='table') }}

select

    datekey,
    fulldate,
    day,
    month,
    quarter,
    year,
    dayofweek,
    dayname,
    isweekend,
    isholiday,
    isworkingday,

    current_timestamp() as lastupdateddate

from {{ ref('date_join') }}