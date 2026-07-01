 {% snapshot division_scd2 %}
    {{
        config(
            target_schema='DBT_SANKARAMMAB',
            target_database='DBT_TRAINING',
            unique_key='divisionkey',
            strategy='check',
            check_cols=[
            'divisionshortcode',
            'divisionname',
            'divisionhead',
            'deputydivisionhead',
            'activeflag',
        ] )

    }}

select 
    divisionkey,
    spid,
    divisionshortcode,
    divisionname,
    divisionhead,
    deputydivisionhead,
    activeflag,
    createddate

 from   {{ ref('STG_division') }}
 

 {% endsnapshot %}

