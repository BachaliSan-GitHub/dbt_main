{{ config(materialized="table") }}

select
    
    coalesce(nullif(trim(purchasername),''), 'UNK')     as purchasername,
    coalesce(try_to_number(purchaserid), -1) as purchaserid,
    coalesce(nullif(trim(division),''),'UNK')          as division,
    coalesce(nullif(trim(department),''), 'UNK')        as department,
    coalesce(isactive, false)                as is_active,                        
    coalesce(try_to_number(quarter), -1) as quarter,
   coalesce(try_to_number(year), -1)        as year,             
    coalesce(try_to_number(id), -1)          as id,      

   
    coalesce(
        try_to_timestamp(fromdate, 'DD-MM-YYYY HH24:MI'),  to_timestamp('1900-01-01 00:00:00')
    ) as fromdate,

    coalesce(
        to_date(todate, 'DD-MM-YYYY HH24:MI'),  to_timestamp('1900-01-01 00:00:00')
    ) as todate,

    coalesce(
        try_to_timestamp(startdate, 'DD-MM-YYYY HH24:MI'),
         to_timestamp('1900-01-01 00:00:00')
    ) as startdate,

    coalesce(
        try_to_timestamp(modifieddate, 'DD-MM-YYYY HH24:MI'),
         to_timestamp('1900-01-01 00:00:00')
    ) as modifieddate,

    coalesce(
       try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI'),
         to_timestamp('1900-01-01 00:00:00')
    ) as createddate

from {{ source("raw_data", "PURCHASERHANDLINGDIVISION_PRD") }}