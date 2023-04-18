{% macro clean_timestamp(column_name) %}
    regexp_replace({{ column_name }}, '(st|nd|rd|th)', '')
{% endmacro %}