-- NESTED QUERY

-- the single value subquery

-- Select movies where replacement_cost is greater than avg replacement_cost
select title, replacement_cost
from sakila.film
where replacement_cost > ( select avg(replacement_cost) from sakila.film );
-- result
-- the result shows only those movie titles whose replacement_cost is above avg
-- execution
-- inner query then outer query 

-- Multiple Value Subquery
 -- Show customer names who rented action category movies
 select first_name , last_name
 from sakila.customer
 where customer_id in ( select customer_id from sakila.rental 
 where inventory_id in ( select inventory_id from sakila.inventory 
 where film_id in ( select film_id from sakila.film_category 
 where category_id = 1 )));
 -- 1 is for action
 
 -- Inside out technique
 select first_name , last_name from sakila.customer where customer_id in
(( select inventory_id from sakila.inventory where film_id in
( select film_id from sakila.film_category where category_id in  
( select category_id from sakila.category 
 where name = 'Action'))));
 
 -- The Actors ID
 -- List of film_id  in which NICK WAHLBERG's work
 select film_id from sakila.film_actor where actor_id in 
( select  actor_id from sakila.actor where first_name = 'NICK'  and last_name = 'WAHLBERG');
 -- we have obtained the result
 
 -- List of actors who do not work in movie academy dinosaur
 select first_name , last_name from sakila.actor where actor_id not in 
 (select actor_id from sakila.film_actor where film_id in 
( select film_id from sakila.film where title = 'ACADEMY DINOSAUR'));
-- we got the required names

/* show the total number of movies 
in the entire store next to each movie title */

select title , ( select count(title) from sakila.film) as Total_collection_count 
from sakila.film;
-- This is nested query in SELECT

/* First calculate the total rental income for 
each movie , then show only those movies that have earned more than 100*/
select * from 
( select f.title , sum(p.amount ) as total_earnings
 from sakila.film f 
 join sakila.inventory i on f.film_id = i.film_id 
 join sakila.rental r on i.inventory_id = r.inventory_id
 join sakila.payment p on
 r.rental_id = p. rental_id
 group by f.title) as movie_income_table
 where total_earnings> 100 ;
 -- AS is required for nested queries in from clause
 -- nested query in FROM 
 -- Find customers who have made more than 100 transactions
 select * from
( select customer_id , count(payment_id) as total_count 
 from sakila.payment
 group by customer_id) as customer_summary_table 
 where total_count > 100;
 
 select * from 
 (select customer_id , sum(amount) as total_bill
 from sakila.payment
 group by customer_id) as my_table 
 where total_bill > 150 limit 5 ; 
 -- result
 /*  7	151.67
21	155.65
26	152.66
50	169.65
75	155.59*/ 

-- THE IN & WHERE POWER
-- List of customers who have rented movie ALBAMA DEVIL
select first_name,last_name from sakila.customer where customer_id in (
select customer_id from sakila.rental where inventory_id in (
select inventory_id from sakila.inventory where film_id in (
select film_id from sakila.film where title = 'ALABAMA DEVIL'))) ;

/* step 1 : get film id for alabama devil
step 2 : find all inventory ids for that film_id
step 3 : find all customer_ids who rented those inventory ids 
step 4 : get first and last names of those customers*/ 

-- Nested in select
/* Show each movie title and , in the next column ,
display the overall avg rental rate of all movies 
in the database for comparison */

select title, rental_rate ,( select avg(rental_rate)
from sakila.film) as global_avg_rate 
from sakila.film limit 5 ;
-- result
-- ACADEMY DINOSAUR	0.99	2.980000
-- ACE GOLDFINGER	4.99	2.980000
-- ADAPTATION HOLES	2.99	2.980000
-- AFFAIR PREJUDICE	2.99	2.980000
-- AFRICAN EGG	2.99	2.980000

/* create a temporary table (derived table) that contains movie titles and their lengths
Then , filter this temporary list to show only movies longer than 180mins*/
select * from ( select title, length from sakila.film ) as long_movies_table
where length > 180 limit 5;
-- result
-- ANALYZE HOOSIERS	181
-- BAKED CLEOPATRA	182
-- CATCH AMISTAD	183
-- CHICAGO NORTH	185
-- CONSPIRACY SPIRIT	184

/* Goal : Find all movie titles featuring actor ED CHASE. 
Logic : Connect Actor name -> Actor id -> Film id-> Movie title. */
select title from sakila.film where film_id in (
select film_id from sakila.film_actor where actor_id in (
select actor_id from sakila.actor where first_name = 'ED' and last_name = 'CHASE') ) limit 5;
-- result
-- ALONE TRIP
-- ARMY FLINTSTONES
-- ARTIST COLDBLOODED
-- BOONDOCK BALLROOM
-- CADDYSHACK JEDI

/* Goal : Identify customers who have never made a single 
payment greater than 10$ . 
Logic : Find everyone who DID pay >10, then exclude them from the 
full customer list */
select  first_name from sakila.customer where customer_id  not in (
select customer_id from sakila.payment where amount > 10) limit 5;
-- result
-- MARY
-- BARBARA
-- ELIZABETH
-- JENNIFER
-- MARIA

/* Goal : Show each customer's name alongside the total number of
payments in the entire database . 
Logic: Use a scalar subquery in the select line to repeat the total count for every */
select first_name ,
( select count(*) from sakila.payment) 
 as Total_transactions_ever 
 from sakila.customer limit 5;
 -- result
--  MARY	16044
-- PATRICIA	16044
-- LINDA	16044
-- BARBARA	16044
-- ELIZABETH	16044

/* Goal : Create a temporary list of movie
costs and filter for expensive ones ($ 25 )
Logic : Treat the inner select as a temporary table and apply a filter on its output*/
select * from (
select title , replacement_cost from sakila.film) as film_cost 
where replacement_cost > 25 limit 5 ;
-- result
-- AFFAIR PREJUDICE	26.99
-- AIRPLANE SIERRA	28.99
-- ALTER VICTORY	27.99
-- ANYTHING SAVANNAH	27.99
-- ARABIA DOGMA	29.99

/* List of customers who have spent more than $200 ,
and next to each name , also display the total_store_sales */
select customer_id , total_bill , ( select sum(amount) from sakila.payment) as Global_store_sales
from (
select customer_id , sum(amount) as total_bill from sakila.payment
group by customer_id) 
as customer_summery_table 
where total_bill > 200;
-- result
-- 148	216.54	67406.56
-- 526	221.55	67406.56


