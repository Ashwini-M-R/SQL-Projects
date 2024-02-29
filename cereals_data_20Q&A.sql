/*
Exercise 
Database: cereals 
Queries 
1. Add index name fast on name 
2. Describe the schema of table 
3. Create view name as see where users can not see type column [first run appropriate query 
then create view] 
4. Rename the view as saw 
5. Count how many are cold cereals 
6. Count how many cereals are kept in shelf 3 
7. Arrange the table from high to low according to ratings 
8. Suggest some column/s which can be Primary key 
9. Find average of calories of hot cereal and cold cereal in one query 
10. Add new column as HL_Calories where more than average calories should be categorized as 
HIGH and less than average calories should be categorized as LOW 
11. List only those cereals whose name begins with B 
12. List only those cereals whose name begins with F 
13. List only those cereals whose name ends with s 
14. Select only those records which are HIGH in column HL_calories and mail to 
jeevan.raj@imarticus.com [save/name your file as <your first name_cereals_high>] 
15. Find maximum of ratings
16. Find average ratings of those were High and Low calories 
17. Craete two examples of Sub Queries of your choice and give explanation in the script 
itself with remarks by using # 
18. Remove column fat 
19. Count records for each manufacturer [mfr] 
20. Select name, calories and ratings only
*/

create database if not exists cereals_db;
use cereals_db;
select * from cereals_data;

# 1. Add index name fast on name 
create index idx_fast on cereals_data (name);
select max(length(name)) from cereals_data;
alter table cereals_data modify name varchar(40);
create index idx_fast on cereals_data (name);
show index from cereals_data;

# 2. Describe the schema of table
describe cereals_data;

# 3. Create view name as see where users can not see type column 
# [first run appropriate query then create view] 
select * from cereals_data;
create view see as(select name,mfr,calories,protein,fat,sodium,fiber,carbo,sugars,potass,vitamins,shelf,weight,cups,rating from cereals_data);
select * from see;

# 4. Rename the view as saw
rename table see to saw;
select * from saw;

# 5. Count how many are cold cereals 
select type,count(*) as No_of_cold_cereals from cereals_data where type='c';
select type,count(*) as count_cold_cereals from cereals_data group by type having type='c';

# 6. Count how many cereals are kept in shelf 3
select shelf,count(shelf) as No_of_cereals_kept_in_shelf_3 from cereals_data where shelf=3;

# 7. Arrange the table from high to low according to ratings
select * from cereals_data order by rating desc;

# 8. Suggest some column/s which can be Primary key
select count(name) from cereals_data; 
select count(distinct name) from cereals_data; 
select name from cereals_data where name is null; /*since count of name and count of distinct name is same we can say name column is unique and not null,
											    hence name can be chosen as primary key as it is more appropriate CANDIDATE KEY.*/

# 9. Find average of calories of hot cereal and cold cereal in one query 
select * from cereals_data;
select type,round(avg(calories),0) as Average_calories from cereals_data group by type;

# 10. Add new column as HL_Calories where more than average calories should be 
# categorized as HIGH and less than average calories should be categorized as LOW 
select * from cereals_data;
select round(avg(calories),0) from cereals_data;
alter table cereals_data add column HL_Calories varchar(20);
update cereals_data set HL_Calories =case when  calories>107 then 'High' else 'Low' end;

# 11. List only those cereals whose name begins with B 
select name from cereals_data where name like 'B%';

# 12. List only those cereals whose name begins with F
select name from cereals_data where name like 'F%';
 
# 13. List only those cereals whose name ends with s
select name from cereals_data where name like '%S';

# 14. Select only those records which are HIGH in column HL_calories and mail to 
#jeevan.raj@imarticus.com [save/name your file as <your first name_cereals_high>] 
select * from cereals_data where HL_Calories ='High';

# 15. Find maximum of ratings
select round(max(rating),2) as max_of_rating from cereals_data;

# 16. Find average ratings of those were High and Low calories 
select * from cereals_data;
select HL_Calories,round(avg(rating),0) from cereals_data group by HL_calories;

# 17. Craete two examples of Sub Queries of your choice and give explanation in the script 
# itself with remarks by using #

# 1. fetch those information where potass is more than max of vitamins.
# 2. fetch those information of rating where sodium is less than average of fiber;
select potass from cereals_data where potass>(select max(vitamins) from cereals_data); # subquery executes first with calculated max value of vitamins then the each value of potass is compared to that value and only those records of potass value greater than max of vitamins is displayed in the result.
select rating from cereals_data where sodium<(select avg(fiber) from cereals_data);# subquery executes first with calculated average value of fibers then the each value of sodioum is compared to that value and only those rating of sodium value lesser than average of fiber is displayed in the result.

# 18. Remove column fat
select * from cereals_data;
alter table cereals_data drop fat;
select * from cereals_data;

# 19. Count records for each manufacturer [mfr]
select mfr,count(*) as No_of_counts_Based_on_mfr from cereals_data group by mfr;

# 20. Select name, calories and ratings only
select name,calories,rating from cereals_data;