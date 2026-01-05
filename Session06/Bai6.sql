create database session06;
use session06;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    CONSTRAINT fk_items_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop Dell', 15000000),
(2, 'Chuột Logitech', 500000),
(3, 'Bàn phím cơ', 2000000),
(4, 'Màn hình 24 inch', 4500000),
(5, 'Tai nghe Sony', 3000000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 1),
(101, 2, 2), 
(102, 3, 3), 
(103, 4, 2), 
(104, 5, 1); 

SELECT 
    p.product_name AS `Tên sản phẩm`,
    SUM(oi.quantity) AS `Tổng số lượng bán`,
    SUM(oi.quantity * p.price) AS `Tổng doanh thu`,
    AVG(p.price) AS `Giá bán trung bình`
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING `Tổng số lượng bán` >= 10
ORDER BY `Tổng doanh thu` DESC
LIMIT 5;