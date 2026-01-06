create database session07;
use session07;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(12, 2) NOT NULL
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO products (name, price) VALUES
('Laptop MacBook Air M2', 28000000.00),
('iPhone 15 Pro', 25000000.00),
('Chuột Magic Mouse', 2200000.00),
('Bàn phím Magic Keyboard', 3500000.00),
('Màn hình LG 27 inch', 8500000.00);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 1),
(101, 3, 2), 
(102, 2, 1), 
(102, 5, 1), 
(103, 4, 3), 
(103, 2, 1); 

select * from products p
where id in (select product_id from order_items);