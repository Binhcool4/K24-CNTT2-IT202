USE social_network_pro;

EXPLAIN ANALYZE 
SELECT * FROM users 
WHERE hometown = 'Hà Nội';
-- Filter: (users.hometown = 'Hà Nội')  (cost=2.85 rows=2.6) (actual time=0.0342..0.0575 rows=8 loops=1)
-- Table scan on users  (cost=2.85 rows=26) (actual time=0.0307..0.0508 rows=26 loops=1)
 
 
CREATE INDEX idx_hometown ON users(hometown);

EXPLAIN ANALYZE 
SELECT * FROM users 
WHERE hometown = 'Hà Nội';
-- Index lookup on users using idx_hometown (hometown='Hà Nội')  (cost=1.45 rows=8) (actual time=0.0266..0.0378 rows=8 loops=1)
  
 /* So sánh kết quả :
   - Trước khi đánh Index: SQL thực hiện "Full Table Scan". Thời gian và tài nguyên tốn kém.
   - Sau khi đánh Index: SQL thực hiện "Index Lookup".
   - Hiệu quả: Số dòng cần kiểm tra (Rows examined) giảm xuống chỉ còn đúng bằng số User ở Hà Nội.
   - Tốc độ: "Actual time" sẽ giảm đáng kể trên các bộ dữ liệu lớn.
*/

DROP INDEX idx_hometown ON users;