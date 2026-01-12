drop database session11_btth;
create database session11_btth;
use session11_btth;
create table posts (
	post_id int primary key auto_increment,
	content text,
	author varchar(255),
	likes_count int default (0)
);
-- Task 1 (CREATE): Viết thủ tục sp_CreatePost để thêm bài viết mới

delimiter //
create procedure sp_CreatePost (in in_content varchar(255), in in_author_name varchar(255),out last_post_id int)
begin 
	insert into posts (content,author)
    values (in_content,in_author_name);
     SET last_post_id = LAST_INSERT_ID();
end //

call sp_CreatePost('hay quá','hưng',@id);

-- lấy ra ID vừa tạo
select @id;


-- Task 2 (READ & SEARCH): Viết thủ tục sp_SearchPost để tìm kiếm
delimiter //
create procedure sp_SearchPost (in search_post_by_id int )
begin 
	select * from posts where user_id = search_post_by_id;
end //

call sp_SearchPost(1);

-- Task 3 (UPDATE): Viết thủ tục sp_IncreaseLike để tăng tương tác.
delimiter //
create procedure sp_IncreaseLike (in in_post_id int, inout new_like int)
begin 
	update posts
    set likes_count =  likes_count + 1
    where post_id = in_post_id;
    
end //
set @current_like = (select likes_count from posts where post_id = 1);
call sp_IncreaseLike(3,@current_like);

select * from posts;


-- Task 4 (DELETE): Viết thủ tục sp_DeletePost.
delimiter //
create procedure sp_DeletePost(in in_post_id int)
begin 
	delete from posts  where post_id = in_post_id;
end //

call sp_DeletePost(1);


-- 3. Kiểm tra và Dọn dẹp
-- Tạo 2 bài viết mới và dùng biến để xem ID trả về.
delimiter //
create procedure sp_CreatePost (in in_content varchar(255), in in_author_name varchar(255),out last_post_id int)
begin 
	insert into posts (content,author)
    values (in_content,in_author_name);
	SET last_post_id = LAST_INSERT_ID();
end //

call sp_CreatePost('hay quá','son',@id1);
call sp_CreatePost('loi bi ngao','Quang',@id2);
call sp_CreatePost('loi hello','Hoàn',@id3);

select @id1;
select @id2;

delimiter //
create procedure searchhello (in in_content varchar(255))
begin 
	insert into posts (content,author)
    values (in_content,in_author_name);
	SET last_post_id = LAST_INSERT_ID();
end //



-- Tìm kiếm các bài viết có chữ "hello".
delimiter //
create procedure searchhello (in in_content varchar(255))
begin 
	 select *  from posts
     where content like concat('%', in_content, '%');
end //

call searchhello('hello');

-- Tăng Like cho bài viết vừa tạo (sử dụng biến @ để truyền và nhận giá trị từ INOUT).

delimiter //
create procedure sp_IncreaseLike (in in_post_id int, inout new_like int)
begin 
	update posts
    set likes_count =  likes_count + 1
    where post_id = in_post_id;
    
end //
set @current_like = (select likes_count from posts where post_id = 1);
call sp_IncreaseLike(3,@current_like);

select * from posts;
-- Xóa một bài viết bất kỳ.
delimiter //
create procedure sp_DeletePost(in in_post_id int)
begin 
	delete from posts  where post_id = in_post_id;
end //

call sp_DeletePost(1);

-- Xóa bỏ (Drop) tất cả các thủ tục đã tạo sau khi hoàn thành.

drop procedure sp_DeletePost;

drop procedure sp_IncreaseLike;

drop procedure searchhello;

drop procedure sp_CreatePost;