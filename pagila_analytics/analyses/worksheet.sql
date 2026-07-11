select
{{
  exclude_column(
    ref("silver_stream_pagila_actor"),
    ["actor_id", "full_name"]
  )
}}
from {{ ref("silver_stream_pagila_actor") }}