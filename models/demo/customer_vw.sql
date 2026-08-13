select * from {{ ref('customer') }}
where country = 'USA'