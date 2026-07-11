with store_profile as (
  select 
    store_id,
    manager_name
  from {{
    ref("silver_stream_pagila_store_profile")
  }}
), inventory as (
  select 
    inventory_id,
    film_id,
    store_id
  from {{
    ref("silver_stream_pagila_inventory")
  }}
), film_detail as (
  select
    film_id,
    title,
    description,
    release_year,
    rating
  from {{
    ref("silver_stream_pagila_film_detail")
  }}
)

select distinct
  sp.store_id,
  fd.film_id,
  {{
      dbt_utils.generate_surrogate_key([
          'sp.store_id',
          'fd.film_id',
      ])
  }} as store_inventory_sk,
  sp.manager_name store_manager_name,
  fd.title film_title,
  fd.description film_description,
  fd.release_year film_release_year,
  fd.rating film_rating,    
  now() as __audit_dbt_refresh_date
from store_profile sp 
left join inventory inv on sp.store_id = inv.store_id
left join film_detail fd on inv.film_id = fd.film_id
