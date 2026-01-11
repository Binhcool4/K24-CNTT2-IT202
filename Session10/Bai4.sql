USE social_network_pro;

EXPLAIN ANALYZE 
SELECT post_id, content, created_at 
FROM posts 
WHERE user_id = 1 
  AND created_at BETWEEN '2026-01-01 00:00:00' AND '2026-12-31 23:59:59';

CREATE INDEX idx_created_at_user_id ON posts(created_at, user_id);

EXPLAIN ANALYZE 
SELECT post_id, content, created_at 
FROM posts 
WHERE user_id = 1 
  AND created_at BETWEEN '2026-01-01 00:00:00' AND '2026-12-31 23:59:59';

/* So sánh kết quả thực thi:
   - Trước: MySQL thực hiện "Full Table Scan". Nó phải đọc toàn bộ các bài viết trong bảng để lọc.
   - Sau: MySQL thực hiện "Index Range Scan" trên idx_created_at_user_id. 
   - Hiệu quả: Tốc độ xử lý nhanh hơn, chỉ số "Rows examined" (số dòng phải duyệt) giảm đáng kể.
*/

EXPLAIN ANALYZE 
SELECT user_id, username, email 
FROM users 
WHERE email = 'an@gmail.com';

CREATE UNIQUE INDEX idx_email ON users(email);

EXPLAIN ANALYZE 
SELECT user_id, username, email 
FROM users 
WHERE email = 'an@gmail.com';

/* So sánh kết quả thực thi:
   - Trước: Thực hiện Table Scan. SQL phải duyệt hết bảng vì không biết email có bị trùng ở dòng sau không.
   - Sau: Thực hiện "Unique Index Lookup". SQL dừng ngay lập tức khi tìm thấy email khớp vì tính duy nhất.
   - Hiệu quả: Đây là phương thức truy cập nhanh nhất (hầu như tốn 0ms).
*/

DROP INDEX idx_created_at_user_id ON posts;

DROP INDEX idx_email ON users;