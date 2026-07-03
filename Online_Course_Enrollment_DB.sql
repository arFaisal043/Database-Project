-- Create students table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20) NULL,
    country VARCHAR(50),
    enrollment_date DATE
);

-- Create courses table
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY,
    course_title VARCHAR(150),
    category VARCHAR(50),
    price DECIMAL(10,2) CHECK(price >= 0),
    instructor VARCHAR(100),
    published_year INTEGER
);

-- Create enrollments table
CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    enrollment_date DATE,
    progress_percentage INTEGER NULL,
    paid_amount DECIMAL(10,2) CHECK(paid_amount >= 0)
);



-- Insert data into students table
INSERT INTO students (student_id, first_name, last_name, email, phone, country, enrollment_date) 
VALUES
(1, 'Rahim', 'Uddin', 'rahim@email.com', '01711111111', 'Bangladesh', '2023-01-10'),
(2, 'Karim', 'Ahmed', 'karim@email.com', NULL, 'Bangladesh', '2023-01-15'),
(3, 'Sara', 'Khan', 'sara@email.com', '01822222222', 'Pakistan', '2023-02-01'),
(4, 'John', 'Smith', 'john@email.com', NULL, 'USA', '2023-02-10'),
(5, 'Emma', 'Brown', 'emma@email.com', '01933333333', 'UK', '2023-02-20'),
(6, 'Ayaan', 'Ali', 'ayaan@email.com', NULL, 'India', '2023-03-05'),
(7, 'Lina', 'Rahman', 'lina@email.com', '01644444444', 'Bangladesh', '2023-03-12'),
(8, 'Mark', 'Taylor', 'mark@email.com', NULL, 'Australia', '2023-03-25'),
(9, 'Sophia', 'Lee', 'sophia@email.com', '01555555555', 'USA', '2023-04-01'),
(10, 'Daniel', 'Martinez', 'daniel@email.com', NULL, 'Spain', '2023-04-10');


-- Insert data into courses table
INSERT INTO courses (course_id, course_title, category, price, instructor, published_year) 
VALUES
(1, 'Complete SQL Bootcamp', 'Database', 49.99, 'John Carter', 2021),
(2, 'Advanced JavaScript', 'Programming', 59.99, 'Sarah Miller', 2020),
(3, 'Python for Data Science', 'Data Science', 69.99, 'David Kim', 2022),
(4, 'Web Development with React', 'Programming', 54.99, 'Emily Stone', 2021),
(5, 'Machine Learning Basics', 'AI', 79.99, 'Andrew Ng', 2019),
(6, 'Cloud Computing Fundamentals', 'Cloud', 64.99, 'James Allen', 2020),
(7, 'UI/UX Design Essentials', 'Design', 39.99, 'Laura Scott', 2022),
(8, 'DevOps for Beginners', 'DevOps', 74.99, 'Michael Brown', 2023);


-- Insert data into enrollments table
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, progress_percentage, paid_amount) 
VALUES
(1, 1, 1, '2023-05-01', 80, 49.99),
(2, 2, 2, '2023-05-03', NULL, 59.99),
(3, 3, 3, '2023-05-05', 60, 69.99),
(4, 4, 1, '2023-05-07', 100, 49.99),
(5, 5, 4, '2023-05-10', 40, 54.99),
(6, 6, 5, '2023-05-12', NULL, 79.99),
(7, 7, 2, '2023-06-01', 90, 59.99),
(8, 8, 6, '2023-06-02', 30, 64.99),
(9, 9, 3, '2023-06-03', 70, 69.99),
(10, 10, 7, '2023-06-04', NULL, 39.99),
(11, 1, 8, '2023-06-05', 20, 74.99),
(12, 2, 1, '2023-06-06', 50, 49.99),
(13, 3, 6, '2023-06-07', NULL, 64.99),
(14, 4, 4, '2023-06-08', 85, 54.99),
(15, 5, 5, '2023-06-09', 60, 79.99);

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;


