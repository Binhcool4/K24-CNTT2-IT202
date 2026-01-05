create database session06;
use session06;

create table customers(
	customer_id int primary key,
    full_name varchar(50),
    city varchar(50)
);

create table orders (
	order_id int primary key,
    customer_id INT,
    order_date DATE,
    total_amount decimal(10,2),
    status ENUM('pending', 'completed', 'cancelled'),
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Nguyen Van B', 'Da Nang'),
(3, 'Nguyen Van C', 'Ho Chi Minh'),
(4, 'Nguyen Van D', 'Ha Noi'),
(5, 'Nguyen Van E', 'Can Tho');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
(101, 1, '2025-01-01', '1500000', 'completed'),
(102, 2, '2025-01-02', '200000','pending'),
(103, 1, '2025-01-03', '500000','completed'),
(104, 3, '2025-01-04',  '1200000','cancelled'),
(105, 5, '2025-01-05', '800000','completed');

-- Hiển thị tổng tiền mà mỗi khách hàng đã chi tiêu
SELECT c.full_name, sum(o.total_amount) as total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
group by c.full_name;

-- Hiển thị giá trị đơn hàng cao nhất của từng khách
SELECT c.full_name, max(o.total_amount) AS highest_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

-- Sắp xếp danh sách khách hàng theo tổng tiền giảm dần
SELECT c.*, sum(o.total_amount) as total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
group by c.customer_id ,c.full_name
order by total_spent desc;