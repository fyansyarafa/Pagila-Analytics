select 
{{
    dbt_utils.star(
        from=source('source_pagila', 'stream_pagila_actor'),
        except=["__deleted"]
    )
}}

{{
    audit_columns()
}}

from {{
    source('source_pagila', 'stream_pagila_actor')
}}
where __deleted = 'false'