 {% snapshot Employess_scd2 %}
    {{
        config(
            target_schema='DBT_SANKARAMMAB',
            target_database='DBT_TRAINING',
            unique_key='employeekey',
            strategy='check',
            check_cols=[
            'departmentkey',
            'reportingmanagerkey',
            'plantkey',
            'empdesignation',
            'costcenter',
            'roleid',
            'employeetype',
        ] )

    }}

select 
    employeekey,
    departmentkey,
    reportingmanagerkey,
    plantkey,
    employeecode,
    employeename,
    costcenter,
    isadmin,
    email_id,
    empdesignation,
    isvendorsync,
    employeetype,
    roleid,
    createddate
    

 from   {{ ref('stg_employees') }}
 

 {% endsnapshot %}

