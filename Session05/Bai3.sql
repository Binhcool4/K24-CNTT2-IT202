create database session05;
use session05;

create table orders(
	order_id int,
    customer_id int,
    total_amount decimal(10,2),
    order_date date,
	status ENUM('pending', 'completed', 'cancelled')
);

insert into orders
values(1,1, 100000, '2006-12-12',  'pending'),
(2,1, 10000000, '2006-12-12', 'completed'),
(3,1, 5100000, '2006-12-12', 'completed'),
(4,1, 6100000, '2006-12-12', 'completed'),
(5,1, 7100000, '2006-12-12', 'completed');

select * from orders where status = 'completed';
select * from orders where total_amount > 5000000;
select * from orders limit 5;
select * from orders where status = 'completed' order by total_amount desc;