select

    coalesce(try_to_number(id), -1) as id,
    coalesce(try_to_number(historyid), -1) as historyid,
    coalesce(try_to_number(formid), -1) as formid,
    coalesce(nullif(trim(formtype),''), 'UNK') as formtype,
    coalesce(nullif(trim(status),''), 'UNK') as status,
    coalesce(try_to_number(actiontakenbyuserid), -1) as actiontakenbyuserid,
    coalesce(nullif(trim(role),''), 'UNK') as role_desc,
    coalesce(nullif(trim(actiontype),''), 'UNK') as actiontype,
    coalesce(try_to_number(delegateuserid), -1) as delegateuserid,
    coalesce(try_to_number(isactive), 0) as isactive,

coalesce(
    to_date(
        try_to_timestamp(actiontakendatetime, 'DD-MM-YYYY HH24:MI')
    ),
    to_date('1900-01-01')
) as actiontakendatetime,
   coalesce(
    to_date(
        try_to_timestamp(createdat, 'DD-MM-YYYY HH24:MI')
    ),
    to_date('1900-01-01')
) as createdat

from {{ source("raw_data", "STG_MANAGEHISTORYMASTER") }}
