-- find total downloads
-- classify paying and non-paying
-- use condition non_paying>paying
-- order by date in ascending order

with total_downloads as (
    select * from ms_download_facts mdf
    left join ms_user_dimension mud on mud.user_id = mdf.user_id
    left join ms_acc_dimension mad on mad.acc_id = mud.acc_id
), 
    classification as (
    select date, sum(case when paying_customer = 'no' then downloads else null end) non_paying,
    sum(case when paying_customer = 'yes' then downloads else null end) paying
    from total_downloads
    group by date
)

select date, non_paying, paying from classification
where non_paying>paying
order by date asc;