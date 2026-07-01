{% macro scd_dates() %}
    dbt_valid_from as effective_startdate,
    dbt_valid_to   as effective_enddate
{% endmacro %}
