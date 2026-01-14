use session13;

CREATE TABLE post_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    old_content TEXT,
    new_content TEXT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    changed_by_user_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

DELIMITER //

CREATE TRIGGER before_post_update
BEFORE UPDATE ON posts
FOR EACH ROW
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_history (
            post_id, 
            old_content, 
            new_content, 
            changed_at, 
            changed_by_user_id
        ) VALUES (
            OLD.post_id, 
            OLD.content, 
            NEW.content, 
            NOW(), 
            OLD.user_id 
        );
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_after_post_delete_log
AFTER DELETE ON posts
FOR EACH ROW
BEGIN
    INSERT INTO deleted_posts_log (post_id, old_content, deleted_by_user_id)
    VALUES (OLD.post_id, OLD.content, OLD.user_id);
    
END //

DELIMITER ;

SELECT post_id, content FROM posts WHERE post_id = 1;

UPDATE posts 
SET content = 'Alice has updated her first post!' 
WHERE post_id = 1;

SELECT * FROM post_history;

SELECT post_id, content, like_count FROM posts WHERE post_id = 1;

UPDATE posts SET content = 'Alice updated content again' WHERE post_id = 1;


SELECT post_id, content, like_count FROM posts WHERE post_id = 1;
SELECT * FROM post_history;