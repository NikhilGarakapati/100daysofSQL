-- append all the tables
-- find the maximum energy consumption 
-- find the dates on which the max energy+
-- +consumption occured

with total_energy_consumptions as (
    select * from energy_consumption_asia
    union all
    select * from energy_consumption_europe
    union all
    select * from energy_consumption_na
), energy_cons_by_dates as (
    select date, sum(consumption) total_consumption from total_energy_consumptions
    group by date
), max_energy as (
    select max(total_consumption) from energy_cons_by_dates
)
    
select * from energy_cons_by_dates
where total_consumption = (select * from max_energy);