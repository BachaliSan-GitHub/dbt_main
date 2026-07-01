{{ config(materialized="table") }}

select

    coalesce(purchasinggroupkey, -1) as purchasinggroupkey,
    coalesce(spid, -1) as spid,
    coalesce(nullif(trim(groupcode),''), 'UNK') as groupcode,
    coalesce(nullif(trim(groupname),''), 'UNK') as groupname,
    coalesce(try_to_number(activeflag), 0) as activeflag,
    coalesce(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI'), to_timestamp('1900-01-01 00:00:00')) as createddate

from {{ source("raw_data", "PRD_PURCHASING_GROUP_MASTER") }}
 