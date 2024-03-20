use onlinefood;
show tables;
describe swiggy;

select * from swiggy limit 15;

/* Find total count of rows*/
select count(ID) from swiggy as TotalRows;

# Adding a primary key to existing table
alter table swiggy
add primary key(ID);

select * from swiggy limit 5;


/* Find total number of unquie resturanats to which order is placed*/
select count(distinct(Restaurant)) from swiggy as ResCount;

# Find total number of cities in the table
select count(distinct(City)) from swiggy;

# Find total restaurants from each city
select City, count(distinct(Restaurant)) as c from swiggy 
group by City
order by c desc;

# Find total order made from each restaurants from Banglore

select Restaurant, count(ID) as R from swiggy 
where City ="Bangalore"
group by Restaurant
order by R desc;

# Find restaurants with max order
select Restaurant, City, MaxOrder from (
select Restaurant, City, count(ID) as MaxOrder,
dense_rank() over (order by count(ID) desc) as rankk 
from swiggy 
group by Restaurant, City) as Ranking
where rankk = 1;

# Find top two restaurants with max order
select Restaurant, City, MaxOrder, rankk from (
select Restaurant, City, count(ID) as MaxOrder,
dense_rank() over (order by count(ID) desc) as rankk 
from swiggy 
group by Restaurant, City) as Ranking
where rankk between 1 and 2;

# Find restaurants from Koramangala area from Bangalore which serves chinese food
select * from swiggy
where city = 'Bangalore' and area = 'Koramangala' and food_type like '%Chinese%';

# Find average delivery time taken by swiggy
select round(avg(delivery_time)) as AvgTime from swiggy;

# find avg delivery time in each city
select City, avg(delivery_time) as AverageTime from swiggy
group by City
order by AverageTime asc;

# Find average price of food from Powai area from Mumbai
select Area, city, avg(Price) as AveragePrice from swiggy
where Area = 'Powai' and city = 'Mumbai';

# OR statement for above query
select Area, city, avg(Price) as AveragePrice from swiggy
group by Area, city
having Area = 'Powai' and City = 'Mumbai';

# Find top three cities with less average delivery time
select city, avg(Delivery_time) as AvgTime
from swiggy
group by city
order by AvgTime asc
limit 3;

/* Find highest average_ratings resturant for each city*/
select restaurant, city, max(Avg_ratings) as Highest_Ratings
from swiggy
group by city,restaurant
order by Highest_Ratings desc;

