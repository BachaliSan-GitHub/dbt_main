{{
    config(
        materialized='table'
    )
}}

select

    coalesce(ringikey, -1) as ringikey,
    coalesce(departmentkey, -1) as departmentkey,
    coalesce(ringiapprovalitemid, -1) as ringiapprovalitemid,
    coalesce(nullif(trim(ringino),''),'UNK') as ringino,
    coalesce(nullif(trim(tempringino),''), 'UNK') as tempringino,
    coalesce(try_to_number(plantkey), -1) as plantkey,
    coalesce(try_to_number(categorytype), -1) as categorytype,
    coalesce(amount, -1) as amount,
    coalesce(trim(basecurrency), 'UNK') as basecurrency,
    coalesce(totalamount_inr, -1) as totalamount_inr,
    coalesce(conversionrate, -1) as conversionrate,
    coalesce(try_to_number(ringilevel), -1) as ringilevel,
    coalesce(try_to_number(poroption), -1) as poroption,
    coalesce(trim(status), 'UNK') as status,
    coalesce(try_to_number(issubmitted) ,0)  as is_submitted,
    coalesce(try_to_number(issubringi),0) as is_subringi,
    coalesce(try_to_number(createdby), -1) as createdby,
    coalesce(try_to_number(modifiedby), -1) as modifiedby,
    coalesce(
        try_to_timestamp(submitteddate, 'DD-MM-YYYY HH24:MI'),
        to_date('1900-01-01 00:00:00')
    ) as submitteddate,
   
    coalesce(
        try_to_timestamp(src_createddate, 'DD-MM-YYYY HH24:MI'),
        to_date('1900-01-01 00:00:00')
    ) as src_createddate,

    coalesce(
        try_to_timestamp(modifieddate, 'DD-MM-YYYY HH24:MI'),
        to_date('1900-01-01 00:00:00')
    ) as modifieddate,

    coalesce(
        try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI'),
        to_date('1900-01-01')
    ) as createddate


from {{ source("raw_data", "STG_RINGIMASTER") }}
