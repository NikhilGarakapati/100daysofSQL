-- To find whether a user made a second purchase within 7 days
-- list all the user ids

with 
cte1 as (
    select user_id, created_at, 
    lag(created_at, 1) over (partition by user_id order by created_at asc) last_purchased_date
    from user_purchases
), 
cte2 as (
    select user_id, created_at-last_purchased_date as time_period from cte1
    order by user_id
)

select distinct user_id from cte2
where time_period <=7
order by user_id asc;


select * from user_purchases;