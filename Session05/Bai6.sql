create database session05;
use session05;

create table products(
	product_id int primary key,
    product_name varchar(255),
    price decimal(10,2),
    stock int,
    status enum('active', 'inactive')
);

INSERT INTO products (product_id, product_name, price, stock, status) VALUES
(1, 'iPhone 13', 22000000, 50, 'active'),
(2, 'Ốp lưng Silicon', 150000, 200, 'active'),
(3, 'Sạc dự phòng 20000mAh', 850000, 100, 'active'),
(4, 'Tai nghe Bluetooth A1', 1200000, 45, 'active'),
(5, 'Chuột không dây M1', 450000, 0, 'inactive'),
(6, 'Bàn phím cơ K2', 1800000, 30, 'active'),
(7, 'Lót chuột cỡ lớn', 250000, 150, 'active'),
(8, 'Loa Mini Speaker', 950000, 20, 'active'),
(9, 'Cáp sạc Type-C', 120000, 500, 'active'),
(10, 'Giá đỡ điện thoại', 180000, 60, 'active'),
(11, 'Tai nghe Gaming GPRO', 2500000, 15, 'active'),
(12, 'USB 64GB', 350000, 80, 'active'),
(13, 'Webcam HD 1080p', 1450000, 12, 'active'),
(14, 'Mic thu âm chuyên dụng', 2800000, 8, 'active'),
(15, 'Đèn LED livestream', 550000, 25, 'inactive'),
(16, 'Pin dự phòng Mini', 400000, 90, 'active'),
(17, 'Túi chống sốc Laptop', 350000, 110, 'active'),
(18, 'Quạt tản nhiệt Laptop', 650000, 40, 'active'),
(19, 'Bút cảm ứng Stylus', 1100000, 18, 'active'),
(20, 'Tay cầm chơi game', 1350000, 22, 'active');

select * from products where status = 'active' and price between 1000000 and 3000000 order by price asc limit 10;
select * from products where status = 'active' and price between 1000000 and 3000000 order by price asc limit 10 offset 10;