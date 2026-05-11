-- Case when ( The Logic Master)
Select column_name,
CASE
when condition1 then 
'result1'
when condition2 then
'result2'
else 'default result'
end as alias_name
from table_name;

/* Practice Task 1 : Simple Categories
QUE : From the sakila.film table ,
display the movies titles and categorize them
based on their length into 3 categories . 
 : If the length is less than 60 = short film
 : If the length is between 60 and 120 =standard film
 : If the length is more than 120 = long film */
 
 select title , length ,
 case 
 when length < 60 then 'Short_film'
 when length between 60 and 120 then 'Standard_film'
 else 'LONG_MOVIE'
 end as FILM_CATEGORY
 from sakila.film limit 5;
-- result
-- ACADEMY DINOSAUR	86	Standard_film
-- ACE GOLDFINGER	48	Short_film
-- ADAPTATION HOLES	50	Short_film
-- AFFAIR PREJUDICE	117	Standard_film
-- AFRICAN EGG	130	LONG_MOVIE

/* Practice Tasl 2 : Binary Logic ( creating flags)
QUE : We neeed to check which movies are 'expensive' . 
If the replacement_cost is greater than $20 , display 'expensive'
otherwise display cheap . */
select title , replacement_cost ,
case 
when replacement_cost > 20 then 'Expensive'
else 'Cheap'
end as price_tag
from sakila.film limit 5;
-- result
-- ACADEMY DINOSAUR	20.99	Expensive
-- ACE GOLDFINGER	12.99	Cheap
-- ADAPTATION HOLES	18.99	Cheap
-- AFFAIR PREJUDICE	26.99	Expensive
-- AFRICAN EGG	22.99	Expensive

/* Project Task 3 : Case with Aggregation ( pro level)
This is favorite among analyst ! Suppose you need to count
how many 'expensive' movies are present in each rating category. */
select rating , 
count( case when replacement_cost > 20 then 1 end )as expensive_count ,
count( case when  replacement_cost <= 20 then 1 end )as cheap_count
from sakila.film
group by rating;
-- result
-- PG	81	113
-- G	83	95
-- NC-17	108	102
-- PG-13	113	110
-- R	101	94

/*  The  Rental Challange 
From the sakila.film table , create a column for rental_rate:
. If the rate is 0.99 = 'budget'
. If the rate is 2.99 = 'regular'
. If the rate is 4.99 = 'Premium'
Boolean check 
Write a query to show whether a movie has 'Trailers' or not 
( check the special_features column using like )*/

select title , rental_rate , 
case when rental_rate = 0.99 then 'Budget'
when rental_rate = 2.99 then 'Regular'
when rental_rate = 4.99 then 'Premium'
else 'Unknown'
end as rental_category
from sakila.film;

-- Boolean check 
select title , special_features ,
case when special_features like '%Trailers%'then 'yes'
else 'no'
end as has_trailers
from sakila.film limit 5;
-- result
--  ACADEMY DINOSAUR	Deleted Scenes,Behind the Scenes	no
-- ACE GOLDFINGER	Trailers,Deleted Scenes	yes
-- ADAPTATION HOLES	Trailers,Deleted Scenes	yes
-- AFFAIR PREJUDICE	Commentaries,Behind the Scenes	no
-- AFRICAN EGG	Deleted Scenes	no

-- SQL JOINS (THE CONNECTOR)
-- INNER JOIN ( the common ground )
/* It only shows the data that matches in both tables .
If a record exist in one table but not in other , it will not be displayed . 

Challenge : Display the customer's names (customer) and their city (city) . 
( Here address_id is the common column between them)*/

select c.first_name, c.last_name , ci.city
from sakila.customer c 
inner join sakila.address a on c.address_id = a.address_id
inner join sakila.city as ci on 
a.city_id = ci.city_id limit 5;
-- result
-- MARY	SMITH	Sasebo
-- PATRICIA	JOHNSON	San Bernardino
-- LINDA	WILLIAMS	Athenai
-- BARBARA	JONES	Myingyan
-- ELIZABETH	BROWN	Nantou

