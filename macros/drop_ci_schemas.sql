{% macro drop_ci_schemas(prefix) %}
    {% set wanted = prefix | lower %}
    {% set find_schemas %}
        select schema_name
        from {{ target.database }}.information_schema.schemata
        where lower(schema_name) = '{{ wanted }}'
           or left(lower(schema_name), {{ wanted | length + 1 }}) = '{{ wanted }}_'
    {% endset %}
    {% for row in run_query(find_schemas) %}
        {% do adapter.drop_schema(api.Relation.create(database=target.database, schema=row[0])) %}
        {% do log('Dropped schema ' ~ row[0], info=true) %}
    {% endfor %}
{% endmacro %}
