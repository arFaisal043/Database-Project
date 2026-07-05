create table students(
	student_id serial,
	user_name varchar(100) not null,
	email varchar(100) ,
	age int check(age >= 18),
	is_active boolean default true,

    -- set constraints
	primary key(student_id),
	-- here, the combination must be unique, not just the username or emai alone
	unique(user_name, email) 
)


select * from students;

INSERT INTO students (user_name, email, age, is_active) 
VALUES
('john_doe', 'john.doe@email.com', 22, true),
('jane_smith', 'jane.smith@email.com', 25, true),
('mike_johnson', 'mike.j@email.com', 19, true),
('sarah_wilson', 'sarah.w@email.com', 21, false),
('alex_brown', 'alex.brown@email.com', 28, true),
('emily_davis', 'emily.d@email.com', 20, true),
('chris_miller', 'chris.m@email.com', 23, false),
('lisa_anderson', 'lisa.a@email.com', 24, true),
('david_clark', 'david.c@email.com', 30, true),
('john_doe', 'doa.doe@email.com', 22, true),
('emma_white',null, 22, true);



drop table students;


-- working with null value
select * from students
where email is null;

select user_name, email, age, coalesce(email, 'NOT Found') 
from students;



-- Pagination by Limit + Offset
select * from students
limit 3 offset 4


-- Group by with Having
select count(student_id) from students
group by is_active
having min(age) > 20;




-- _________ Create Table for practicing JOIN ______________________________

-- users table
create table users(
id serial primary key,
name varchar(50) not null
);

INSERT INTO users (name) VALUES 
('John Smith'),
('Emma Johnson'),
('Michael Brown'),
('Sarah Davis'),
('James Wilson'),
('Maria Martinez'),
('David Anderson'),
('Lisa Taylor'),
('Robert Thomas'),
('Jennifer White');


-- post table
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INT REFERENCES users(id)
);

INSERT INTO posts (title, user_id) VALUES 
('My First Blog Post', 1),
('10 Tips for Better Coding', 3),
('The Future of Technology', 5),
('How to Learn SQL Quickly', 2),
('Best Practices for Database Design', 4),
('Introduction to Machine Learning', 6),
('Web Development Trends 2024', 7),
('Data Analytics for Beginners', 8),
('Mastering Python Programming', 9),
('The Art of Problem Solving', 10),
('Building Scalable Applications', 1),
('Cloud Computing Explained', 3),
('DevOps: A Complete Guide', 5),
('Cybersecurity Fundamentals', 2),
('Mobile App Development Tips', 4),
('AI in Everyday Life', 6),
('Top 10 Programming Languages', 7),
('How to Ace a Technical Interview', 8);



select * from users;
select * from posts;


-- Inner Join
select p.id, p.title, u.name, u.id from posts as p
inner join users as u on p.user_id = u.id;


-- Left Join
select p.id, p.title, u.name, u.id from posts as p
left join users as u on p.user_id = u.id;


-- Full join
select p.id, p.title, u.name, u.id from posts as p
full join users as u on  p.user_id = u.id;


-- Cross Join
SELECT p.id, p.title, u.name, u.id from posts as p
CROSS JOIN users as u;


-- Natural Join
select * from posts
natural join



-- _________ Create Table for practicing Sub Query ______________________________

create table employees(
	id serial primary key,
	name varchar(50),
	dept varchar(50),
	salary int
)

INSERT INTO employees (name, dept, salary) VALUES
-- IT Department (10 employees)
('Alice Johnson', 'IT', 75000),
('Bob Smith', 'IT', 82000),
('Carol White', 'IT', 91000),
('David Brown', 'IT', 68000),
('Eva Martinez', 'IT', 72000),
('Frank Wilson', 'IT', 85000),
('Grace Lee', 'IT', 79000),
('Henry Davis', 'IT', 94000),
('Ivy Taylor', 'IT', 67000),
('Jack Anderson', 'IT', 88000),

-- HR Department (8 employees)
('Karen Thomas', 'HR', 62000),
('Leo Garcia', 'HR', 58000),
('Mia Robinson', 'HR', 65000),
('Noah Clark', 'HR', 54000),
('Olivia Rodriguez', 'HR', 67000),
('Peter Lewis', 'HR', 61000),
('Quinn Walker', 'HR', 59000),
('Rachel Hall', 'HR', 63000),

-- Finance Department (9 employees)
('Sam Allen', 'Finance', 78000),
('Tina Young', 'Finance', 81000),
('Umar Hernandez', 'Finance', 73000),
('Vera King', 'Finance', 69000),
('Will Wright', 'Finance', 84000),
('Xena Lopez', 'Finance', 76000),
('Yusuf Hill', 'Finance', 71000),
('Zara Scott', 'Finance', 79000),
('Adam Green', 'Finance', 82000),

