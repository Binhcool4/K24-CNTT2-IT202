use session13;

DELIMITER //

CREATE PROCEDURE add_user(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_created_at DATE
)
BEGIN
    INSERT INTO users (username, email, created_at)
    VALUES (p_username, p_email, p_created_at);
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_user_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Định dạng Email không hợp lệ!';
    END IF;

    IF NEW.username NOT REGEXP '^[a-zA-Z0-9_]+$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Username chỉ được chứa chữ cái, số và dấu gạch dưới!';
    END IF;
END //

DELIMITER ;

CALL add_user('john_doe123', 'john@example.com', '2025-01-14');

CALL add_user('test_user', 'test@gmail', '2025-01-14');

CALL add_user('user name!', 'valid@email.com', '2025-01-14');

SELECT * FROM users;