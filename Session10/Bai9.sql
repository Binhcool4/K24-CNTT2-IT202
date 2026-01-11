USE social_network_pro;

CREATE INDEX idx_user_gender ON users(gender);

CREATE VIEW view_user_activity AS
SELECT 
    u.user_id,
    (SELECT COUNT(*) FROM posts p WHERE p.user_id = u.user_id) AS total_posts,
    (SELECT COUNT(*) FROM comments c WHERE c.user_id = u.user_id) AS total_comments
FROM users u;

SELECT * FROM view_user_activity;

SELECT 
    u.user_id, 
    u.username, 
    u.full_name, 
    v.total_posts, 
    v.total_comments
FROM users u
JOIN view_user_activity v ON u.user_id = v.user_id
WHERE v.total_posts > 5 
  AND v.total_comments > 20
ORDER BY v.total_comments DESC
LIMIT 5;