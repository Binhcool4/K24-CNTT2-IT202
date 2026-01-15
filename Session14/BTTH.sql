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

    FOREIGN KEY (user_id) REFERENCES users(user_id)

);

INSERT INTO users (username, total_posts) VALUES ('nguyen_van_a', 0);

INSERT INTO users (username, total_posts) VALUES ('le_thi_b', 0);

delimiter //

create procedure sp_create_post(
    in p_user_id int,
    in p_content text
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi: quá trình đăng bài thất bại. dữ liệu đã được hoàn tác.' as message;
    end;

    if p_content is null or trim(p_content) = '' then
        signal sqlstate '45000' set message_text = 'lỗi: nội dung bài viết không được để trống!';
    end if;

    start transaction;

    insert into posts (user_id, content) 
    values (p_user_id, p_content);

    update users 
    set total_posts = total_posts + 1 
    where user_id = p_user_id;

    commit;
    select 'đăng bài thành công!' as message;

end //

delimiter ;

call sp_create_post(1, 'chào mọi người, đây là bài viết đầu tiên của tôi!');

select * from posts;
select * from users where user_id = 1; 

call sp_create_post(9999, 'bài viết này sẽ gây lỗi khóa ngoại');

select * from posts where user_id = 9999;
select * from users;