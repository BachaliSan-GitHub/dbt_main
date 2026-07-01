{% macro is_current(column) %}
    case 
        when {{ column }} is null then 1 
        else 0 
    end as is_current
{% endmacro %}