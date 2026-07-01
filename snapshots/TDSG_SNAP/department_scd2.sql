 {% snapshot department_scd2 %}
    {{
        config(
            target_schema='DBT_SANKARAMMAB',
            target_database='DBT_TRAINING',
            unique_key='departmentkey',
            strategy='check',
            check_cols=[
            'departmentname',
            'departmenthead',
            'activeflag',
        ] )

    }}

select 
    departmentkey,
    spid,
    costcenterkey,
    divisionkey,
    departmentname,
    departmenthead,
    purchasinggroupkey,
    activeflag,
    createddate

 from   {{ ref('stg_department') }}
 

 {% endsnapshot %}

