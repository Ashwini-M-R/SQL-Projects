use org;
# Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
select first_name WORKER_NAME from worker;
 
# Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
select upper(first_name) from worker;

# Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
select distinct(department) from worker;

# Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
select substring(first_name,1,3) from worker;

# Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.
select position('a' in 'amitabh');
select instr(first_name,  'a') from worker where first_name='amitabh';

# Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
select rtrim(first_name) Worker_name from worker;

# Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
select ltrim(department) from worker;

# Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
select distinct(department),length((department)) from worker;

# Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
select first_name,replace(first_name,'a','A') from worker;

# Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
select concat(first_name,' ',last_name) COMPLETE_NAME from worker;

# Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
select * from worker order by first_name asc;

# Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
select * from worker order by first_name asc, department desc;

# Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
select * from worker where first_name in('vipul', 'satish');

# Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
select * from worker where first_name not in ('vipul','satish');

# Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
select * from worker where department='admin';

# Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
select * from worker where first_name like '%a%';
select * from worker where first_name regexp 'a';

# Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
select * from worker where first_name like '%a';
select * from worker where first_name regexp 'a$';

# Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
select * from worker where first_name like '______h';

# Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
select * from worker where salary between 100000 and 500000;

# Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
select * from worker where joining_date like '2014-02%';
select * from worker where year(joining_date)='2014' and month(joining_date)=2;    # This is more profitional

# Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
select count(*) 'No of workers in admin' from worker where department ='admin';

# Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
select concat(first_name,' ',last_name) as Worker_name from worker where salary between 50000 and 100000;

# Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
select department,count(*) 'No_of_workers' from worker group by department order by No_of_workers desc;

# Q-24. Write an SQL query to print details of the Workers who are also Managers.
select * from worker;
select * from title;
select * from worker w inner join title t on w.worker_id=t.worker_ref_id where worker_title='Manager';

# Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.
select * from title;
select worker_title,affected_from,count(*) from title group by worker_title,affected_from having count(*)>1;

# Q-26. Write an SQL query to show only odd rows from a table.
select * from worker where mod(worker_id,2)!=0;

# Q-27. Write an SQL query to show only even rows from a table.
select * from worker where mod(worker_id,2) =0;

# Q-28. Write an SQL query to clone a new table from another table.
drop table if exists clone;

create table worker_clone like worker;      # without information
select * from worker_clone;
create table worker_clone1 select * from worker;     # with information
select * from worker_clone1;

# Q-29. Write an SQL query to fetch intersecting records of two tables.
select * from worker where worker_id in (select worker_ref_id from bonus);

# Q-30. Write an SQL query to show records from one table that another table does not have.
select * from worker where worker_id not in (select worker_ref_id from bonus);

# Q-31. Write an SQL query to show the current date and time.
select now();
select curdate();
select current_date();
select sysdate() from dual;

# Q-32. Write an SQL query to show the top n (say 5) records of a table.
select * from worker limit 5;

# Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
select * from (select *,rank() over( order by salary desc) Nth_salary from worker) t where t.nth_salary=5;

# Q-34. Write an SQL query to determine the 5th highest salary without using TOP or limit method.
select * from worker where salary<(select salary from worker group by salary order by salary desc limit 3,1) order by salary desc limit 1;

# Q-35. Write an SQL query to fetch the list of employees with the same salary.
select * from worker where salary in(select salary from worker group by salary having count(salary)>1);



Select distinct W.WORKER_ID, W.FIRST_NAME, W.Salary 
from Worker W, Worker W1 
where W.Salary = W1.Salary 
and W.WORKER_ID != W1.WORKER_ID;

# Q-36. Write an SQL query to show the second highest salary from a table.

select * from (select *,dense_rank() over(order by salary desc) as dense_rank_info from worker)t where t.Dense_rank_info=2;

select salary from worker group by salary order by salary desc limit 1,1; # when salary is unique only.
select max(salary) from worker where salary not in(select max(salary) from worker);	# when salary is unique only.

# Q-37. Write an SQL query to show one row twice in results from a table.
select * from worker union all select * from worker order by worker_id;

# Q-38. Write an SQL query to fetch intersecting records of two tables.
select w.*,wc.* from worker w inner join worker_clone1 wc on w.worker_id=wc.worker_id;

# Q-39. Write an SQL query to fetch the first 50% records from a table.
select * from worker where worker_id<=(select round(count(*)/2) from worker);

# Q-40. Write an SQL query to fetch the departments that have less than 3 people in it.
select department,count(department) No_of_worker from worker group by department having No_of_worker<3;

# Q-41. Write an SQL query to show all departments along with the number of people in there.
select department,count(*) as 'Number of worker' from worker group by department ;

# Q-42. Write an SQL query to show the last record from a table.
select * from worker order by worker_id desc limit 1;

# Q-43. Write an SQL query to fetch the first row of a table.
select * from worker limit 1;

# Q-44. Write an SQL query to fetch the last five records from a table.
select * from (select * from worker order by worker_id desc limit 5) t order by t.worker_id asc;

# Q-45. Write an SQL query to print the name of employees having the highest salary in each department.

select* from (select *,dense_rank() over(partition by department order by salary desc) as higest_salary from worker) t where t.higest_salary =1;

select department,max(salary) as MAX_SALARY from worker group by department;
select concat(first_name,' ',last_name) as Full_name,department,salary from worker where salary in (select max(salary) from worker group by department );

SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary from(SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT) as TempNew 
Inner Join Worker t on TempNew.DEPARTMENT=tDEPARTMENT 
 and TempNew.TotalSalary=t.Salary;
 
# Q-46. Write an SQL query to fetch three max salaries from a table.
select max(salary) from worker group by salary order by salary desc limit 3;

# Q-47. Write an SQL query to fetch three min salaries from a table.
select min(salary) from worker group by salary order by salary desc limit 3;

# Q-48. Write an SQL query to fetch nth max salaries from a table. (say 4th)
select* from (select *,dense_rank() over(order by salary desc) as higest_salary from worker) t where t.higest_salary =4;
select distinct(salary) from worker order by salary desc limit 3,1;

# Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
select department, sum(salary) as total_salaries from worker group by department;

# Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select concat(first_name," ",last_name)as worker_name,salary from worker where salary =(select max(salary) from worker);
