CREATE DATABASE FUNNEL_ANALYSIS
USE funnel_analysis

create table funnel_analysis(
user_id varchar(10),
step varchar(50),
timestamp datetime )

select * from funnel_analysis
limit 10

select count(*) as number_of_records
from funnel_analysis

with cte as (
select step,
count(distinct user_id) as users
from funnel_analysis
group by step
)
select step,
users,
round(users * 100.0 / lag(users) over(order by 
case when step = 'visited_site' then 1 
when step = 'signup_started' then 2 
when step ='details_filled' then 3 
when step ='email_verified' then 4
when step = 'purchase_completed' then 5 
end ), 2) as conversion_rate
from cte 
order by 
case when step = 'visited_site' then 1 
when step = 'signup_started' then 2 
when step ='details_filled' then 3 
when step ='email_verified' then 4
when step = 'purchase_completed' then 5 end