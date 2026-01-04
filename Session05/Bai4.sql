create database session05;
use session05;

create table products(
	product_id int primary key,
    product_name varchar(255),
    price decimal(10,2),
    stock int,
    sold_quantity int,
    status enum('active', 'inactive')
);

INSERT INTO products  
VALUES
(1, 'iPhone 15 Pro', 28000000, 50, 120, 'active'),
(2, 'Samsung Galaxy S23', 19000000, 30, 85, 'active'),
(3, 'MacBook Air M2', 24500000, 20, 45, 'active'),
(4, 'Chuột Logitech G502', 1200000, 150, 300, 'active'),
(5, 'Bàn phím cơ AKKO', 1500000, 80, 150, 'active'),
(6, 'Tai nghe Sony XM5', 6500000, 15, 60, 'active'),
(7, 'Màn hình Dell UltraSharp', 8200000, 10, 25, 'active'),
(8, 'Loa Bluetooth Marshall', 4500000, 0, 90, 'inactive'),
(9, 'Ổ cứng SSD 1TB', 1800000, 200, 400, 'active'),
(10, 'Webcam Logitech C922', 2100000, 40, 75, 'active'),
(11, 'iPad Pro M2', 22000000, 12, 35, 'active'),
(12, 'Sạc dự phòng Anker', 800000, 300, 550, 'active'),
(13, 'Bút vẽ cảm ứng Wacom', 3500000, 5, 10, 'active'),
(14, 'Máy in HP LaserJet', 4200000, 0, 15, 'inactive'),
(15, 'Túi chống sốc Laptop', 350000, 500, 1000, 'active');

select * from products order by sold_quantity desc limit 10;
select * from products order by sold_quantity desc limit 5 offset 10;
select * from products where price < 2000000 order by sold_quantity desc;