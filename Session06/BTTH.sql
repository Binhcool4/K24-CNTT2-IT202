/* =========================================================
   FILE SQL: ecommerce_practice.sql
   MÔN HỌC : CƠ SỞ DỮ LIỆU / SQL
   CHỦ ĐỀ  : JOIN – AGGREGATE – GROUP BY – HAVING
   MÔ TẢ   : CSDL mẫu hệ thống thương mại điện tử (eCommerce)
   ========================================================= */


/* =========================================================
   1. TẠO CƠ SỞ DỮ LIỆU
   ========================================================= */

CREATE DATABASE ecommerce_db;
USE ecommerce_db;


/* =========================================================
   2. TẠO BẢNG KHÁCH HÀNG
   ========================================================= */

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,        -- Mã khách hàng
    customer_name VARCHAR(100),            -- Tên khách hàng
    email         VARCHAR(100),            -- Email
    city          VARCHAR(50)               -- Thành phố
);


/* =========================================================
   3. TẠO BẢNG SẢN PHẨM
   ========================================================= */

CREATE TABLE products (
    product_id   INT PRIMARY KEY,          -- Mã sản phẩm
    product_name VARCHAR(100),              -- Tên sản phẩm
    price        DECIMAL(12,2),              -- Giá bán
    category     VARCHAR(50)                -- Loại sản phẩm
);


/* =========================================================
   4. TẠO BẢNG ĐƠN HÀNG
   ========================================================= */

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,            -- Mã đơn hàng
    customer_id INT,                        -- Khách hàng đặt
    order_date  DATE,                       -- Ngày đặt hàng
    status      VARCHAR(30),                -- Trạng thái đơn
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


/* =========================================================
   5. TẠO BẢNG CHI TIẾT ĐƠN HÀNG
   ========================================================= */

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,          -- Mã chi tiết đơn
    order_id      INT,                      -- Mã đơn hàng
    product_id    INT,                      -- Mã sản phẩm
    quantity      INT,                      -- Số lượng
    unit_price    DECIMAL(12,2),             -- Giá bán tại thời điểm đặt
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* =========================================================
   6. DỮ LIỆU MẪU - KHÁCH HÀNG
   ========================================================= */

INSERT INTO customers VALUES
(1, 'Nguyen Van An',  'an@gmail.com',   'Ha Noi'),
(2, 'Tran Thi Binh',  'binh@gmail.com', 'Da Nang'),
(3, 'Le Van Cuong',   'cuong@gmail.com','Ho Chi Minh'),
(4, 'Pham Thi Dao',   'dao@gmail.com',  'Ha Noi'),
(5, 'Hoang Van Em',   'em@gmail.com',   'Can Tho');


/* =========================================================
   7. DỮ LIỆU MẪU - SẢN PHẨM
   ========================================================= */

INSERT INTO products VALUES
(1, 'Laptop Dell',          20000000, 'Electronics'),
(2, 'iPhone 15',            25000000, 'Electronics'),
(3, 'Tai nghe Bluetooth',    1500000, 'Accessories'),
(4, 'Chuột không dây',        500000, 'Accessories'),
(5, 'Bàn phím cơ',           2000000, 'Accessories');


/* =========================================================
   8. DỮ LIỆU MẪU - ĐƠN HÀNG
   ========================================================= */

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 'Completed'),
(102, 2, '2025-01-06', 'Completed'),
(103, 3, '2025-01-07', 'Completed'),
(104, 1, '2025-01-08', 'Completed'),
(105, 4, '2025-01-09', 'Completed'),
(106, 5, '2025-01-10', 'Completed'),
(107, 2, '2025-01-11', 'Completed'),
(108, 3, '2025-01-12', 'Completed');


/* =========================================================
   9. DỮ LIỆU MẪU - CHI TIẾT ĐƠN HÀNG
   ========================================================= */

INSERT INTO order_items VALUES
-- Đơn 101
(1, 101, 1, 1, 20000000),
(2, 101, 3, 2, 1500000),

