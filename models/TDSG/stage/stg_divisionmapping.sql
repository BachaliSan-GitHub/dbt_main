{{ config(materialized="table") }}

select

    coalesce(spid, -1) as spid,
    coalesce(divisionkey, -1) as division_key,
    coalesce(trim(division), 'UNK') as division,
    coalesce(trim(purchaseorganization), 'UNK') as purchase_organization,
    coalesce(trim(description), 'UNK') as description,
    coalesce(activeflag, -1) as active_flag,
    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as created_date

from {{ source("raw_data", "divisionMapping") }}
