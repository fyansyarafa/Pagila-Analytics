  select
    actor_id,
    first_name,
    last_name
  from {{ source('source_pagila', 'stream_pagila_actor') }}

select * 
from {{
    source('source_pagila', 'stream_pagila_actor')
}}
where __deleted = 'false'