USE social_network_pro;

CREATE OR REPLACE VIEW view_user_activity_status AS
SELECT 
    u.user_id, 
    u.username, 
    u.gender, 
    u.created_at,
    CASE 
        WHEN u.user_id IN (SELECT user_id FROM posts) 
         OR u.user_id IN (SELECT user_id FROM comments)
        THEN 'Active'
        ELSE 'Inactive'
    END AS status
FROM users u;

SELECT * FROM view_user_activity_status;

SELECT 
    status, 
    COUNT(user_id) AS user_count
FROM view_user_activity_status
GROUP BY status
ORDER BY user_count DESC;