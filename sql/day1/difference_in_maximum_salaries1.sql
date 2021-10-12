-- to find maximum salary in marketing department
-- to find maximum salary in engineering department
-- find the difference

-- desc db_employee;
-- desc db_dept table;

with maximum_marketing_salary as (
    select max(de.salary) max_marketing_salary from db_employee de
    inner join db_dept dd on dd.id = de.department_id
    where dd.department like '%marketing%'
), 
maximum_engineering_salary as (
    select max(de.salary) max_engineering_salary from db_employee de
    inner join db_dept dd on dd.id = de.department_id
    where dd.department like '%engineering%'
)

select (abs(max_marketing_salary-max_engineering_salary)) salary_difference
 from maximum_marketing_salary, maximum_engineering_salary;
