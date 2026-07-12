with rental as (
  select

    rental_id,
    rental_detail_sk,
    rental_date, 
    return_date,
    customer_name,
    customer_email,
    film_title,
    staff_name,
    customer_id
  from {{
    ref("silver_stream_pagila_rental_detail")
  }}
), payment as(
  select 
    {{
      dbt_utils.generate_surrogate_key([
          'customer_id',
          'rental_id'
      ])
    }} as rental_detail_sk,
    payment_date,
    payment_id,
    customer_id, 
    staff_id,
    rental_id,
    amount
  from {{
    ref("silver_stream_pagila_payment")
  }}

)
select 
r.*,
p.payment_id,
p.payment_date,
p.amount
from rental r 
left join payment p 
on r.rental_id = p.rental_id