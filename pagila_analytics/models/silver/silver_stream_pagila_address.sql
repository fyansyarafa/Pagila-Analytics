select 
    {{
        dbt_utils.star(
            from=source('source_pagila', 'stream_pagila_address'),
            except=["synced_at", "__deleted"]
        )
    }},
    {{
        audit_columns()
    }}

from {{
    source('source_pagila', 'stream_pagila_address')
}}
where __deleted = 'false'