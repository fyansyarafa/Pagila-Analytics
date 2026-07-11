{% macro exclude_column(model, columns) %}
    {{ dbt_utils.star(from=model, except=columns) }}
{% endmacro %}