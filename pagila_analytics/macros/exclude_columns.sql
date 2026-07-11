{% macro exclude_column(model, columns, relation_alias=none) %}
    {{ dbt_utils.star(from=model, except=columns, relation_alias=relation_alias) }}
{% endmacro %}