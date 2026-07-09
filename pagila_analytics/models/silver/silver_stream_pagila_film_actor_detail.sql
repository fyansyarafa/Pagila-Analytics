
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
    full_name
  from {{
      ref('silver_stream_pagila_actor')
    }}
), film as (
  select 
    film_id,
    title, 
    description,
    release_year,
    language_id,
    original_language_id,
    rental_duration,
    rental_rate,
    length,
    replacement_cost, 
    rating
  from {{
      ref('silver_stream_pagila_film')
    }}
), film_category as (
    select 
        film_id,
        category_id
    from {{
        ref('silver_stream_pagila_film_category')
    }}
)

select 
  fa.actor_id, 
  fa.film_id, 
  fc.category_id,
  {{
    dbt_utils.generate_surrogate_key([
        'fa.actor_id',
        'fa.film_id',
        'fc.category_id'
    ])
  }} as film_detail_sk,
  a.full_name actor_full_name, 
  f.title, 
  f.description, 
  f.release_year, 
  f.language_id, 
  f.original_language_id, 
  f.rental_duration, 
  f.rental_rate, 
  f.length, 
  f.replacement_cost, 
  f.rating,
  now() as __audit_dbt_refresh_date

from film_actor fa
left join actor a on fa.actor_id = a.actor_id
left join film f on fa.film_id = f.film_id
left join film_category fc on f.film_id = fc.film_id
