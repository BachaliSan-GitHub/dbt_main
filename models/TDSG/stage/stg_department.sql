{{
    config(
        materialized='table'
    )
}}

select

    coalesce(departmentkey, -1)                 as departmentkey,
    coalesce(spid, -1)                          as spid,
    coalesce(costcenterkey, -1)                  as costcenterkey,
    coalesce(divisionkey, -1)                      as divisionkey,
    coalesce(nullif(trim(departmentname), ''), 'UNK') as departmentname,
    coalesce(departmenthead, -1)                     as departmenthead,
    coalesce(try_to_number(purchasinggroupkey), -1)   as purchasinggroupkey,
    coalesce(try_to_number(activeflag), 0) as activeflag,
    coalesce(
    try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI'),
    to_timestamp('1900-01-01 00:00:00')
) as createddate
   -- coalesce(to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),to_date('1900-01-01')) as createddate

from {{ source("raw_data", "Department") }}
