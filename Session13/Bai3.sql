use session13;

DELIMITER //

CREATE TRIGGER before_like_insert
BEFORE INSERT ON likes
FOR EACH ROW
BEGIN
    DECLARE post_owner_id INT;

    SELECT user_id INTO post_owner_id 
    FROM posts 
    WHERE post_id = NEW.post_id;

    IF NEW.user_id = post_owner_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bạn không thể thích bài viết của chính mình!';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_like_update
AFTER UPDATE ON likes
FOR EACH ROW
BEGIN
    UPDATE posts SET like_count = like_count - 1 WHERE post_id = OLD.post_id;
    UPDATE posts SET like_count = like_count + 1 WHERE post_id = NEW.post_id;
END //

DELIMITER ;

INSERT INTO likes (user_id, post_id, liked_at) VALUES (1, 1, NOW());

INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());

SELECT post_id, content, like_count FROM posts WHERE post_id = 4;

SELECT post_id, like_count FROM posts WHERE post_id IN (1, 3);

UPDATE likes SET post_id = 3 WHERE like_id = 1;

SELECT post_id, like_count FROM posts WHERE post_id IN (1, 3);

DELETE FROM likes WHERE like_id = 1;

SELECT * FROM posts;

SELECT post_id, content, like_count FROM posts;

SELECT * FROM user_statistics;