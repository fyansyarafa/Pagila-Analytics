
with film_actor as (
  select 
    actor_id, 
    film_id
  from {{
    ref('silver_stream_pagila_film_actor')
  }}
), actor as (
select
  actor_id,
  first_name,
from 
)
