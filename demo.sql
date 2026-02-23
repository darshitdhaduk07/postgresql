-- create table demo(num int);

-- insert into demo values (1),(2),(3),(null);
-- drop table demo
-- select * from demo

-- select * from demo order by num nulls first;

-- select * from demo order by num desc nulls last;

-- select distinct * from demo 

-- Create table employee(
-- 	employee_id int primary key,
-- 	first_name varchar(255) not null,
-- 	last_name varchar(255) not null,
-- 	manager_id int,
-- 	foreign key (manager_id)
-- 	references employee(employee_id)
-- 	on Delete cascade
-- );

-- CREATE TABLE sales (
--     brand VARCHAR NOT NULL,
--     segment VARCHAR NOT NULL,
--     quantity INT NOT NULL,
--     PRIMARY KEY (brand, segment)
-- );

-- INSERT INTO sales (brand, segment, quantity)
-- VALUES
--     ('ABC', 'Premium', 100),
--     ('ABC', 'Basic', 200),
--     ('XYZ', 'Premium', 100),
--     ('XYZ', 'Basic', 300);

-- SELECT
--     brand,
--     segment,
--     SUM(quantity)
-- FROM
--     sales
-- GROUP BY
--     brand,
--     segment;



