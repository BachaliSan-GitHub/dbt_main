{{ config(materialized="table") }}

select
    
    coalesce(trim(purchasername), 'UNK')     as purchaser_name,
    coalesce(try_to_number(purchaserid), -1) as purchaser_id,
    coalesce(trim(division), 'UNK')          as division,
    coalesce(trim(department), 'UNK')        as department,
    isactive                                 as is_active,      
    coalesce(trim(quarter), 'UNK')           as quarter,         
    coalesce(try_to_number(year), -1)        as year,             
    coalesce(try_to_number(id), -1)          as id,               

   
    coalesce(
        to_date(try_to_timestamp(fromdate, 'DD-MM-YYYY HH24:MI')), to_date('1900-01-01')
    ) as from_date,

    coalesce(
        to_date(try_to_timestamp(todate, 'DD-MM-YYYY HH24:MI')), to_date('1900-01-01')
    ) as to_date,

    coalesce(
        to_date(try_to_timestamp(startdate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as start_date,

    coalesce(
        to_date(try_to_timestamp(modifieddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as modified_date,

    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as created_date

from {{ source("raw_data", "PURCHASERHANDLINGDIVISION_PRD") }}