use session13;

CREATE TABLE friendships (
    follower_id INT,
    followee_id INT,
    status ENUM('pending', 'accepted') DEFAULT 'accepted',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES users(user_id) ON DELETE CASCADE
);

DELIMITER //

CREATE TRIGGER after_friendship_insert
AFTER INSERT ON friendships
FOR EACH ROW
BEGIN
    IF NEW.status = 'accepted' THEN
        UPDATE users SET follower_count = follower_count + 1 
        WHERE user_id = NEW.followee_id;
    END IF;
END //

CREATE TRIGGER after_friendship_delete
AFTER DELETE ON friendships
FOR EACH ROW
BEGIN
    IF OLD.status = 'accepted' THEN
        UPDATE users SET follower_count = follower_count - 1 
        WHERE user_id = OLD.followee_id;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE follow_user(
    IN p_follower_id INT,
    IN p_followee_id INT,
    IN p_status ENUM('pending', 'accepted')
)
BEGIN
    IF p_follower_id = p_followee_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bạn không thể tự theo dõi chính mình!';
    END IF;

    IF EXISTS (SELECT 1 FROM friendships WHERE follower_id = p_follower_id AND followee_id = p_followee_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bạn đã theo dõi người dùng này rồi!';
    ELSE
        INSERT INTO friendships (follower_id, followee_id, status)
        VALUES (p_follower_id, p_followee_id, p_status);
    END IF;
END //

DELIMITER ;

CREATE VIEW user_profile AS
SELECT 
    u.user_id, 
    u.username, 
    u.follower_count, 
    u.post_count,
    (SELECT COALESCE(SUM(p.like_count), 0) FROM posts p WHERE p.user_id = u.user_id) AS total_likes,
    (SELECT GROUP_CONCAT(content SEPARATOR ' | ') 
     FROM (SELECT content, user_id FROM posts ORDER BY created_at DESC LIMIT 3) AS recent 
     WHERE recent.user_id = u.user_id) AS recent_posts
FROM users u;

CALL follow_user(2, 1, 'accepted');

CALL follow_user(3, 1, 'accepted');

SELECT username, follower_count FROM users WHERE user_id = 1;

CALL follow_user(1, 1, 'accepted');

CALL follow_user(2, 1, 'accepted');

DELETE FROM friendships WHERE follower_id = 2 AND followee_id = 1;

SELECT * FROM user_profile WHERE user_id = 1;