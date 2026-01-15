create database if not exists social_network;
use social_network;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

insert into users (username) values ('nguyen_van_a'), ('le_thi_b');

delimiter //

create procedure sp_create_post(
    in p_user_id int,
    in p_content text
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi: giao dịch thất bại. dữ liệu đã được hoàn tác (rollback).' as thông_báo;
    end;

    start transaction;

    insert into posts (user_id, content) 
    values (p_user_id, p_content);

    update users 
    set posts_count = posts_count + 1 
    where user_id = p_user_id;

    commit;
    select 'đăng bài thành công! dữ liệu đã được lưu (commit).' as thông_báo;

end //

delimiter ;


-- thực hiện đăng bài
call sp_create_post(1, 'đây là bài viết đầu tiên của tôi!');

-- kiểm tra kết quả
select * from users where user_id = 1; 
select * from posts; 

call sp_create_post(9999, 'nội dung này sẽ không bao giờ được lưu');

-- kiểm tra lại dữ liệu
select * from posts where user_id = 9999; 
select * from users; 