-- PRACTICE QUESTIONS:


-- Ques 1: Display all students and their phone numbers. If the phone number is NULL, show 'Not Provided' using COALESCE.
SELECT first_name, last_name, COALESCE(phone, 'Not Provided') FROM students;

-- Ques 2: Show all courses ordered by price (highest to lowest) and limit the result to 5 courses.
SELECT * FROM courses 
ORDER BY price DESC
LIMIT 5;

-- Ques 3: Display courses for page 2, assuming 3 courses per page, using LIMIT and OFFSET.
SELECT * FROM courses
LIMIT 3 OFFSET 3*1;

-- Ques 4: Update the price of all courses in the Programming category by increasing it 10%.
UPDATE courses
SET price = price * 1.10
WHERE category = 'Programming';

-- Ques 5: Delete all enrollment records where progress_percentage is NULL.
DELETE FROM enrollments
WHERE progress_percentage IS NULL;

-- Ques 6: Find the total paid amount per course category using GROUP BY.
SELECT c.category, SUM(e.paid_amount) FROM enrollments AS e
JOIN courses AS c ON e.course_id = c.course_id
GROUP BY c.category;

-- Ques 7: Show course categories where the average course price is greater than 60 using HAVING.
SELECT category, AVG(price) FROM courses
GROUP BY category
HAVING AVG(price) > 60;

-- Ques 8: Count how many students are enrolled in each course.
SELECT c.category, COUNT(e.student_id) AS Total_Student FROM enrollments AS e
JOIN courses AS c ON e.course_id = c.course_id
GROUP BY category;

-- Ques 9: Explain what happens if you try to insert an enrollment with a student_id that does not exist in the students table.

-- Ques 10: Display student full name, course title, and paid amount using an INNER JOIN. (Multiple table join)
SELECT 
	CONCAT(s.first_name, ' ', s.last_name) AS full_name, c.course_title, e.paid_amount
FROM enrollments AS e
INNER JOIN 
	students AS s ON e.student_id = s.student_id
INNER JOIN 
	courses AS c ON e.course_id = c.course_id;


-- Ques 11: Display all students and their enrolled courses. Include students who have not enrolled in any course using a LEFT JOIN.
SELECT 
	s.student_id, 
	CONCAT(s.first_name, ' ', s.last_name) AS full_name, 
	COALESCE(c.course_title, 'NOT ENROLLED') AS Course_Title, 
	e.enrollment_date
FROM students AS s
LEFT JOIN 
	enrollments AS e ON s.student_id = e.student_id
LEFT JOIN courses AS c ON e.course_id = c.course_id
ORDER BY student_id;


-- Ques 12: Display all courses and their enrolled students. Include courses that have no enrollments using a RIGHT JOIN.
SELECT 
	s.student_id, c.course_id, COALESCE(c.course_title, 'NOT ENROLLED') AS Course_Tiltle
FROM courses AS c
RIGHT JOIN 
	enrollments AS e ON c.course_id = e.course_id
RIGHT JOIN 
	students AS s ON e.student_id = s.student_id


-- Ques 13: Display all students and all courses, even if there is no matching enrollment, using a FULL JOIN.
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    c.course_id,
    c.course_title,
    e.enrollment_id,
    e.enrollment_date,
    e.progress_percentage,
    e.paid_amount
FROM students s
FULL JOIN 
	enrollments e ON s.student_id = e.student_id
FULL JOIN 
	courses c ON e.course_id = c.course_id


-- Ques 14: Show the number of enrollments per year based on enrollment_date.
SELECT 
    EXTRACT(YEAR FROM enrollment_date) AS enrollment_year,
    COUNT(*) AS number_of_enrollments
FROM enrollments
GROUP BY EXTRACT(YEAR FROM enrollment_date)
ORDER BY enrollment_year;