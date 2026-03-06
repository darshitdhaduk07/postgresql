-- CREATE TABLE course(
-- course_id SERIAL PRIMARY KEY,
-- title VARCHAR(100),
-- description VARCHAR(500),
-- price DECIMAL(8,2) CHECK(price > 0),
-- duration_hour INT CHECK(duration_hour > 0),
-- instructor_id INT REFERENCES instructor(instructor_id) ,
-- category_id INT REFERENCES category(category_id) 

-- );

-- CREATE TABLE student(
-- student_id SERIAL PRIMARY KEY,
-- full_name VARCHAR(100),
-- email VARCHAR(100) NOT NULL UNIQUE,
-- dob DATE,
-- registration_date DATE,
-- CONSTRAINT email_format_check
--     CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
-- );


-- CREATE TABLE instructor(
-- instructor_id SERIAL PRIMARY KEY,
-- full_name VARCHAR(100),
-- email VARCHAR(100) NOT NULL UNIQUE,
-- exprience int,
-- experties varchar(200),
-- CONSTRAINT email_format_check
--     CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
-- );

-- CREATE TABLE category(

-- category_id SERIAL PRIMARY KEY,
-- category_name VARCHAR(100)
-- );

-- CREATE TABLE enrollment(
-- enrollment_id SERIAL PRIMARY KEY,
-- student_id INT REFERENCES student(student_id),
-- course_id INT REFERENCES course(course_id),
-- enrollment_date DATE,
-- status VARCHAR(100)
-- );

-- CREATE TABLE payment(
-- payment_id SERIAL PRIMARY KEY,
-- enrollment_id int REFERENCES enrollment(enrollment_id),
-- amount DECIMAL CHECK (amount > 0),
-- payment_date DATE,
-- payment_method VARCHAR(100) NOT NULL,
-- transaction_reference VARCHAR(50) NOT NULL
-- );


-- CREATE TABLE assignment (
-- assignment_id SERIAL PRIMARY KEY,
-- course_id INT REFERENCES course(course_id),
-- title VARCHAR(50),
-- max_marks INT,
-- due_date DATE
-- );

-- CREATE TABLE review (
-- review_id SERIAL PRIMARY KEY,
-- enrollment_id INT REFERENCES enrollment(enrollment_id), 
-- rating INT,
-- comment VARCHAR(100),
-- review_date DATE
-- );

-- INSERT INTO instructor (full_name, email, exprience, experties) VALUES
-- ('Alice Johnson', 'alice.johnson@example.com', 5, 'Python, Data Science'),
-- ('Bob Smith', 'bob.smith@example.com', 10, 'Java, Spring'),
-- ('Carol Lee', 'carol.lee@example.com', 7, 'Web Development, HTML/CSS'),
-- ('David Brown', 'david.brown@example.com', 3, 'SQL, Databases'),
-- ('Eva Green', 'eva.green@example.com', 12, 'Machine Learning, AI');

-- INSERT INTO category (category_name) VALUES
-- ('Programming'),
-- ('Data Science'),
-- ('Web Development'),
-- ('Databases'),
-- ('AI & ML');

-- INSERT INTO course (title, description, price, duration_hour, instructor_id, category_id) VALUES
-- ('Python for Beginners', 'Learn Python from scratch', 100.00, 40, 1, 1),
-- ('Advanced Java', 'Deep dive into Java programming', 150.00, 50, 2, 1),
-- ('HTML & CSS Fundamentals', 'Build your first web pages', 80.00, 30, 3, 3),
-- ('SQL Mastery', 'Become an SQL expert', 120.00, 35, 4, 4),
-- ('Machine Learning Basics', 'Intro to ML and AI', 200.00, 60, 5, 5);

-- INSERT INTO student (full_name, email, dob, registration_date) VALUES
-- ('John Doe', 'john.doe@example.com', '1998-05-12', '2026-01-10'),
-- ('Jane Smith', 'jane.smith@example.com', '2000-08-22', '2026-01-11'),
-- ('Mike Brown', 'mike.brown@example.com', '1995-12-05', '2026-01-12'),
-- ('Emily Davis', 'emily.davis@example.com', '1999-03-18', '2026-01-13'),
-- ('Sara Wilson', 'sara.wilson@example.com', '2001-07-30', '2026-01-14');

-- INSERT INTO enrollment (student_id, course_id, enrollment_date, status) VALUES
-- (1, 1, '2026-02-01', 'Active'),
-- (2, 2, '2026-02-02', 'Active'),
-- (3, 3, '2026-02-03', 'Completed'),
-- (4, 4, '2026-02-04', 'Active'),
-- (5, 5, '2026-02-05', 'Active');

-- INSERT INTO payment (enrollment_id, amount, payment_date, payment_method, transaction_reference) VALUES
-- (1, 100.00, '2026-02-01', 'Credit Card', 'TXN1001'),
-- (2, 150.00, '2026-02-02', 'PayPal', 'TXN1002'),
-- (3, 80.00, '2026-02-03', 'Credit Card', 'TXN1003'),
-- (4, 120.00, '2026-02-04', 'Bank Transfer', 'TXN1004'),
-- (5, 200.00, '2026-02-05', 'Credit Card', 'TXN1005');

-- INSERT INTO assignment (course_id, title, max_marks, due_date) VALUES
-- (1, 'Python Project', 100, '2026-03-01'),
-- (2, 'Java Project', 100, '2026-03-05'),
-- (3, 'Web Page Design', 50, '2026-03-03'),
-- (4, 'SQL Queries', 75, '2026-03-04'),
-- (5, 'ML Model', 100, '2026-03-10');

-- INSERT INTO review (enrollment_id, rating, comment, review_date) VALUES
-- (1, 5, 'Excellent course!', '2026-02-20'),
-- (2, 4, 'Very informative.', '2026-02-21'),
-- (3, 5, 'Loved it!', '2026-02-22'),
-- (4, 3, 'Good, but could improve.', '2026-02-23'),
-- (5, 5, 'Amazing content!', '2026-02-24');


-- Total revenue per course
select c.course_id,c.title,sum(p.amount) from course c  join enrollment e using(course_id) join payment p using(enrollment_id) group by c.course_id,c.title; 

-- Students per category
select cat.category_name,count(cou.title) from category cat join course cou using(category_id) group by cat.category_name;

-- - Instructor course count
select cou.title,count(i.instructor_id) from course cou join instructor i using(instructor_id) group by cou.title;


-- - Courses with highest rating

select cou.title,r.rating from course cou join enrollment e using(course_id) join review r using (enrollment_id) order by r.rating desc limit 1;

-- - Students enrolled in more than 2 courses
select s.full_name from student s join enrollment e using(student_id) group by e.student_id,s.full_name having count(*) > 2;

