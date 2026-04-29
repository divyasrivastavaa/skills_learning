SELECT * from sakila.address limit 20;    
CREATE table sakila.department (department_name varchar(15),
building varchar(10),
budget numeric(11,2)
); 
select distinct film_id from sakila.film_actor;
select distinct film_id from sakila.film_actor
where film_id =61;
select payment_id,amount*20
from sakila.payment;
select * from world.city limit 10;
insert into world.city (name,countrycode,district,population)
values('Patna','IND','Bihar',800020);
select * from world.city
where name = 'Patna';
select distinct Name from world.city
where Name like "P____" limit 10;
select distinct Name from world.city
where Name like "%na";
select distinct name from world.city
where name like "%tna" limit 10;
select film_id,first_name,last_name,fa.last_update
from sakila.actor as a, sakila.film_actor as fa
where a.actor_id = fa.actor_id;
select film_id, concat(first_name, " " , last_name) as full_name
from sakila.actor as a,sakila.film_actor as fa
where a.actor_id =fa.actor_id
order by film_id,full_name;
select * from sakila.payment
where amount between 4 and 20 ;
(select customer_id from sakila.payment
where amount between 2 and 6)
union
(select customer_id from sakila.payment
where amount between 7 and 10 );
(select customer_id from sakila.payment
where amount between 2 and 6)
union all
(select customer_id from sakila.payment
where amount between 7 and 10 );
(select customer_id from sakila.payment
where amount between 2 and 6)
INTERSECT 
(select customer_id from sakila.payment
where amount between 7 and 10 );
(select customer_id from sakila.payment
where amount between 2 and 6)
INTERSECT ALL
(select customer_id from sakila.payment
where amount between 7 and 10 );
(select customer_id from sakila.payment
where amount between 2 and 6)
EXCEPT
(select customer_id from sakila.payment
where amount between 7 and 10 );
(select customer_id from sakila.payment
where amount between 2 and 6)
EXCEPT ALL
(select customer_id from sakila.payment
where amount between 7 and 10 );
select * from sakila.staff
where password is NULL;
select * from sakila.staff
where password is UNKNOWN;
 -- the name formatter
select distinct CONCAT(first_name , " ", last_name)AS full_name
from sakila.actor
order by full_name ASC;
select title , replacement_cost 
from sakila.film
where title like '%DRAGON%'
and replacement_cost between 15 and 25 
limit 10;
select first_name , last_name ,email
from sakila.customer
where store_id IN (1)
and active = 1
and last_name not IN ('Smith' , 'Williams');
select active, customer_id
from sakila.customer;
(select first_name from sakila.actor)
UNION
(select first_name from sakila.customer)
ORDER BY first_name;
select username ,email
from sakila.staff 
where password is null;
( select actor_id from sakila.film_actor
where film_id =1)
INTERSECT
( select actor_id from sakila.film_actor
where film_id = 2);
( select actor_id from sakila.film_actor
where film_id =1)
except 
( select actor_id from sakila.film_actor
where film_id = 2);
-- High Value CUstomers
select amount from sakila.payment
where amount > 10
ORDER BY amount DESC;
-- Specific Movie Categories 
select Title , rental_duration 
from sakila.film
where rental_duration IN ( 3 , 5, 7 )
LIMIT 10;
-- Email Audit For Staff
select first_name , last_name, email , password
 from sakila.staff
 where email is null OR password is null;
 -- Actor Name Search
 select first_name , last_name 
 from sakila.actor
 where first_name like 'A%'
 or last_name like '%CH%';
  select first_name , last_name 
 from sakila.actor
 where first_name like 'A%';
 select title , length , rental_rate 
 from sakila.film
 where length < 90
 and rental_rate <1.00;
( select first_name from sakila.actor)
INTERSECT
(select first_name from sakila.customer);
(select customer_id from sakila.rental)
EXCEPT
(select customer_id from sakila .payment);
select title , description 
from sakila.film
where title like 'A%' and description not like '%documentary%';
select title , rental_rate * 10 as new_price
from sakila.film
where (rental_rate*10) >20
order by new_price desc;
select distinct email from sakila.customer;
select title , release_year 
from sakila.film
where rental_duration not in (1,2,3);
select first_name from sakila.actor
union
select first_name from sakila.customer
order by first_name asc;
select concat(first_name, " " , last_name) as new_name
from sakila.actor
union
select concat(first_name," ",last_name) as new_name
from sakila.customer
order by new_name;
select concat ( first_name , '-' , last_name ) as formatted_actor 
from sakila.actor
where first_name like 'E%' 
order by formatted_actor  limit 10;
-- The Hidden Actor
select first_name , last_name 
from sakila.actor 
where first_name like 'DAN%' and last_name not like '%S';
-- The Short Movie
select title , length
from sakila.film
where length between 51 and 89
order by length asc;
-- Proffesional Email Label 
select concat('customer_email:' , email ) as Contact_Info
from sakila.customer
limit 15;
-- The Specific Rental
SELECT 
    title, rental_rate, replacement_cost, rating
FROM
    sakila.film
WHERE
    rental_rate = 4.99
        AND replacement_cost < 20
        AND rating = 'G';
SELECT 
    first_name
FROM
    sakila.actor
WHERE
    first_name LIKE '%AL%'
ORDER BY first_name ASC
LIMIT 5;




