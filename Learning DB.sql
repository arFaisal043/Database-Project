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
natural join users;

