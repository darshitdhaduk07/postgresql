select * from actor;
select first_name ||' '|| last_name full_name from actor;
select now();
select first_name ||' '|| last_name full_name from actor order by first_name;

select first_name ||' '|| last_name full_name from actor order by full_name;
select first_name ||' '|| last_name full_name from actor order by first_name desc,last_name asc;

select * from rental;

select distinct customer_id from rental; 
select * from rental where customer_id = 24; 

select * from rental where rental_date between '2005-05-01' and '2005-06-01'; 
select * from rental where rental_date between '2005-05-01' and '2005-06-01' order by customer_id; 
select * from rental where rental_id in(1,3,4);

select * from customer;
select * from customer where first_name = 'Jamie' and last_name = 'Rice';
select * from customer where first_name = 'Adam' or last_name = 'Rodriguez';
select * from customer where first_name like 'Am%';
select * from customer where first_name like 'A%' and length(first_name) = 3;
select * from customer where first_name like 'A%' and length(first_name) between 3 and 7;
select * from customer where create_date between '2006-01-01' and '2006-06-30';
-- select * from customer where addres between '2006-01-01' and '2006-06-30';


-- 1.fist name, last name , city
select c.first_name,c.last_name,ci.city from customer c join address a using(address_id) join city ci on a.city_id = ci.city_id;

-- 2. film title,category name order by category
select f.title,c.name from category c join film_category fc on fc.category_id = c.category_id join film f on f.film_id = fc.film_id order by c.name;


-- 3 display customer name and payment amount amount bet 5 to 10 amount decending

select c.first_name,p.amount from payment p join customer c on p.customer_id = c.customer_id where p.amount between 5 and 10 order by p.amount desc;

-- 6 show films rating in ("PG","R") with catorgary name order by rating

select f.title,c.name from category c join film_category fc on fc.category_id = c.category_id join film f on f.film_id = fc.film_id where f.rating in('PG','R') order by f.rating;

-- 7
select c.first_name, count(c.customer_id) from rental r join customer c on  r.customer_id = c.customer_id group by c.customer_id;


--8

select c.name,count(c.name) total from category c join film_category fc on fc.category_id = c.category_id join film f on f.film_id = fc.film_id group by c.name order by total desc;


-- 1.
select distinct p.amount,s.staff_id from payment p join staff s on p.staff_id = s.staff_id where s.staff_id IN (1,2) order by s.staff_id desc;

-- 2.
select f.length as length,f.rating from film f where f.length between 80 and 120 and f.rating in('PG-13','R') order by length;

-- 3.
select distinct c.customer_id from customer c where c.customer_id between 50 and 150 and c.store_id IN(1,2);

--
select distinct a.district from customer c join address a on c.address_id = a.address_id where a.city_id between 1 and 100 order by a.district;
select distinct a.district from customer c join address a using(address_id) where a.city_id between 1 and 100 order by a.district;

--1.
select distinct customer_id from payment where amount in (5,7,9);

-- 2.
select distinct length from film where rating in ('PG','G'); 

-- 3
select distinct district from address where city_id in (1,2,3,4);

-- 4
select title from film where length between 60 and 80 or rating = 'PG' order by length;


-- 5 
select * from payment where amount between 2 and 4 or customer_id = 10 order by amount desc;

-- 6
select * from rental where rental_date between '2005-5-01' and '2005-5-30' or staff_id = 1 order by rental_date;

-- 7
select * from film where replacement_cost between 15 and 20 or rental_rate = 0.99;

--8
select * from actor where last_name between 'A' and 'F' or first_name in ('John','Mike');


-- film which not yet rented
select title from film left join inventory using (film_id) left join rental using(inventory_id) where rental_id is null;

select title from rental right join inventory using (inventory_id) right join film using(film_id) where rental_id is null;

-- find out total number of customer present

select count(customer_id) from customer;

-- from payment avg of totla payemnt
select avg(amount) from payment;

select sum(amount) from payment;

select min(amount) from payment;

select max(amount) from payment;

-- find total payment made by each customer 

select sum(amount),customer_id from payment group by (customer_id);
select customer_id,avg(amount) from payment group by (customer_id);

select c.first_name,avg(amount) from payment join customer c using (customer_id) group by c.customer_id;