-- Đơn 102
(3, 102, 2, 1, 25000000),
(4, 102, 4, 1, 500000),

-- Đơn 103
(5, 103, 5, 2, 2000000),
(6, 103, 3, 1, 1500000),

-- Đơn 104
(7, 104, 1, 1, 20000000),
(8, 104, 5, 1, 2000000),

-- Đơn 105
(9, 105, 4, 3, 500000),

-- Đơn 106
(10, 106, 3, 5, 1500000),

-- Đơn 107
(11, 107, 2, 1, 25000000),
(12, 107, 3, 2, 1500000),

-- Đơn 108
(13, 108, 1, 1, 20000000),
(14, 108, 4, 2, 500000);


/* =========================================================
   10. KIỂM TRA NHANH DỮ LIỆU (OPTIONAL)
   ========================================================= */

-- Kiểm tra số lượng bản ghi
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products  FROM products;
SELECT COUNT(*) AS total_orders    FROM orders;
SELECT COUNT(*) AS total_items     FROM order_items;

/* =========================================================
   KẾT THÚC FILE SQL
   ========================================================= */
   
   -- BÀI TẬP JOIN
   -- Lấy ds đơn hàng có id = 102 gồm mã kh, tên kh, số lượng, đơn giá và tổng giá
   SELECT c.customer_id, c.customer_name, oi.quantity, oi.unit_price, (oi.unit_price * quantity) as total_price
   FROM customers c
   join orders o on c.customer_id = o.customer_id
   join order_items oi on o.order_id = oi.order_id
   join products p on p.product_id = oi.product_id
   where o.order_id = 102;
   
   -- Lấy ds khác hàng đã mua sp vs id = 2 gồm những thông tin là mã kh và tên kh
	SELECT c.customer_id, c.customer_name
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE oi.product_id = 2;

-- Lấy ds sản phẩm từ ngày '2025-01-05' đến '2025-01-08' gồm những thông tin là mã sản phẩm, tên sản phẩm, giá và số lượng
select p.product_id, p.product_name, p.price, oi.quantity
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where o.order_date between '2025-01-05' and '2025-01-08';

-- BTTH
-- 1. Liệt kê danh sách các đơn hàng kèm theo tên khách hàng đã đặt đơn.
select o.* , c.customer_name 
from orders o
join customers c on o.customer_id = c.customer_id;

-- 2. Cho biết mỗi đơn hàng gồm những sản phẩm nào, kèm theo số lượng của từng sản phẩm.
select oi.order_id, p.product_name, oi.quantity
from order_items oi
join products p on oi.product_id = p.product_id;

-- 3. Tính tổng số đơn hàng hiện có trong hệ thống.
select count(order_id) as `total_orders`
from orders;

-- 4. Tính tổng doanh thu của toàn bộ hệ thống.
select sum(quantity*unit_price) `total_revenue`
from order_items;

-- 5. Cho biết tổng tiền của mỗi đơn hàng.
select order_id, sum(quantity * unit_price) `order_total`
from order_items
group by order_id;

-- 6. Cho biết tổng số tiền mà mỗi khách hàng đã chi tiêu.
select c.*, sum(oi.quantity * oi.unit_price) `total_spent`
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_id;

-- 7. Tính doanh thu theo từng sản phẩm.
select p.*, sum(oi.quantity * oi.unit_price) `product_revenue`
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- 8. Liệt kê các khách hàng có tổng chi tiêu lớn hơn 5.000.000.
select c.*, sum(oi.quantity * oi.unit_price) `total_spent`
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_id, c.customer_name
having total_spent > 5000000;

-- 9. Liệt kê các sản phẩm có tổng số lượng bán ra lớn hơn 100.
select p.*, sum(oi.quantity) `total_sound`
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having total_sound > 100;

-- 10. Cho biết các thành phố có số lượng đơn hàng lớn hơn 5.
select c.city, count(o.order_id) `total_orders`
from customers c
JOIN orders o ON c.customer_id = o.customer_id
group by c.city
having total_orders > 5;