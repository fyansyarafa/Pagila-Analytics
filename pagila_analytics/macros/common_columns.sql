{%
    macro audit_columns()
%}

    synced_at as __audit_kafka_synced_at,
    now()::timestamp as __audit_dbt_refresh_date

{%
    endmacro
%}