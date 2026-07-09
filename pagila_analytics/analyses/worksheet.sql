with actor as (
  select
    actor_id,
    first_name,
    last_name
  from {{ source('source_pagila', 'stream_pagila_actor') }}
), film as(
  select 
    film_id,
    title
  from {{ source('source_pagila', 'stream_pagila_film') }}
    
)
select * 
from actor a
join film f on a.film_id = f.film_id