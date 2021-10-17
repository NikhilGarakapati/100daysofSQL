-- To find whether a user made a second purchase within 7 days of their first purchase
-- list all the user ids along with the item count

with 
cte1 as (
    select user_id, item, created_at, 
    lag(created_at, 1) over (partition by user_id order by created_at asc) last_purchased_date
    from amazon_transactions
), 
cte2 as (
    select user_id, item, coalesce(created_at-last_purchased_date, 0) as time_period from cte1
    order by user_id
)


select user_id, count(item) total_items from cte2
where time_period <=7
group by user_id
order by user_id asc;
