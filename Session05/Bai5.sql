create database session05;
use session05;

create table orders(
	order_id int,
    customer_id int,
    total_amount decimal(10,2),
    order_date date,
	status ENUM('pending', 'completed', 'cancelled')
);

INSERT INTO orders
VALUES
(1, 101, 1500000, '2025-12-01', 'completed'),
(2, 102, 200000, '2025-12-02', 'pending'),
(3, 103, 500000, '2025-12-03', 'completed'),
(4, 104, 1200000, '2025-12-04', 'cancelled'),
(5, 105, 800000, '2025-12-05', 'pending'),
(6, 106, 2500000, '2025-12-06', 'completed'),
(7, 107, 300000, '2025-12-07', 'pending'),
(8, 108, 450000, '2025-12-08', 'cancelled'), 
(9, 109, 900000, '2025-12-09', 'completed'),
(10, 110, 150000, '2025-12-10', 'pending'),
(11, 111, 3500000, '2025-12-11', 'completed'),
(12, 112, 700000, '2025-12-12', 'pending'),
(13, 113, 1100000, '2025-12-13', 'completed'),
(14, 114, 600000, '2025-12-14', 'pending'),
(15, 115, 2200000, '2025-12-15', 'completed'),
(16, 116, 100000, '2025-12-16', 'pending'),
(17, 117, 550000, '2025-12-17', 'completed');

select * from orders where status != 'cancelled' order by order_date desc limit 5;
select * from orders where status != 'cancelled' order by order_date desc limit 5 offset 5;
select * from orders where status != 'cancelled' order by order_date desc limit 5 offset 10;