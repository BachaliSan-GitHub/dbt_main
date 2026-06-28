{{ config(materialized="table") }}

select
  
    coalesce(try_to_number(porid), -1)                  as por_id,
    coalesce(try_to_number(preferredvendorid), -1)       as preferredvendorid,
    coalesce(try_to_number(plantid), -1)                 as plantid,
    coalesce(try_to_number(purchasinggroupid), -1)       as purchasinggroupid,
    coalesce(try_to_number(purchasingorgid), -1)         as purchasingorgid,
    coalesce(trim(porno), 'UNK')                         as por_no,
    coalesce(totalamount, 0)                             as totalamount,
    coalesce(trim(basecurrency), 'UNK')                  as basecurrency,
    coalesce(totalamount_inr, 0)                         as totalamountinr,
    coalesce(conversionrate, 0)                          as conversionrate,
    coalesce(try_to_number(departmentid), -1)            as departmentid,
    coalesce(try_to_number(issubmitted), -1)             as issubmitted,
    coalesce(trim(status), 'UNK')                        as status,
    coalesce(trim(option1), 'UNK')                       as option1,
    coalesce(trim(option2), 'UNK')                       as option2,
    coalesce(try_to_number(ringi_createdby), -1)         as ringi_createdby,
    coalesce(try_to_number(ringi_modifiedby), -1)        as ringi_modifiedby,
    coalesce(try_to_number(isdeleted), -1)               as isdeleted,
    coalesce(try_to_number(reviseno), -1)                as reviseno,
    coalesce(trim(sap_po), 'UNK')                        as sap_po,
    coalesce(trim(sap_pr), 'UNK')                        as sap_pr,
    coalesce(try_to_number(issynced), -1)                as issynced,
    coalesce(trim(sapissueorder), 'UNK')                 as sapissueorder,
    coalesce(trim(pono), 'UNK')                          as po_no,

   
    coalesce(
        to_date(try_to_timestamp(requireddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as required_date,

    coalesce(
        to_date(try_to_timestamp(ringi_resubmitteddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as ringi_resubmitted_date,

    coalesce(
        to_date(try_to_timestamp(ringi_submitteddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as ringi_submitted_date,

    coalesce(
        to_date(try_to_timestamp(ringi_createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as ringi_created_date,

    coalesce(
        to_date(try_to_timestamp(ringi_modifieddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as ringi_modified_date,

    coalesce(
        to_date(try_to_timestamp(podate, 'DD-MM-YYYY HH24:MI')), 
        to_date('1900-01-01')
    ) as po_date,

    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as created_date

from {{ source("raw_data", "STG_PORMASTER") }}
