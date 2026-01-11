USE social_network_pro;

EXPLAIN ANALYZE
SELECT 
    u.user_id, 
    u.username, 
    u.full_name, 
    u.hometown, 
    p.post_id, 
    p.content
FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 10;

CREATE INDEX idx_hometown ON users(hometown);

SELECT 
    u.user_id, 
    u.username, 
    u.full_name, 
    u.hometown, 
    p.post_id, 
    p.content
FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 10;

EXPLAIN ANALYZE
SELECT 
    u.user_id, 
    u.username, 
    u.full_name, 
    u.hometown, 
    p.post_id, 
    p.content
FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 10;

/* SO SÁNH KẾT QUẢ:
   - Trước khi có Index: MySQL quét toàn bộ bảng users (Table scan).
   - Sau khi có Index: MySQL sử dụng "Index lookup on u using idx_hometown".
   - Hiệu quả: Số lượng dòng phải kiểm tra (rows examined) giảm xuống, 
     tốc độ truy vấn được tối ưu hóa rõ rệt.
*/