{{ config(materialized="table") }}

select

    coalesce(approvertaskid, -1) as approvertaskid,
    coalesce(trim(formtype), 'UNK') as formtype,
    coalesce(formid, -1) as formid,
    coalesce(assignedtouserid, -1) as assignedtouserid,
    coalesce(try_to_number(delegateuserid), -1) as delegateuserid,
    coalesce(try_to_number(delegateby), '-1') as delegateby,
    coalesce(try_to_number(delegateon), '-1') as delegateon,
    coalesce(trim(status), 'UNK') as status,
    coalesce(trim(role), 'UNK') as role_des,
    coalesce(sequenceno, -1) as sequenceno,
    coalesce(try_to_number(actiontakenby), '-1') as actiontakenby,
    coalesce(
            to_date(try_to_timestamp(actiontakendate, 'DD-MM-YYYY HH24:MI')),
            to_date('1900-01-01')
        ) as actiontakendate,
        coalesce(createdby, -1) as createdby,
        coalesce(
            to_date(try_to_timestamp(src_createddate, 'DD-MM-YYYY HH24:MI')),
            to_date('1900-01-01')
        ) as src_createddate,
        coalesce(try_to_number(modifiedby), '-1') as modifiedby,
        coalesce(
            to_date(try_to_timestamp(modifieddate, 'DD-MM-YYYY HH24:MI')),
            to_date('1900-01-01')
        ) as modifieddate,
        coalesce(isactive, -1) as isactive,
        coalesce(
            to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
            to_date('1900-01-01')
        ) as createddate

        from {{ source("raw_data", "prd_approvaltaskmaster") }}
