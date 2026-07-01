{{ config(materialized="table") }}

select

    coalesce(spid, -1)                                  as spid,
    coalesce(divisionkey, -1)                           as divisionkey,
    coalesce(nullif(trim(division), ''), 'UNK') as division,
    coalesce(nullif(trim(purchaseorganization), ''), 'UNK') as purchaseorganization,
    coalesce(nullif(trim(description), ''), 'UNK') as description,
    coalesce(activeflag, -1)                             as activeflag,
   coalesce(
    try_to_timestamp(createddate,'DD-MM-YYYY HH24:MI'),
    to_timestamp('1900-01-01 00:00:00')
) as createddate
    

from {{ source("raw_data", "divisionMapping") }}
