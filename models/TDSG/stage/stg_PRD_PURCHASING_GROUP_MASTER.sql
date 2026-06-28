{{ config(materialized="table") }}

select

    coalesce(purchasinggroupkey, -1) as purchasinggroupkey,
    coalesce(spid, -1) as spid,
    coalesce(trim(groupcode), 'UNK') as groupcode,
    coalesce(trim(groupname), 'UNK') as groupname,
    coalesce(activeflag, -1) as activeflag,

    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as created_date

from {{ source("raw_data", "PRD_PURCHASING_GROUP_MASTER") }}
