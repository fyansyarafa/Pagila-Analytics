select 
    {{
        dbt_utils.star(
            from=source('source_pagila', 'stream_pagila_actor'),
            except=["synced_at", "__deleted", "first_name", "last_name"]
        )
    }},
    first_name || ' ' || last_name as full_name,
    {{
        audit_columns()
    }}

from {{
    source('source_pagila', 'stream_pagila_actor')
}}
where __deleted = 'false'