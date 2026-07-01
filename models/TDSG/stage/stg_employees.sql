{{ config(materialized="table") }}

select
   

    coalesce(employeekey, -1)                   as employeekey,
    coalesce(departmentkey, -1)                 as departmentkey,
    coalesce(reportingmanagerkey, -1)            as reportingmanagerkey,
    coalesce(nullif(trim(plantkey), ''), 'UNK')    as plantkey,
    coalesce(nullif(trim(employeecode),''), 'UNK')  as employeecode,
    coalesce(nullif(trim(employeename),''), 'UNK')   as employeename,
    coalesce(nullif(trim(costcenter),''), 'UNK')     as costcenter,
    coalesce(isadmin, -1)                        as isadmin,
    coalesce(nullif(trim(email),''), 'UNK')      as email_id,
    coalesce(nullif(trim(empdesignation),''), 'UNK')   as empdesignation,
    coalesce(isvendorsync, -1)                  as isvendorsync,
    coalesce(nullif(trim(employeetype), ''),'UNK')        as employeetype,
    coalesce(roleid, -1)                       as roleid,
    coalesce(try_to_number(isactive), 0) as isactive,
     coalesce(
    try_to_timestamp(createddate,'DD-MM-YYYY HH24:MI'),
    to_timestamp('1900-01-01 00:00:00')
) as createddate

from {{ source("raw_data", "employees") }}
