-- SET COMPARISON OPERATORS( any/ some / all )
      -- ANY/SOME
      
      -- any means is my value = > < any of the values in the list
      /* find film title whose rental rate equals to G rated films*/
      
      select title , rental_rate 
      from sakila.film
      where rental_rate = any (select distinct rental_rate from sakila.film 
      where rating = 'G');
      
      -- ALL
      -- all means is my value > or < with everyitems present in the list
      
      -- Find film whose length < G rated films
      
      select title , length 
      from sakila.film
      where length < all (select length from sakila.film where rating = 'G');
      
      -- EXIST 
      /* if subquery returns even a single row,
      EXISTS becomes true ,
      it is faster than IN for large datasets*/
      
      /* Find customers name who have done atleast 1 payment more than that of 11$*/
      
      select first_name , last_name 
      from sakila.customer c
      where exists ( select 1 from sakila.payment p 
      where p.customer_id = c.customer_id and p.amount > 11) limit 5;
      /* select 1 is a standard practice which means just return a signal,
      the actual data value doesnt matter */
      
      
      -- result
	-- KAREN	JACKSON
-- VICTORIA	GIBSON
-- VANESSA	SIMS
-- ALMA	AUSTIN
-- ROSEMARY	SCHMIDT
 /* NOT EXISTS opposite of exists 
 if subquery is empty then only give result*/
 
 -- find customers who havent rented a single movie till date
 
 select first_name
 from sakila.customer c
 where not exists ( select 1 from sakila.rental r 
 where c.customer_id = r.customer_id);
 
 -- THE WITH CLAUSE ( CTE - common table expression )
 /* A CTE makes a query cleaner and more readable , 
 it is a more elegant and organised form of a 
 FROM subquery*/
 
 -- WITH table_name as ( subquery) select 
 /* We need the total revenue for each month , and then we have to 
 calculate a 10% tax on that revenue */
 
 with monthly_sales as ( select month(payment_date) as month_no , sum(amount) as total_revenue
 from sakila.payment
 group by month_no)
 -- now use this 'monthly_sales' as a real table
 select month_no , total_revenue, ( total_revenue* 0.10) as tax_amount from monthly_sales
 where total_revenue > 1000;
 -- result
--  5	4823.44	482.3440
-- 6	9629.89	962.9890
-- 7	28368.91	2836.8910
-- 8	24070.14	2407.0140
	
    /* CTE challenge : Create a CTE that includes each film's title and 
    replacement_cost , Then select the films from that CTE whose cost 
    is between 20$ and 25$*/
    
    with film_cost as ( select title , replacement_cost from sakila.film )
    select title, replacement_cost from film_cost 
    where replacement_cost between 20 and 25 limit 5;
    -- result 
 --   ACADEMY DINOSAUR	20.99
-- AFRICAN EGG	22.99
-- ALABAMA DEVIL	21.99
-- ALADDIN CALENDAR	24.99
-- ALASKA PHANTOM	22.99 

/* Create a CTE that includes the customer_id and 
the sum of their payments . 
Then , use that CTE to display only those customers 
whose total spending is more than $100. */

with customerpayments as ( select customer_id , sum(amount) as total_spent
from sakila.payment group by 1 )
select customer_id , total_spent from customerpayments 
where total_spent > 100;

/* question :
1. Create a CTE that contains the film_id of films whose rental_rate is $4.99 . 
2. In the main query , display the first_name of customers who have rented 
ANY (at least one ) film from the list in your CTE. */

with expensivefilms as ( select film_id from sakila.film where rental_rate = 4.99)
select first_name from sakila.customer where customer_id in  (
select customer_id from sakila.rental where inventory_id in (
select inventory_id from sakila.inventory where film_id in (
select film_id from expensivefilms))) limit 5;
-- result
-- MARY
-- PATRICIA
-- LINDA
-- BARBARA
-- ELIZABETH

-- SOME
/* Some means : At least one value in the list should match . 
= SOME works exactly like IN . 
> SOME means : greater than the smallest value in the list 

Challenge : The Greater Than Logic 
Question : Display the title and rental_rate of 
films whose rate is greater than the rental rate of ANY (SOME) movie
with an 'NC-17' rating . 
LOGIC : If the rental rates of NC - 17 movies are $0.99 and $4.99,
then >SOME will return all movies whose rate is greater than $0.99 . */
select title, rental_rate from sakila.film
where rental_rate > some ( select distinct rental_rate from sakila.film
where rating = 'NC-17')limit 7;
-- result
-- ACE GOLDFINGER	4.99
-- ADAPTATION HOLES	2.99
-- AFFAIR PREJUDICE	2.99
-- AFRICAN EGG	2.99
-- AGENT TRUMAN	2.99
-- AIRPLANE SIERRA	4.99
-- AIRPORT POLLOCK	4.99

/* Challenge 2 : Matching and Subquery
QUESTION: Retrieve the list of customers who have dealt with staff members
whose staff_id is 1 or 2 (using SOME) . */
select first_name , last_name 
from sakila.customer
where customer_id = some ( select customer_id
from sakila.payment where staff_id in ( 1,2) ) ;

/* Challenge 3 : Smallest comparison
QUE : Find the movies whose length (duration) is less than the
length of ANY (SOME) movie in the "ACTION" category . */

select title , length 
from sakila.film 
where length < some ( select length from sakila.film_category fc join sakila.film f on
fc.film_id = f.film_id 
where fc.category_id = 1) limit 5;

-- result
-- ACADEMY DINOSAUR	86
-- ACE GOLDFINGER	48
-- ADAPTATION HOLES	50
-- AFFAIR PREJUDICE	117
-- AFRICAN EGG	130