-- Marketing Department (9 employees)
('Betty Adams', 'Marketing', 64000),
('Carl Baker', 'Marketing', 71000),
('Diana Nelson', 'Marketing', 68000),
('Ethan Carter', 'Marketing', 59000),
('Fiona Mitchell', 'Marketing', 66000),
('George Perez', 'Marketing', 70000),
('Hannah Roberts', 'Marketing', 63000),
('Ian Turner', 'Marketing', 72000),
('Julia Phillips', 'Marketing', 67000),

-- Sales Department (8 employees)
('Kevin Campbell', 'Sales', 88000),
('Laura Evans', 'Sales', 92000),
('Mike Edwards', 'Sales', 85000),
('Nina Collins', 'Sales', 79000),
('Oscar Stewart', 'Sales', 81000),
('Patricia Morris', 'Sales', 76000),
('Randy Murphy', 'Sales', 84000),
('Sandra Cook', 'Sales', 89000),

-- Operations Department (6 employees)
('Tom Rogers', 'Operations', 69000),
('Uma Peterson', 'Operations', 72000),
('Victor Cooper', 'Operations', 67000),
('Wendy Reed', 'Operations', 74000),
('Xavier Bailey', 'Operations', 71000),
('Yvonne Bell', 'Operations', 68000);


select * from employees


-- q1: find the highest salarys
select max(salary) from employees;


-- q2: find which employee gets the highest salary
select * from employees
where salary = (select max(salary) from employees);


-- q3: find which employee gets more than the average salary
select * from employees
where salary > (select avg(salary) from employees);


-- q4: find which employee gets the highest salary in HR dept
select * from employees
where dept = 'HR' and salary = (
	select max(salary) from employees
	where dept = 'HR'
);






-- --------- Function in sql --------------------------------------


-- CREATE A FUNCTION FOR COUNT EMPLOYEES
CREATE FUNCTION employee_count()
RETURNS INT
LANGUAGE SQL
AS
$$
	SELECT COUNT(*) FROM employees
$$

-- call function
SELECT employee_count();




-- CREATE A FUNCTION FOR DELETE USER
CREATE FUNCTION delete_users(emp_id INT) 
RETURNS VOID
LANGUAGE SQL
AS 
$$
	DELETE FROM employees
	WHERE id = emp_id
$$

-- call function
SELECT delete_users(50);

-- CHECK EMPLOYEE IS REMOVE OR NOT
SELECT * FROM employees







-- --------- Procedure in sql --------------------------------------

CREATE PROCEDURE delete_emp_byId(emp_id INT)
LANGUAGE plpgsql
AS
$$
BEGIN
	DELETE FROM employees
	WHERE id = emp_id;
END;
$$

-- Call Procedure
CALL delete_emp_byId(49);



-- 10% salary increament by dept
CREATE PROCEDURE salary_increament(emp_dept VARCHAR(50))
LANGUAGE plpgsql
AS
$$
BEGIN
	UPDATE employees
	SET salary = salary * 1.10;
END;
$$

-- Call Procedure
CALL salary_increament('IT');








-- --------- Trigger in sql --------------------------------------

DROP TABLE IF EXISTS employees_logs;

-- Create a Log Table for store all logs when an user is deleted
CREATE TABLE employees_logs(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    emp_name VARCHAR(100),
    action VARCHAR(25),
    action_time TIMESTAMP DEFAULT NOW()
);


-- CREATE A FUNCTION FOR DELETE USER LOGS AND INSERT LOGS INTO employees_logs TABLE
CREATE FUNCTION logs_emp_deletion()
RETURNS TRIGGER
LANGUAGE plpgsql  
AS 
$$
BEGIN
	INSERT INTO employees_logs(emp_name, action) 
	VALUES (OLD.name, 'User is deleted');
	RETURN OLD;
END;
$$;


-- Create a Trigger. This will triggered when delete function invoked
CREATE TRIGGER save_employee_delete_logs
AFTER DELETE
ON employees
FOR EACH ROW
EXECUTE FUNCTION logs_emp_deletion()


-- DELETE AN USER TO CHECK USER ARE ADD ON employees_logs TABLES OR NOT

-- CREATE A FUNCTION FOR DELETE USER
CREATE FUNCTION delete_users(emp_id INT) 
RETURNS VOID
LANGUAGE plpgsql 
AS 
$$
BEGIN
    DELETE FROM employees
    WHERE id = emp_id;  
END;
$$;

-- call function
SELECT delete_users(46);



SELECT * FROM employees
SELECT * FROM employees_logs

