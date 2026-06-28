{{ config(materialized="table") }}

select

    coalesce(trim(division), 'UNK')        as division,
    coalesce(trim(pornumber), 'UNK')       as pornumber,
    coalesce(porvalue, -1)                 as porvalue,
    coalesce(try_to_number(additionalcharge), '-1')         as additionalcharge,
    coalesce(trim(porrequester), 'UNK')    as porrequester,
    coalesce(trim(ringino), 'UNK')          as ringino,
    coalesce(trim(spenddetails), 'UNK')     as spenddetails,
    coalesce(trim(sappr), 'UNK')            as sappr,
    coalesce(trim(ponumber), 'UNK')          as ponumber,

    coalesce( to_date(try_to_timestamp(podate, 'DD-MM-YYYY HH24:MI')), to_date('1900-01-01')) as podate,

    coalesce( to_date(try_to_timestamp(deliverydate, 'DD-MM-YYYY HH24:MI')),to_date('1900-01-01')) as deliverydate,

    coalesce(trim(vendorcode), 'UNK') as vendorcode,
    coalesce(trim(vendorname), 'UNK') as vendorname,
    coalesce(totalpovalue, -1) as total_povalue,
    coalesce(trim(currency), 'UNK') as currency,
    coalesce(try_to_number(exchangerate), -1) as exchangerate,
    coalesce(try_to_number("POValue(INR)"), -1) as povalueinr,
    coalesce(try_to_number(createdby), -1) as createdby,

    coalesce(to_date(try_to_timestamp(pipelinerundate, 'DD-MM-YYYY HH24:MI')),to_date('1900-01-01')) as pipelinerun_date

from {{ source("raw_data", "prd_po_master") }}
