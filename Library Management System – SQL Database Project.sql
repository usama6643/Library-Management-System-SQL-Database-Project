-- Create table "Branch"
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15)
);
-- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
);
-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE
);
-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);
-- select * from branch
-- select * from employees
-- select * from members
-- select * from books

--Display all employees working in the company
select emp_name from employees

--Show all members who registered after 2022
select member_id,extract(year from reg_date) as year from members
where extract(year from reg_date) > 2022;

-- Display all books that are currently available (status = 'Available')
select status,book_title from books
where status='yes'

--List all unique book categories
select  distinct(category) from books

--Display employee names and their salaries
select emp_name,salary from employees

--Find all books written by a specific author
select author,book_title from books
where author = 'Stephen King';
-- Show all branches with their contact numbers
select branch_id,contact_no from branch

--Find all members living in a specific city
select member_id,member_address from members

--Display books with rental price greater than 5
select * from books
where rental_price > 5;

--Find the total number of employees in each branch
select branch_id,count(emp_id) as employees from employees
group by 1

--Find the average salary of employees for each branch
select branch_id,round(avg(salary),2)as employees from employees
group by 1

--Find the total number of books in each category
select count(*)as total_books,category from books
group by 2

--Find the number of yes and No books separately
select status,count(*) from books
group by 1

--Find the highest paid employee in the company
select emp_id,salary from employees
order by salary desc
limit 1

--Find the total rental price of books for each category
select sum(rental_price),category from books
group by 2

--Find branches that have more than 2 employees
select count(*) as Numbers_of_emp ,branch_id from employees
group by 2
having count(*) > 2

--Find the total number of employees for each position
select count(*) as no_of_employees,position from employees
group by 2

--Find the most expensive book rental price in each category
select max(rental_price),category from books
group by 2

--Find employees who earn more than the average salary
select salary,emp_name from employees
where salary > (
select avg(salary) from employees
)
-- Find the total number of books published by each publisher
select count(*) as no_of_books,publisher from books
group by 2

--find the average rental price of books for each author
select round(avg(rental_price),2),author from books
group by 2

-- select * from branch
-- select * from employees
-- select * from members
-- select * from books
-- Find the total number of members registered in each year
select count(*),extract (year from reg_date) from members
group by 2

-- Find the category with the highest number of books
select category,count(*) from books
group by 1
order by 2 desc
limit 1

--Find employees whose salary is higher than their branch’s average salary
SELECT e.emp_name, e.salary FROM employees e
JOIN (SELECT branch_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY branch_id
) b
ON e.branch_id = b.branch_id
WHERE e.salary > b.avg_salary;

--Display employee name along with their branch address
select 
e.emp_name,b.branch_address
from employees e
join branch b
on e.branch_id = b.branch_id
-- Show employee name, position, and branch contact number
select e.emp_name,e.position,b.contact_no from employees e
join branch b
on e.branch_id = b.branch_id

--List all employees along with their branch details
select e.emp_id,e.position,emp_name,e.salary,b.branch_id,b.contact_no from employees e
left join branch b
on e.branch_id = b.branch_id

--Show branch_id and number of employees in each branch
select b.branch_id,count(e.emp_id) from branch b
left join employees e
on b.branch_id= e.branch_id
group by b.branch_id

--Show branch-wise total salary expense
select b.branch_id,sum(e.salary) from branch b
join employees e
on b.branch_id= e.branch_id
group by b.branch_id

--Show manager_id and how many employees work under each manager
select b.manager_id,count(e.emp_id) from branch b
join employees e
on b.branch_id= e.branch_id
group by b.manager_id

--List employees who work in the same branch as their manager
select e.emp_id,b.branch_id from employees e
join branch b
on e.emp_id = b.manager_id

--Show employee name, salary, and branch address only for branches located at a specific address
select e.emp_name,e.salary,b.branch_address from employees e
join branch b
on e.branch_id = b.branch_id
where b.branch_address = '123 Main St'

--Find employees whose salary is higher than the average salary of their branch
select e.emp_id,e.salary,b.branch_id from employees e
join(select branch_id,avg(salary) as avg_salary
from employees
group by branch_id)
b
on e.branch_id = b. branch_id
where e.salary > b.avg_salary

--show branch_id, manager_id, and total salary expense of that branch
select b.branch_id,b.manager_id,sum(e.salary) from branch b
join employees e
on b.branch_id = e.branch_id
group by b.branch_id




