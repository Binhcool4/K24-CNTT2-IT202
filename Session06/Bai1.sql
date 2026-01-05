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
    status ENUM('pending', 'completed', 'cancelled'),
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Nguyen Van B', 'Da Nang'),
(3, 'Nguyen Van C', 'Ho Chi Minh'),
(4, 'Nguyen Van D', 'Ha Noi'),
(5, 'Nguyen Van E', 'Can Tho');

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(101, 1, '2025-01-01', 'completed'),
(102, 2, '2025-01-02', 'pending'),
(103, 1, '2025-01-03', 'completed'),
(104, 3, '2025-01-04', 'cancelled'),
(105, 5, '2025-01-05', 'completed');

-- Hiển thị danh sách đơn hàng kèm tên khách hàng
SELECT o.*, c.full_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
SELECT c.*, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

-- Chỉ hiển thị các khách hàng có ít nhất 1 đơn hàng
SELECT c.*, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING order_count >= 1;