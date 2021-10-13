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
), energy_consumption_ranks as (
    select date, total_consumption as total_energy, rank() over (order by total_consumption desc) as rank_
    from energy_cons_by_dates
)

select date, total_energy from energy_consumption_ranks where rank_=1;