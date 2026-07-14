create schema Assessment;
use Assessment;

create table country(
id int primary key,
country_name varchar (100),
country_name_eng varchar(100),
country_code varchar (50)
);

create table city (
id int primary key,
city_name varchar(50),
lat decimal(10,2),
lon decimal (10,2),
country_id int,
FOREIGN KEY (country_id) REFERENCES country(id)
);

create table customer (
id int primary key,
customer_name varchar(50),
city_id int,
customer_address varchar(100),
next_call_date date,
ts_inserted datetime,
FOREIGN KEY (city_id) REFERENCES city(id)
);

insert into country values
(1,'Dwutscland','Gemany','DEU'),
(2,'Srbija','Srbija','SRB'),
(3,'Hrvatska','Croatia','HRV'),
(4,'United_states_of_america','United_states_of_america','USA'),
(5,'Ploska','Poland','Pol'),
(6,'Espana','spain','ESP'),
(7,'Rossiya','Russia','RUS');

insert into city values 
(1,'Berlin',52.5200008,13.404954,1),
(2,'Belgrade',44.787197,20.457273,2),
(3,'Zagreb',42.815399,15.966568,3),
(4,'New York',40.730610,-73.935242,4),
(5,'Los angeles',34.052235,-118.243683,4),
(6,'warsaw',52.237049,21.017532,5);

insert into customer values 
(1,'Jewelry_Store',4,'Long_street_120','2020-01-21','2020-01-10 14:01:20.000'),
(2,'Bakery',1,'Kufurstendamm_25','2020-02-21','2020-01-09 17:52:15.000'),
(3,'cafe',1,'tauentzienstrabe_44','2020-01-21','2020-01-10 08:02:49.000'),
(4,'Restaurant',1,'Ulica_lipa_15','2020-01-21','2020-01-10 09:20:21.000');

-- Task : 1 (join multiple tables using left join)

-- List all Countries and customers related to these countries.

select Country.country_name,Customer.customer_name
from country 
left join City on Country.id = City.country_id
left join Customer on City.id = Customer.city_id;

-- For each country displaying its name in English, the name of the city customer is located in as well as the name of the customer.

select country.country_name_eng as country_name_english,city.city_name,customer.customer_name
from country
left join city on city.country_id = country.id
left join customer on customer.city_id = city.id;

-- Return even countries without related cities and customers.

select co.country_name,ci.city_name,cu.customer_name
from country co
left join city ci on co.id = ci.country_id
left join customer cu on ci.id = cu.city_id;

-- Task : 2 (join multiple tables using both left and inner join)

-- Return the list of all countries that have pairs(exclude countries which are not referenced by any city).
-- For such pairs return all customers.

select co.country_name,cu.customer_name
FROM country co
LEFT JOIN city ci ON co.id = ci.country_id
LEFT JOIN customer cu ON ci.id = cu.city_id;

-- Return even pairs of not having a single customer

select country.country_name,country.country_code,city.city_name
from country
join city on country.id = city.country_id
left join customer on city.id = customer.city_id 
where customer.id is null;
