-- table 1: customers
create table customers (
customer_id int primary key unique, 
first_name varchar(50) not null, 
last_name varchar(50) not null, 
email varchar(100) not null unique, 
city varchar(50) not null, 
country varchar(50) not null, 
registration_date date 
);

INSERT INTO customers (customer_id, first_name, last_name, email, city, country, registration_date) 
VALUES
(1, 'John', 'Smith', 'john.smith@email.com', 'New York', 'USA', '2023-01-15'),
(2, 'Emma', 'Johnson', 'emma.j@email.com', 'London', 'UK', '2023-02-20'),
(3, 'Michael', 'Brown', 'mbrown@email.com', 'Toronto', 'Canada', '2023-01-10'),
(4, 'Sophia', 'Davis', 'sophia.d@email.com', 'Sydney', 'Australia', '2023-03-05'),
(5, 'James', 'Wilson', 'jwilson@email.com', 'New York', 'USA', '2023-02-28'),
(6, 'Oliver', 'Taylor', 'oliver.t@email.com', 'London', 'UK', '2023-04-12'),
(7, 'Ava', 'Anderson', 'ava.anderson@email.com', 'Los Angeles', 'USA', '2023-03-18'),
(8, 'William', 'Martinez', 'w.martinez@email.com', 'Madrid', 'Spain', '2023-01-25'),
(9, 'Isabella', 'Garcia', 'isabella.g@email.com', 'Mexico City', 'Mexico', '2023-02-14'),
(10, 'Lucas', 'Rodriguez', 'lucas.r@email.com', 'Buenos Aires', 'Argentina', '2023-03-30');

-- table 2:books
create table books (
book_id int primary key, 
title varchar(200) not null, 
author varchar(100) not null , 
genre varchar(50) not null, 
price numeric(8, 2) check (price >= 0), 
publication_year int, 
stock_quantity int check (stock_quantity >= 0)
)

INSERT INTO books (book_id, title, author, genre, price, publication_year, stock_quantity) 
VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 12.99, 1925, 45),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 14.99, 1960, 32),
(3, '1984', 'George Orwell', 'Science Fiction', 13.99, 1949, 28),
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 11.99, 1813, 50),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 12.99, 1951, 22),
(6, 'Harry Potter and the Sorcerer Stone', 'J.K. Rowling', 'Fantasy', 19.99, 1997, 60),
(7, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 15.99, 1937, 38),
(8, 'Brave New World', 'Aldous Huxley', 'Science Fiction', 13.99, 1932, 25),
(9, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 29.99, 1954, 41),
(10, 'Animal Farm', 'George Orwell', 'Fiction', 10.99, 1945, 55),
(11, 'Fahrenheit 451', 'Ray Bradbury', 'Science Fiction', 12.99, 1953, 30),
(12, 'The Great Adventure', 'John Anderson', 'Fiction', 16.99, 2020, 18),
(13, 'Mystery in Paris', 'Marie Dubois', 'Mystery', 14.99, 2019, 27),
(14, 'Romance in Rome', 'Isabella Rossi', 'Romance', 13.99, 2021, 35);

-- table 3: orders
create table orders (
order_id int primary key, 
customer_id int references customers(customer_id), 
book_id int references books(book_id), 
order_date date, 
quantity int check (quantity >= 0), 
total_amount numeric(8, 2) check (total_amount >= 0)
)


INSERT INTO orders (order_id, customer_id, book_id, order_date, quantity, total_amount) VALUES
(1, 1, 1, '2023-05-10', 2, 25.98),
(2, 1, 6, '2023-05-15', 1, 19.99),
(3, 2, 3, '2023-05-12', 1, 13.99),
(4, 3, 2, '2023-05-11', 3, 44.97),
(5, 4, 7, '2023-05-13', 1, 15.99),
(6, 5, 9, '2023-05-14', 2, 59.98),
(7, 2, 4, '2023-05-16', 1, 11.99),
(8, 6, 6, '2023-05-17', 2, 39.98),
(9, 7, 1, '2023-05-18', 1, 12.99),
(10, 8, 8, '2023-05-19', 1, 13.99),
(11, 1, 10, '2023-06-01', 2, 21.98),
(12, 3, 5, '2023-06-02', 1, 12.99),
(13, 9, 11, '2023-06-03', 3, 38.97),
(14, 10, 12, '2023-06-04', 1, 16.99),
(15, 4, 13, '2023-06-05', 2, 29.98),
(16, 5, 14, '2023-06-06', 1, 13.99),
(17, 2, 6, '2023-06-07', 1, 19.99),
(18, 7, 3, '2023-06-08', 2, 27.98);



select * from customers;
select * from books;
select * from orders;


-- PRACTICE QUESTIONS:

-- 1. Display all books with their titles and prices, ordered by price (lowest to highest)
select title, price from books
order by price;

-- 2.Find all distinct city 
select distinct city from customers;

-- 3. Find all books whose titles start with "The"
select * from books
where title like 'The%';

-- 4. Change the column name first_name to customer_first_name in the customers table
alter table customers
rename column first_name to customer_first_name;

-- 5. Find all books in the Fantasy genre
select * from books
where genre = 'Fantasy';

-- 6. Count the total number of orders in the database
select count(order_id) from orders;

-- 7. Find the average price of books by genre, but only show genres with an average price greater than $14
select avg(price) from books
where price > 14
group by genre

-- 8. Find all customers are from either USA or UK
select * from customers
where country = 'USA' or country = 'UK'; 

-- 9. Find the total revenue, average order amount, maximum and min order amount
select 
sum(total_amount) as total_revenue,
avg(total_amount) as average_revenue,
max(total_amount) as max_revenue,
min(total_amount) as min_revenue
from orders;

-- 10. minimum order amount from all orders placed in June 2023.
select min(total_amount) as minimum_order_amount
from orders
where order_date >= '2023-06-01' and order_date <= '2023-06-30';