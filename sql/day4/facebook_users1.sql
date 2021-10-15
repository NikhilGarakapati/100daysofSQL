-- Given user1 and user2 are pair of friends
-- user1 is a friend to user2
-- user2 is also a friend to user1
-- Popularity_% = (total_friends/total_users)*100

with friends as (
    select user1, user2 from facebook_friends
    union
    select user2, user1 from facebook_friends
), total_friends as (
    select user1, count(user2) total_count from friends
    group by user1
    order by user1 asc
), cte3 as (
    select count(user1) as total_counts from total_friends
)

select user1, (((total_count*1.0)/(select total_counts from cte3))*100) popularity_percent
from total_friends;