-- Show category name and total number of films in each category ordered by total descending.
select c.name,count(f.film_id) as total from category c join film_category fc using (category_id) join film f using(film_id) join inventory using (film_id) join rental r using(inventory_id) where r.rental_id is not null group by (c.name) order by total;
select f.title,count(f.film_id) as total from category c join film_category fc using (category_id) join film f using(film_id) join inventory using (film_id) join rental r using(inventory_id) where r.rental_id is not null group by (f.title) having count(f.film_id) > 10 order by total;

 
-- Display city name and number of customers in each city.
select c.city,count(cu.customer_id) from city c join address a using(city_id) join customer cu using(address_id) group by (c.city);

 
-- Show staff name and total payment amount handled by each staff member.
select s.first_name,sum(amount) from staff s join payment using(staff_id) group by (s.first_name);

-- Display customer names who made more than 30 rentals.
select c.first_name from customer c join rental using(customer_id) group by customer_id having count(rental_id) > 30;

-- Show categories having more than 60 films.
select c.name  from category c join film_category using(category_id) group by c.name having count(film_id) > 60;


-- Display films with average rental rate per rating  greater than 2.
select f.rating,avg(rental_rate) from film f group by f.rating having avg(rental_rate) > 2;

-- Show customers whose total payment is between 100 and 200.

select c.first_name from customer c join payment p using (customer_id) group by c.customer_id having sum(p.amount) between 100 and 200;


-- one category how many time it rented

select c.name,count(f.title) 
from category c 
join film_category fc using(category_id) 
join film f using(film_id) join inventory using(film_id) 
join rental r using(inventory_id) 
where r.rental_id is not null 
group by c.name 
order by c.name;

select c.name,count(f.title) 
from category c 
left join film_category fc using(category_id) 
left join film f using(film_id) 
left join inventory using(film_id) 
left join rental r using(inventory_id) 
where r.rental_id is null 
group by c.name 
order by c.name;


-- Show film ratings with average film length greater than 115 minutes.
select rating from film group by rating having avg(length) > 115;

-- Display months (from payment_date) with total revenue greater than 5000.
select EXTRACT(MONTH FROM payment_date)as month from payment group by month having sum(amount) > 5000;

-- Show top 5 customers by total payment.
select c.first_name from customer c join payment p using(customer_id) group by (customer_id)  order by sum(p.amount) desc limit 5;

-- Show customers who rented films in more than 15 different categories.
select cu.first_name from category ca join film_category fc using(category_id) join film f using(film_id) join inventory i using(film_id) join rental r using(inventory_id) join customer cu using(customer_id) group by (cu.customer_id) having count(distinct ca.category_id) > 15;


-- Show customers who never made any payment.
select c.first_name from customer c left join payment p using(customer_id) where p.payment_id is null; 


-- Display films that were never rented.
select f.title from film f left join inventory i using(film_id) left join rental r using(inventory_id) where r.rental_id is null;


-- Display films with total rental count greater than 10 ordered by rental count.
select f.title from film f join inventory i using(film_id) join rental r using (inventory_id) group by f.title having count(r.rental_id)>10;



-- Display category with highest total revenue.
select ca.name from category ca join film_category fc using(category_id) join film f using(film_id) join inventory i using(film_id) join rental r using(inventory_id) join payment p using(customer_id) group by (ca.name) order by sum(p.amount) desc limit 1;


-- Show top 3 most rented films.
select f.title from film f join inventory i using(film_id) join rental r using (inventory_id) group by f.title order by count(f.title) desc;

-- Display customers who rented films only from category 'Action'.
select cu.customer_id,ca.name as cc from category ca join film_category fc using(category_id) join film f using(film_id) join inventory i using(film_id) join rental r using(inventory_id) join customer cu using(customer_id) group by (cu.customer_id,ca.name) having count(cu.customer_id) = 1 and ca.name = 'Action';


-- Display cities where total payment revenue is greater than 10,000.
select ci.city from payment p join customer cu using(customer_id) join address ad using(address_id) join city ci using(city_id) group by ci.city having sum(p.amount) > 10000;


-- Show film titles, category, total rentals and total revenue per film.
select f.title,ca.name,count(r.rental_id),sum(p.amount) from category ca join film_category fc using(category_id) join  film f using(film_id) join inventory i using(film_id) join rental r using(inventory_id) join payment p using(customer_id)  group by f.title, ca.name;



-- Display customers, city, total rentals, total payment ordered by highest revenue.

select cu.first_name,ci.city,count(r.rental_id),sum(p.amount) from rental r join payment p using(customer_id) join customer cu using(customer_id) join address ad using(address_id) join city ci using(city_id) group by cu.first_name,ci.city order by sum(p.amount) desc;

-- SELECT film_id,
--        title,
--        rental_rate
-- INTO film_r
-- FROM film
-- WHERE rating = 'R'
--   AND rental_duration = 5;

