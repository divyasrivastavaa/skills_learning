-- AGREGATE FUNCTIONS

-- Count Total No Of Customers
SELECT 
    COUNT(customer_id) AS total_customers
FROM
    sakila.customer;
-- QUERY OUTPUT
-- 599

-- Sum of rental_rates of all movies 
SELECT 
    SUM(rental_rate) AS Total_rental_value
FROM
    sakila.film;
-- Query REsult
-- 2980.00

-- Avg duration of movies
SELECT 
    AVG(length) AS Average_duration
FROM
    sakila.film;
-- query result
-- 115.2720

-- minimum rental_rate
SELECT 
    MIN(rental_rate) AS cheapest_rate
FROM
    sakila.film;
-- query output
-- 0.99

-- longest duration movie
SELECT 
    MAX(length) AS longest_movie
FROM
    sakila.film;
-- query result
-- 185

-- Combining These commands
select count(*) as total_films , min(replacement_cost) as min_cost,
max(replacement_cost) as max_cost, avg(replacement_cost) as avg_cost
from sakila.film;
-- query result
-- 1000	9.99	29.99	19.984000 

-- shortest , expensive , and total movie count
select min(length) as Shortest_movie , max(replacement_cost) as Costliest ,
count(*) as total_movies
from sakila.film;
-- result
-- 46	29.99	1000

-- AGGREGATION WITH GROUP BY
-- total_movies according to rating
select rating , count(*) as number_of_films
from sakila.film
group by rating;
-- result
-- PG	194
-- G	178
-- NC-17	210
-- PG-13	223
-- R	195
-- Here the data is grouped by rating

-- multiple aggregation
select rating , count(*) as total_films , 
min(rental_rate) as min_price , max(rental_rate) as max_price,avg(length) as average_length
from sakila.film
group by rating;
-- result
-- PG	194	0.99	4.99	112.0052
-- G	178	0.99	4.99	111.0506
-- NC-17	210	0.99	4.99	113.2286
-- PG-13	223	0.99	4.99	120.4439
-- R	195	0.99	4.99	118.6615

-- Movies in each rental_duration
select rental_duration, count(*) as total_movies , avg(rental_rate) as average_rent
from sakila.film
group by rental_duration;
-- result
-- 6	212	2.895660
-- 3	203	2.832365
-- 7	191	3.021414
-- 5	191	3.199424
-- 4	203	2.970296

-- Rating stats
select rating , count(*), min(replacement_cost) as min_price,max(replacement_cost) as max_price
from sakila.film
group by rating;
-- result
-- PG	194	9.99	29.99
-- G	178	9.99	29.99
-- NC-17	210	9.99	29.99
-- PG-13	223	9.99	29.99
-- R	195	9.99	29.99

-- Staff Performance
select staff_id , count(payment_id) as total_payments,sum(amount) as total_amount
from sakila.payment
group by staff_id;
-- result
-- 1	8054	33482.50
-- 2	7990	33924.06

-- Customer activity
select customer_id , count(customer_id) as total_transactions , sum(amount) as total_spent
from sakila.payment
group by customer_id
order by total_spent desc;
-- result
-- result is in the  folder name result_of_query_113_116

-- THE HAVING CLAUSE
select customer_id , count(customer_id) as total_transactions , sum(amount) as total_spent
from sakila.payment
group by customer_id
having total_spent > 150
order by total_spent desc;
-- result
-- this gives same result as previous query but adds a HAVING filter to show only those records where total_spent >150
select customer_id , sum(amount) as total_spent
from sakila.payment
where customer_id < 100
group by customer_id
having total_spent > 150
order by total_spent desc;
-- result
-- 50	169.65
-- 21	155.65
-- 75	155.59
-- 26	152.66
-- 7	151.67

-- High value Categories
select rating , avg(rental_rate) as avg_rent_rate
from sakila.film
group by rating
having avg_rent_rate > 3;
-- result
-- PG	3.051856
-- PG-13	3.034843

-- Busy Customers
select customer_id , count(payment_id) as total_transactions
from sakila.payment
where staff_id = 1
group by customer_id
having total_transactions > 25
order by total_transactions desc;
-- result
-- 176	26

-- Heavy Movies
select replacement_cost , avg(length) as average_duration
from sakila.film
group by replacement_cost
having average_duration > 120;
-- result
-- 26.99	122.8261
-- 22.99	120.7091
-- 16.99	123.5789
-- 10.99	122.7347

-- Budget Action Movies
select rental_duration , avg(replacement_cost) as average_replacement_cost
from sakila.film
where rental_duration >5
group by rental_duration
having average_replacement_cost < 20;
-- result
-- 7	19.942880

select rental_duration , group_concat(title) as all_movie_names , avg(replacement_cost) as average_replacement_cost
from sakila.film
where rental_duration >5
group by rental_duration
having average_replacement_cost < 20 limit 10;
  -- Group_concat(title) is used to combine all titles in one group , so it doesn't give error when grouping by rental_duration.
  
  -- The Special Customers
  select customer_id , count(*) as no_of_repetetive_customers
  from sakila.payment
  where amount > 5
  group  by customer_id
  having count(*) > 10 limit 5;
  -- result
 --  2	11
-- 7	13
-- 78	11
-- 80	12
-- 82	11

-- Rating and Length filter
select rating , count(*) as total_movie_count
from sakila.film
where length between 100 and 150 
group by rating
having count(*) > 50;
-- result
-- G	64
-- PG-13	86
-- PG	77
-- R	76
-- NC-17	77

-- Mastered data aggregation and the logical difference between where and having clauses.alter
 
  






