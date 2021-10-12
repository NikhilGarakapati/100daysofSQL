# 100daysofSQL

- The purpose of accepting this challenge is to dive deep in Querying concepts starting from basic SQL problem solving 
to performance tuning, query optimization etc.,

- This repository would contain the `Python` way of solving the problems.


---
## Day1

**Problem statement:**

Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the difference in salaries.

**Data Structure:**
[View here](https://github.com/NikhilGarakapati/100daysofSQL/blob/main/datasets/Day1/data_model.PNG)

**Datasets:**
[View here](https://github.com/NikhilGarakapati/100daysofSQL/tree/main/datasets/Day1)


**Solution1:**

```
select abs(max(case when dd.department like '%marketing%' then de.salary else null end) -
max(case when dd.department like '%engineering%' then de.salary else null end)) salary_difference
from db_employee de
inner join db_dept dd on dd.id = de.department_id
```

**Solution2:**

```
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
```