-- SELECT film_id,
--        title as t,
--        rental_rate
-- INTO tt
-- FROM film
-- WHERE rating = 'R'
--   AND rental_duration = 5;

-- select * from film_r;


-- select * into short_film from film where length > 60;
-- select * from short_film;

-- CREATE TEMP TABLE temp (
--     id INT PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     email VARCHAR(255) NOT NULL UNIQUE,
--     empid INT UNIQUE,
--     age INT CHECK (age > 18),
--     salary DOUBLE PRECISION DEFAULT 1000
-- );

-- INSERT INTO temp (id, name, email, empid, age, salary) VALUES
-- (1, 'John Doe', 'john.doe@example.com', 1001, 25, 1500),
-- (2, 'Alice Smith', 'alice.smith@example.com', 1002, 30, 2000),
-- (3, 'Mike Ross', 'mike.ross@example.com', 1003, 28, 1800),
-- (4, 'Sarah Connor', 'sarah.connor@example.com', 1004, 35, 2200),
-- (5, 'David Lee', 'david.lee@example.com', 1005, 40, 2500),
-- (6, 'Emma Watson', 'emma.watson@example.com', 1006, 26, 1600),
-- (7, 'Chris Evans', 'chris.evans@example.com', 1007, 33, 2400),
-- (8, 'Olivia Brown', 'olivia.brown@example.com', 1008, 29, 1900),
-- (9, 'Daniel Clark', 'daniel.clark@example.com', 1009, 32, 2100),
-- (10, 'Sophia Miller', 'sophia.miller@example.com', 1010, 27, 1700),
-- (11, 'Liam Johnson', 'liam.johnson@example.com', 1011, 31, 2300),
-- (12, 'Mia Davis', 'mia.davis@example.com', 1012, 24, 1400),
-- (13, 'Noah Wilson', 'noah.wilson@example.com', 1013, 36, 2600),
-- (14, 'Ava Moore', 'ava.moore@example.com', 1014, 28, 1800),
-- (15, 'Ethan Taylor', 'ethan.taylor@example.com', 1015, 34, 2200),
-- (16, 'Isabella Anderson', 'isabella.anderson@example.com', 1016, 29, 1900),
-- (17, 'James Thomas', 'james.thomas@example.com', 1017, 30, 2000),
-- (18, 'Charlotte Jackson', 'charlotte.jackson@example.com', 1018, 27, 1700),
-- (19, 'Benjamin White', 'benjamin.white@example.com', 1019, 33, 2400),
-- (20, 'Amelia Harris', 'amelia.harris@example.com', 1020, 26, 1600);

-- CREATE TABLE IF NOT EXISTS film_rating_R AS
-- SELECT
-- rating,
-- COUNT(film_id) AS film_count
-- FROM film
-- WHERE rating::text LIKE 'P%'
-- GROUP BY rating;

-- create sequence mys
-- start 1
-- increment 1;

-- select currval('mys');

-- create sequence min1
-- start 4
-- minvalue 3
-- increment 3;

-- create sequence min
-- start -1
-- minvalue -1
-- increment 1;

-- select nextval('min');

-- create table empd(

-- empid serial ,
-- empno varchar(255) default concat('TSS')|| nextval('min'),
-- salary int 

-- )
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SELECT uuid_generate_v4();

create table temp (
title varchar(255),
id serial,
uuid UUID default uuid_generate_v4()
)

insert into temp(title)
values ('one'),
('two'),
('three');

select * from temp;

create table shirts(
id serial primary key,
name varchar not null,
properties JSONB
);

INSERT INTO shirts (name, properties)
VALUES
('Ink Fusion', '{"color": "white", "size": ["S", "M", "L"]}'),
('ThreadVerse', '{"color": "black", "size": ["S", "M", "XL"]}');

select properties->>'color',properties->>'size'  from shirts;


SELECT
name,
properties->>'color' AS color,
properties->>'size' AS size
FROM shirts;
--Case 2: WHERE that checks TEXT

SELECT
name,
properties->>'color' AS color,
properties->>'size' AS size
FROM shirts
WHERE properties->>'color' = 'white';
-- Case 3: Checking array using ->> (Wrong)
SELECT
name,
properties->>'color' AS color,
properties->>'size' AS size
FROM shirts
WHERE properties->>'size' = 'XL';
-- Correct way to check inside JSON array
SELECT
name,
properties->>'color' AS color,
properties->>'size' AS size
FROM shirts
WHERE properties->'size' ? 'XL';

select * from shirts;