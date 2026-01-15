use social_network;

alter table users 
add column  following_count int default 0,
add column  followers_count int default 0;

create table if not exists followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id) on delete cascade,
    foreign key (followed_id) references users(user_id) on delete cascade
);

create table if not exists follow_log (
    log_id int primary key auto_increment,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    created_at datetime default current_timestamp
);


delimiter //

create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_user_exists int default 0;
    declare v_already_followed int default 0;

    declare exit handler for sqlexception
    begin
        rollback;
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'lỗi sql hệ thống');
        select 'lỗi hệ thống: giao dịch bị hủy bỏ' as thông_báo;
    end;

    start transaction;

    select count(*) into v_user_exists from users 
    where user_id in (p_follower_id, p_followed_id);

    if v_user_exists < 2 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'một trong hai user không tồn tại');
        rollback;
        select 'lỗi: một hoặc cả hai người dùng không tồn tại' as thông_báo;

    elseif p_follower_id = p_followed_id then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'tự follow chính mình');
        rollback;
        select 'lỗi: bạn không thể tự theo dõi chính mình' as thông_báo;

    else
        select count(*) into v_already_followed from followers 
        where follower_id = p_follower_id and followed_id = p_followed_id;

        if v_already_followed > 0 then
            insert into follow_log (follower_id, followed_id, error_message)
            values (p_follower_id, p_followed_id, 'đã follow trước đó');
            rollback;
            select 'lỗi: bạn đã theo dõi người này rồi' as thông_báo;
        else
            insert into followers (follower_id, followed_id) values (p_follower_id, p_followed_id);

            update users set following_count = following_count + 1 where user_id = p_follower_id;

            update users set followers_count = followers_count + 1 where user_id = p_followed_id;

            commit;
            select 'theo dõi thành công!' as thông_báo;
        end if;
    end if;

end //

delimiter ;

call sp_follow_user(1, 2);

select * from followers;
select user_id, username, following_count, followers_count from users where user_id in (1, 2);

call sp_follow_user(1, 1);
select * from follow_log;

call sp_follow_user(1, 9999);
select * from follow_log;

call sp_follow_user(1, 2);