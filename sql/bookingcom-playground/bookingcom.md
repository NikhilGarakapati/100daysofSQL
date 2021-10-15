# Exploring the booking.com sample dataset

Dataset can be download from [here](https://data.world/promptcloud/bookingcom-hotel-listings)

We will explore the data and bring out some usecases that makes sense starting with basic exploring and cleaning the data.

---
**Check whether all the records have a hotel_name, hotel_address, hotel_id**

```
select * from `db_hotels`
where (name = '' and name is  null) or
(hotel_id = '' and hotel_id is null) or
(address = '' and address is  null)
```

**Find whether every hotel_id or uniq_id are repeating**
```
select hotel_id, count(hotel_id) c from db_hotels
group by hotel_id
having c > 1
```

**Find the total hotels in every city**
```
select city, count(hotel_id) total_hotels from db_hotels
group by city
order by city
```

**Find out the hotels with no rating**
```
select city, count(hotel_id) from db_hotels
where hotel_star_rating = '' or hotel_star_rating is null
group by city
```

**Find out the 5 and 3 star hotels in every city**
```
select city, count(hotel_id) total_hotels,
count(case when hotel_star_rating like '%5%' then hotel_star_rating else null end) total_5_star_hotels,
count(case when hotel_star_rating like '%3%' then hotel_star_rating else null end) total_3_star_hotels,
count(case when hotel_star_rating not like '%5%' and hotel_star_rating not like '%3%' then hotel_star_rating else null end) total_other_star_hotels
from db_hotels
group by city
```

**Find out whether there any hotels with same address**
```
select address, count(hotel_id) total_hotels from db_hotels
group by address
having total_hotels > 1
```
**Find out whether a hotel with same name and address are repeating**
```
select name, address, count(hotel_id) total_hotels from db_hotels
group by name, address
having total_hotels > 1
```

**Find out whether a same address is being used more once with hotel_start_rating classification**
```
select address, count(hotel_id) total_hotels,
count(case when hotel_star_rating like '%5%' then hotel_star_rating else null end) total_5_star_hotels,
count(case when hotel_star_rating like '%3%' then hotel_star_rating else null end) total_3_star_hotels,
count(case when hotel_star_rating not like '%5%' and hotel_star_rating not like '%3%' then hotel_star_rating else null end) total_other_star_hotels
from db_hotels
group by address
having total_hotels > 1
```

**List out the hotel_types present that were registered**
```
select DISTINCT hotel_type from db_hotels
where hotel_type is not null and hotel_type != ''
```

**Find the hotels that don't have any hotel_type**
```
select * from db_hotels
where hotel_type is null or hotel_type = ''
```

**Find the hotels that don't have any hotel_type in every city by hotel_star_rating wise**
```
select city, count(hotel_id) total_hotels,
count(case when hotel_star_rating like '%5%' then hotel_star_rating else null end) total_5_star_hotels,
count(case when hotel_star_rating like '%4%' then hotel_star_rating else null end) total_4_star_hotels,
count(case when hotel_star_rating like '%3%' then hotel_star_rating else null end) total_3_star_hotels,
count(case when hotel_star_rating like '%2%' then hotel_star_rating else null end) total_2_star_hotels,
count(case when hotel_star_rating like '%1%' then hotel_star_rating else null end) total_1_star_hotels,
count(case when hotel_star_rating not like '%5%' and hotel_star_rating not like '%2%' and 
      hotel_star_rating not like '%3%' and hotel_star_rating not like '%4%' and
      hotel_star_rating not like '%1%' then hotel_star_rating else null end) no_star_hotels
from db_hotels
where hotel_type is null or hotel_type = ''
group by city
```