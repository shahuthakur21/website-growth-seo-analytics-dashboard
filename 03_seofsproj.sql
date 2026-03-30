CREATE TABLE website_data (
    date DATE,
    users INT,
    sessions INT,
    traffic_source VARCHAR(50),
    device VARCHAR(50),
    bounce_rate FLOAT,
    conversion_rate FLOAT,
    avg_session_duration INT,
    pages_per_session FLOAT,
    new_users INT,
    returning_users INT
);

-- 1) Traffic source performance
select 
traffic_source, sum(users) as total_users,
round(avg(conversion_rate):: numeric,4) as avg_conversion
from website_data
group by traffic_source
order by total_users desc;

--2) Device Analysis
select device,
round(avg(bounce_rate)::numeric,4) as avg_bounce,
round(avg(conversion_rate)::numeric,4) as avg_conversion
from website_data
group by device;

--3) Enagagement Analysis
select traffic_source,
round(avg(avg_session_duration)::numeric,2) as avg_bounce,
round(avg(pages_per_session)::numeric,2) as avg_conversion
from website_data
group by traffic_source;

--4) New vs Returning
select 
sum(new_users) as total_new_users,
sum(returning_users) as total_returning_users
from website_data;

--5)Daily Growth Trend 
select date, 
sum(users) as daily_users
from website_data
group by date
order by date;

--avdance

--6) Conversion Funnel 
select 
sum(users) as total_users,
sum(sessions) as total_sessions,
round(avg(conversion_rate)::numeric,4) as avg_conversion
from website_data;

-- 7) Best Performing Day
select date,
sum(users) as total_users
from website_data
group by date
order by total_users desc
limit 3;

--8) Worst Performing Channel
select traffic_source,
avg(conversion_rate) as avg_conversion
from website_data
group by traffic_source
order by avg_conversion asc
limit 1;

--9) High Bounce + Low Conversion
select traffic_source,
avg(bounce_rate) as bounce,
avg(conversion_rate) as conversion
from website_data
group by traffic_source;

--10) Retention Analysis
select
round(sum (returning_users)::numeric/sum(users),2) as retention_ratio
from website_data;
