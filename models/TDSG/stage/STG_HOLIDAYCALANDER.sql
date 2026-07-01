{{
    config(
        materialized='table'
    )
}}

select 

  try_to_date(holidaydate,'DD-MM-YYYY') as holidaydate,
    coalesce(id,-1) as id


from {{ source('raw_data', 'HOLIDAYCALANDER') }}