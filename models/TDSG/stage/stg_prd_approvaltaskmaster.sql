{{ config(materialized="table") }}

select

    coalesce(approvertaskid, -1) as approvertaskid,
    coalesce(nullif(trim(formtype),''), 'UNK') as formtype,
    coalesce(formid, -1) as formid,
    coalesce(assignedtouserid, -1) as assignedtouserid,
    coalesce(nullif(trim(delegateuserid),''), 'UNK') as delegateuserid,
    coalesce(nullif(trim(delegateby),''), 'UNK') as delegateby,
    coalesce(nullif(trim(delegateon),''), 'UNK') as delegateon,
    coalesce(nullif(trim(status),''), 'UNK') as status,
    coalesce(nullif(trim(role),''),'UNK') as role_des,
    coalesce(sequenceno, -1) as sequenceno,
    coalesce(nullif(trim(actiontakenby),''),'UNK')  as actiontakenby,
    coalesce(isactive, -1) as isactive,
     coalesce(createdby, -1) as createdby,
      coalesce(nullif(trim(modifiedby),''),'UNK') as modifiedby,

    coalesce(
            try_to_timestamp(actiontakendate, 'DD-MM-YYYY HH24:MI'),
           to_timestamp('1900-01-01 00:00:00')
        ) as actiontakendate,
       
        coalesce(
            try_to_timestamp(src_createddate, 'DD-MM-YYYY HH24:MI'),
            to_timestamp('1900-01-01 00:00:00')
        ) as src_createddate,
       
        coalesce(
            try_to_timestamp(modifieddate, 'DD-MM-YYYY HH24:MI'),
           to_timestamp('1900-01-01 00:00:00')
        ) as modifieddate,
        
        coalesce(
            try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI'),
           to_timestamp('1900-01-01 00:00:00')
        ) as createddate

        from {{ source("raw_data", "prd_approvaltaskmaster") }}
