create database session05;
use session06;

create table customers(
	customer_id int primary key,
    full_name varchar(255),
    email varchar(255),
    city varchar(255),
    status enum('active','inactive')
);

insert into customers
values(1, "b", 'A@gmail.com',"TP.HCM", "inactive"),
(2, "a", 'B@gmail.com',"Hà Nội", "active");

select * from customers;
select * from customers where city = "TP.HCM";
select * from customers where city = "Hà Nội" and status = 'active';
select * from customers order by full_name asc;