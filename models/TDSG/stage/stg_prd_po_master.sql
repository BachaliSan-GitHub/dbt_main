{{ config(materialized="table") }}

select
    coalesce(nullif(trim(division),''), 'UNK')        as division,
    coalesce(nullif(trim(pornumber),''), 'UNK')       as pornumber,
    coalesce(porvalue, -1)                 as porvalue,
    coalesce(try_to_number(additionalcharge), -1)         as additionalcharge,
    coalesce(try_to_number(porrequester), -1)    as porrequester,
    coalesce(nullif(trim(ringino),''), 'UNK')          as ringino,
    coalesce(nullif(trim(spenddetails),''), 'UNK')     as spenddetails,
    coalesce(try_to_number(sappr), -1)            as sappr,
    coalesce(try_to_number(ponumber), -1)          as ponumber,

    coalesce(try_to_timestamp(podate, 'DD-MM-YYYY HH24:MI'), to_date('1900-01-01')) as podate,

    coalesce( try_to_timestamp(deliverydate, 'DD-MM-YYYY HH24:MI'),to_date('1900-01-01')) as deliverydate,

    coalesce(nullif(trim(vendorcode), ''),'UNK') as vendorcode,
    coalesce(nullif(trim(vendorname), ''),'UNK') as vendorname,
    coalesce(totalpovalue, -1) as total_povalue,
    coalesce(nullif(trim(currency),''), 'UNK') as currency,
    coalesce(try_to_number(exchangerate), -1) as exchangerate,
    coalesce(try_to_number("POValue(INR)"),-1) as povalueinr,
    coalesce(try_to_number(createdby), -1) as createdby

    

from {{ source("raw_data", "prd_po_master") }}
