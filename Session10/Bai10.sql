USE social_network_pro;

CREATE INDEX idx_username ON users(username);

CREATE VIEW view_user_activity_2 AS
SELECT 
    u.user_id,
    u.username,
    (SELECT COUNT(*) FROM posts p WHERE p.user_id = u.user_id) AS total_posts,
    (SELECT COUNT(*) FROM friends f 
     WHERE (f.user_id = u.user_id OR f.friend_id = u.user_id) 
     AND f.status = 'accepted') AS total_friends
FROM users u;

SELECT * FROM view_user_activity_2;

SELECT 
    u.full_name, 
    v.total_posts, 
    v.total_friends,
    CASE 
        WHEN v.total_friends > 5 THEN 'Nhiều bạn bè'
        WHEN v.total_friends BETWEEN 2 AND 5 THEN 'Vừa đủ bạn bè'
        ELSE 'Ít bạn bè'
    END AS friend_description,
    CASE 
        WHEN v.total_posts > 10 THEN v.total_posts * 1.1
        WHEN v.total_posts BETWEEN 5 AND 10 THEN v.total_posts
        ELSE v.total_posts * 0.9
    END AS post_activity_score
FROM users u
JOIN view_user_activity_2 v ON u.user_id = v.user_id
WHERE v.total_posts > 0
ORDER BY v.total_posts DESC;