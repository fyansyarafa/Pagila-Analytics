{%
    macro audit_columns()
%}

    synced_at as kafka_synced_at,
    now()::timestamp as dbt_refresh_date

{%
    endmacro
%}