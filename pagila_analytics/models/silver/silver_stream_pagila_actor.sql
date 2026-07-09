select 
    actor_id,
    first_name,
    last_name,
    last_update,
    __deleted,
    synced_at kafka_synced_at,
    now()::timestamp as dbt_refresh_date
from {{
    source('source_pagila', 'stream_pagila_actor')
}}
where __deleted = 'false'