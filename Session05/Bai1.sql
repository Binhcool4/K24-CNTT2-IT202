create database session05;
use session05;

create table products(
	product_id int primary key,
    product_name varchar(255),
    price decimal(10,2),
    stock int,
    status enum('active', 'inactive')
);

insert into products
values(1, "A", 100000, 25, 'active'),
(2, "B", 10000, 25, 'inactive'),
(3, "C", 1500000, 25, 'active'),
(4, "D", 200000, 25, 'inactive'),
(5, "E", 2300000, 25, 'active');

select * from products;
select * from products where status = 'active';
select * from products where price > 1000000;
select * from products where status = 'active'order by price asc;
