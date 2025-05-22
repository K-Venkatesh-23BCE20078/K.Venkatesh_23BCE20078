show databases;
show tables from vit;
use vit;
select * from worker;

select count(department) from worker where department="account";
select count(department) from worker where department;

select department,count(department) from worker group by department;
select sum(salary),department from worker 
group by department
order by sum(salary) desc limit 1;

select sum(salary),department from worker 
group by department
order by sum(salary) desc limit 1 offset 1;

select department,count(*) from worker group by department having count(*)>3;

select first_name, department,salary from worker w1 where salary = (select max(salary) from worker w2);
select first_name, department from worker w1 where salary < (select max(salary) from worker w2);
SELECT * FROM worker e WHERE salary = (SELECT MAX(salary) FROM worker WHERE department = e.department);
select concat(first_name," ", last_name) as Full_Name, department, salary from worker 
where salary>=(select max(salary) from worker where department in ('hr','admin'));

create table student(
	s_id int,
    s_name varchar(50)
);
insert into student values (101,'jayanth'),(102,'karthik'),(103,'praveen'),(105,'mahesh'),(106,'Arun');

create table address(
	s_id int,
	s_address varchar(25));
insert into address values (101,'coimbatore'),(104,'chennai'),(105,'pune');	

select * from student cross join address;

select * from student s inner join address a on s.s_id = a.s_id;
select * from student s left outer join address a on s.s_id = a.s_id;
select * from student s right outer join address a on s.s_id = a.s_id;

select first_name,salary from worker order by salary desc limit 1 offset 4;
select first_name,salary from worker w1 where (select count(w2.salary) from worker w2 where w1.salary < w2.salary) =4;
