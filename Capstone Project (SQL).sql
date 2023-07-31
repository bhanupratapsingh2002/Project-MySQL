use sakila;
-- Task 1
select concat(first_name," ",last_name) as "Full Names" from actor;

-- Task 2(i)
select first_name,count(first_name) as "Count of first name" from actor group by first_name;
-- Task 2(ii)
select count(*) as "No. of actors with unique first names"from (select first_name as "Unique first names" from actor group by first_name having count(first_name)=1) as t1;
select first_name as "Unique first names" from actor group by first_name having count(first_name)=1;
-- Task 3(i)
select last_name,count(last_name) as "Count of Last name" from actor group by last_name;
-- Task 3(ii)
select last_name as "Unique last names" from actor group by last_name having count(last_name)=1;

-- Task 4(i)
select * from film where rating="R";
-- Task 4(ii)
select * from film where not rating="R";
-- Task 4(iii)
select * from film where rating="G";

-- Task 5(i)
select * from film where replacement_cost<11;
-- Task 5(ii)
select * from film where replacement_cost between 11 and 20;
-- Task 5(iii)
select * from film order by replacement_cost desc;

-- Task 6
select film.title, count(film_actor.actor_id) as "No. of actors"
from film_actor inner join film
 on film.film_id=film_actor.film_id
 group by film_actor.film_id
 order by count(film_actor.actor_id) desc limit 3;
 
-- Task 7
select title as "Movies starting with K and Q" from film where title like "K%" or title like "Q%";

-- Task 8
select concat(first_name," ",last_name) as "Actors in the film Agent Truman" from actor
 where actor_id in (select actor_id from film_actor where film_id=( select film_id from film where title="AGENT TRUMAN"));

-- Task 9
select title as "Films in family category" from film
 where film_id in(select film_id from film_category
 where category_id=(select category_id from category where name="Family"));
 
 -- Task 10(i)
 select rating,max(rental_rate) as "Maximum Rental Rate",
 min(rental_rate) as "Minimum Renatal Rate",
 avg(rental_rate) as "Average Rental Rate" 
 from film group by rating order by avg(rental_rate) desc;
 
 -- Task 10(ii)
 
 SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC;

-- Task 11
select category.name,avg(film.replacement_cost) as"Average replacement cost",
avg(film.rental_rate) as "Average rental rate",
(avg(film.replacement_cost)-avg(film.rental_rate)) as "Difference"
from film inner join film_category on film.film_id=film_category.film_id
inner join category on film_category.category_id=category.category_id
group by category.name having (avg(film.replacement_cost)-avg(film.rental_rate))>15;
 
-- Task 12
select category.name,count(film_category.film_id) as "Number of Movies"
 from film_category inner join category on film_category.category_id=category.category_id
 group by film_category.category_id
 having count(film_category.film_id)>70;


