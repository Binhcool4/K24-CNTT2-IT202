use social_network;

alter table posts add column comments_count int default 0;

ưcreate table if not exists comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id) on delete cascade,
    foreign key (user_id) references users(user_id) on delete cascade
);

delimiter //

create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi nghiêm trọng: đã rollback toàn bộ giao dịch' as thông_báo;
    end;

    start transaction;

    insert into comments (post_id, user_id, content) 
    values (p_post_id, p_user_id, p_content);

    savepoint after_insert;

    update posts 
    set comments_count = comments_count + 1 
    where post_id = p_post_id;

    commit;
    select 'đăng bình luận thành công và đã cập nhật số lượng' as thông_báo;

end //

delimiter ;

call sp_post_comment(1, 1, 'bài viết rất hay!');

select * from comments;
select post_id, comments_count from posts where post_id = 1;
