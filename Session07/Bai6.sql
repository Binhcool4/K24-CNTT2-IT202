create database session07;
use session07;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL
);


INSERT INTO customers (name, email) VALUES
('Nguyen Van An', 'an.nguyen@gmail.com'),
('Nguyen Van Bich', 'bich.tran@gmail.com'),
('Le Van Cuong', 'cuong.le@gmail.com'),
('Pham Minh Duc', 'duc.pham@gmail.com'),
('Hoang Lan Anh', 'anh.hoang@gmail.com'),
('Do Thanh Hai', 'hai.do@gmail.com'),
('Vu Kim Oanh', 'oanh.vu@gmail.com');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-12-01', 1500000.00),
(2, '2025-12-05', 450000.00),
(1, '2025-12-10', 2300000.00),
(3, '2025-12-12', 780000.00),
(5, '2025-12-15', 12000000.00),
(6, '2025-12-20', 320000.00),
(7, '2025-12-25', 5600000.00);

SELECT 
    customer_id, 
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(customer_total) 
    FROM (
        SELECT SUM(total_amount) AS customer_total 
        FROM orders 
        GROUP BY customer_id
    ) AS temp_table
);