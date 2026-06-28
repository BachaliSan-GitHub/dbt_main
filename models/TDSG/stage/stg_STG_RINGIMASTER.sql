{{
    config(
        materialized='table'
    )
}}

select

    coalesce(ringikey, -1) as ringikey,
    coalesce(departmentkey, -1) as departmentkey,
    coalesce(ringiapprovalitemid, -1) as ringiapprovalitemid,
    coalesce(trim(ringino), 'UNK') as ringino,
    coalesce(trim(tempringino), 'UNK') as tempringino,
    coalesce(plantkey, -1) as plantkey,
    coalesce(trim(categorytype), 'UNK') as categorytype,
    coalesce(amount, -1) as amount,
    coalesce(trim(basecurrency), 'UNK') as basecurrency,
    coalesce(totalamount_inr, -1) as totalamountinr,
    coalesce(conversionrate, -1) as conversionrate,
    coalesce(trim(ringilevel), 'UNK') as ringilevel,
    coalesce(trim(poroption), 'UNK') as poroption,
    coalesce(trim(status), 'UNK') as status,
    issubmitted as is_submitted,
    issubringi as is_subringi,
    coalesce(try_to_number(createdby), -1) as createdby,
    coalesce(try_to_number(modifiedby), -1) as modifiedby,
    coalesce(
        to_date(try_to_timestamp(submitteddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as submitted_date,
   
    coalesce(
        to_date(try_to_timestamp(src_createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as src_created_date,

    coalesce(
        to_date(try_to_timestamp(modifieddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as modifieddate,

    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as createddate


from {{ source("raw_data", "STG_RINGIMASTER") }}
