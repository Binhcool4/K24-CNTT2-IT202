create database session07;
use session07;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL
);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-11-20', 1250000.00),
(2, '2025-11-22', 850000.00),
(3, '2025-11-25', 4200000.00),
(1, '2025-11-26', 150000.00),
(4, '2025-11-28', 9600000.00);

select * from orders
where total_amount > (select avg(total_amount) from orders);