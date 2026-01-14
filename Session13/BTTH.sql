CREATE DATABASE SocialNetworkDB;
USE SocialNetworkDB;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    total_posts INT DEFAULT 0
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE post_audits (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    old_content TEXT,
    new_content TEXT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Task 1 (BEFORE INSERT)
delimiter //
create trigger tg_CheckPostContent
before insert on posts
for each row
begin
	if trim(new.content) = '' then
    signal sqlstate '45000' set message_text = 'Nội dung bài viết không được để trống!';
            end if;
end //

-- Task 2 (AFTER INSERT)
delimiter //
create trigger tg_UpdatePostCountAfterInsert
after insert on posts
for each row
begin
	Update users
    set total_posts = total_posts + 1
    where user_id = new.user_id;
end //

-- Task 3 (AFTER UPDATE)
delimiter //
create trigger tg_LogPostChanges
after update on posts
for each row
begin
	insert into post_audits (post_id, old_content, new_content, changed_at)
        VALUES (OLD.post_id, OLD.content, NEW.content, NOW());
end //

-- Task 4 (AFTER DELETE)
delimiter //
create trigger tg_UpdatePostCountAfterDelete
after delete on posts
for each row
begin
	Update users
    set total_posts = total_posts - 1
    where user_id = old.user_id;
end //

-- Tạo người dùng mới
INSERT INTO users (username) VALUES ('duc_loi');

-- Chèn bài viết hợp lệ 
INSERT INTO posts (user_id, content) VALUES (1, 'Bài viết đầu tiên của tôi');
SELECT * FROM users WHERE user_id = 1;

-- Chèn bài viết trống 
INSERT INTO posts (user_id, content) VALUES (1, '   ');

-- Chỉnh sửa nội dung 
UPDATE posts SET content = 'Nội dung đã được cập nhật' WHERE post_id = 1;
SELECT * FROM post_audits;

-- Xóa bài viết 
DELETE FROM posts WHERE post_id = 1;
SELECT * FROM users WHERE user_id = 1;

DROP TRIGGER IF EXISTS tg_CheckPostContent;
DROP TRIGGER IF EXISTS tg_UpdatePostCountAfterInsert;
DROP TRIGGER IF EXISTS tg_LogPostChanges;
DROP TRIGGER IF EXISTS tg_UpdatePostCountAfterDelete;