/* LEFT JOIN ( Everything from Left )
This shows all the data from the left table , 
and only the matching data from the Right table . 
If there is no match, it displays NULL . 

Challenge : Display the names of all films and their inventory status 
( whether they are in stock or not)
(Some films may not be present in the inventory)*/
select f.title , i.inventory_id 
from sakila.film f 
left join sakila.inventory i on f.film_id = i.film_id limit 5;
-- result 
-- ACADEMY DINOSAUR	1
-- ACADEMY DINOSAUR	2
-- ACADEMY DINOSAUR	3
-- ACADEMY DINOSAUR	4
-- ACADEMY DINOSAUR	5

-- RIGHT JOIN ( Everything from right)
select f.title , i.inventory_id 
from sakila.film f 
right join sakila.inventory i on f.film_id = i.film_id limit 5;

/* NATURAL JOIN ( THE AUTO_JOIN)
In this , we do not need to write an ON condition . 
SQL automatically finds the columns with the same names in both tables and join them .

WARNING : This is rarely used in professional work because if tables have common columns
like last_update , it can produce incorrect results. */

select * from sakila.actor 
natural join sakila.film_actor;

/* FULL OUTER JOIN ( THE WHOLE CIRCLE)
This shows all the data from both tables . Where the records match , it displays the data
where they do not match , it shows NULL . 
NOTE : MySQL does not directly support FULL OUTER JOIN > We need to combine LEFT JOIN & RIGHT JOIN 
using UNION to achieve the same result . 
Example : Suppose we want a list of all customers and their rentals , including customers who 
have never rented anything , also any rental entities ( hypothetically) 
that do not have a customer associated with them . */
select c.first_name , c.last_name , r.rental_date 
from sakila.customer c 
left join sakila.rental r on 
c.customer_id = r.customer_id
union
select c.first_name,c.last_name, r.rental_date
from sakila.customer c 
right join sakila.rental r on
c.customer_id = r.customer_id limit 5;
-- result
-- MARY	SMITH	2005-05-25 11:30:37
-- MARY	SMITH	2005-05-28 10:35:23
-- MARY	SMITH	2005-06-15 00:54:12
-- MARY	SMITH	2005-06-15 18:02:53
-- MARY	SMITH	2005-06-15 21:08:46

 select c.first_name , c.last_name , r.rental_date 
from sakila.customer c 
left join sakila.rental r on 
c.customer_id = r.customer_id
union all
select c.first_name,c.last_name, r.rental_date
from sakila.customer c 
right join sakila.rental r on
c.customer_id = r.customer_id limit 5;

/* Join Conditions (ON vs USING)
1 ON : Used when the column names are different ( eg , a.id = b.emp_id)
2 USING : Used when both tables have exactly the same column name . */ 

select first_name , last_name , address 
from sakila.customer
join sakila.address using (address_id) limit 5;
-- result 
-- MARY	SMITH	1913 Hanoi Way
-- PATRICIA	JOHNSON	1121 Loja Avenue
-- LINDA	WILLIAMS	692 Joliet Street
-- BARBARA	JONES	1566 Inegl Manor
-- ELIZABETH	BROWN	53 Idfu Parkway

/* Inner join task : join the actor and film_actor tables to display which
actor worked in which film_id . */ 

select a.first_name , a.last_name , fa.film_id
from sakila.actor a 
inner join sakila.film_actor fa on 
a.actor_id = fa.actor_id limit 5;
-- result
-- PENELOPE	GUINESS	1
-- PENELOPE	GUINESS	23
-- PENELOPE	GUINESS	25
-- PENELOPE	GUINESS	106
-- PENELOPE	GUINESS	140

/* MULTIPLE JOIN : Join the customer , payment and rental tables to create a report 
containing customer_name, amount , and rental_date . */
select c.first_name, c.last_name, p.amount , r.rental_date
from sakila.customer c 
inner join sakila.payment p on 
c.customer_id = p.customer_id
inner join sakila.rental r on
p.rental_id = r.rental_id limit 5;
-- result
-- MARY	SMITH	2.99	2005-05-25 11:30:37
-- MARY	SMITH	0.99	2005-05-28 10:35:23
-- MARY	SMITH	5.99	2005-06-15 00:54:12
-- MARY	SMITH	0.99	2005-06-15 18:02:53
-- MARY	SMITH	9.99	2005-06-15 21:08:46

select c.first_name, c.last_name, p.amount , r.rental_date
from sakila.customer c 
inner join sakila.payment p on 
c.customer_id = p.customer_id
inner join sakila.rental r on
p.rental_id = r.rental_id  order by rental_date desc;


