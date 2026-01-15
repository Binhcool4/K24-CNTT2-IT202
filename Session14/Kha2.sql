use social_network;

alter table posts add column likes_count int default 0;

create table if not exists likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    foreign key (post_id) references posts(post_id) on delete cascade,
    foreign key (user_id) references users(user_id) on delete cascade,
    unique key unique_like (post_id, user_id)
);

drop procedure if exists sp_like_post;

delimiter //

create procedure sp_like_post(
    in p_user_id int,
    in p_post_id int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi: hành động like thất bại (có thể bạn đã like bài này rồi). đã rollback.' as thông_báo;
    end;

    start transaction;

    insert into likes (user_id, post_id) values (p_user_id, p_post_id);

    update posts 
    set likes_count = likes_count + 1 
    where post_id = p_post_id;

    commit;
    select 'like bài viết thành công! đã commit.' as thông_báo;

end //

delimiter ;

call sp_like_post(1, 1);

select * from likes;
select post_id, content, likes_count from posts where post_id = 1;

call sp_like_post(1, 1);

select post_id, content, likes_count from posts where post_id = 1;