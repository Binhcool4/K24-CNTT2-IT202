use social_network;

alter table users add column friends_count int default 0;

create table if not exists friend_requests (
    request_id int primary key auto_increment,
    from_user_id int,
    to_user_id int,
    status enum('pending', 'accepted', 'rejected') default 'pending',
    foreign key (from_user_id) references users(user_id),
    foreign key (to_user_id) references users(user_id)
);

create table if not exists friends (
    user_id int,
    friend_id int,
    primary key (user_id, friend_id),
    foreign key (user_id) references users(user_id),
    foreign key (friend_id) references users(user_id)
);

insert into users (username) values ('nguyen_van_a'), ('le_thi_b');
insert into friend_requests (from_user_id, to_user_id) values (1, 2);

delimiter //

create procedure sp_accept_friend_request(
    in p_request_id int,
    in p_to_user_id int
)
begin
    declare v_from_user_id int;
    declare v_status varchar(20);

    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi: không thể chấp nhận kết bạn. dữ liệu đã được hoàn tác.' as thông_báo;
    end;

    set transaction isolation level repeatable read;

    start transaction;

    
    select from_user_id, status into v_from_user_id, v_status 
    from friend_requests 
    where request_id = p_request_id and to_user_id = p_to_user_id 
    for update;

    if v_from_user_id is null or v_status != 'pending' then
        rollback;
        select 'lỗi: yêu cầu không tồn tại hoặc đã được xử lý trước đó' as thông_báo;
    else
        insert into friends (user_id, friend_id) values (v_from_user_id, p_to_user_id);
        insert into friends (user_id, friend_id) values (p_to_user_id, v_from_user_id);

        update users set friends_count = friends_count + 1 where user_id = v_from_user_id;
        update users set friends_count = friends_count + 1 where user_id = p_to_user_id;

        update friend_requests set status = 'accepted' where request_id = p_request_id;

        commit;
        select 'chấp nhận kết bạn thành công!' as thông_báo;
    end if;

end //

delimiter ;

call sp_accept_friend_request(1, 2);

select * from friends;
select user_id, username, friends_count from users where user_id in (1, 2);
select * from friend_requests;
