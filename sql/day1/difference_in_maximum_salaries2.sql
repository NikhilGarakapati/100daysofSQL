-- to find maximum salary in marketing department
-- to find maximum salary in engineering department
-- find the difference

-- desc db_employee;
-- desc db_dept table;

select abs(max(case when dd.department like '%marketing%' then de.salary else null end) -
max(case when dd.department like '%engineering%' then de.salary else null end)) salary_difference
from db_employee de
inner join db_dept dd on dd.id = de.department_id