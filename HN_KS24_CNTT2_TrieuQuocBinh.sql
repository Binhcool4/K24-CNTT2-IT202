-- tạo cơ sở dữ liệu
create database cntt;
use cntt;

-- PHẦN I:Nhóm lệnh DDL (Tạo bảng & Ràng buộc) 
-- bảng student
create table student(
		student_id varchar(10) primary key,
        full_name varchar(20) not null,
        email varchar(100) not null unique,
        phone_number varchar(20) not null
);

create table course(
		course_id varchar(10) primary key,
        course_name varchar(15) not null,
        number_of_creadit int not null check(number_of_creadit > 0)
);

create table enrollment (
    student_id varchar(10),
    course_id varchar(10),
    grade decimal(4,2) default 0,
    primary key (student_id, course_id),
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id)
);

-- Phần II:Nhóm lệnh DML (Thêm & Sửa dữ liệu)
insert into student
values
('1', 'Nguyễn Văn A', 'nva@gmail.com', '0123456789'),
('2', 'Nguyễn Văn B', 'nvb@gmail.com', '0123456789'),
('3', 'Nguyễn Văn C', 'nvc@gmail.com', '0123456789'),
('4', 'Triệu Quốc Bình', 'tqb@gmail.com', '0123456789'),
('5', 'Lê Thị B', 'ltb@gmail.com', '0123456789');

insert into course
values
('1', 'Lap trinh java', '5'),
('2', 'SQL co ban', '3'),
('3', 'Lap trinh c', '4'),
('4', 'HTML CSS', '5'),
('5', 'Python co ban', '2');

insert into enrollment (student_id, course_id, grade)
values
('1', '1', 7.5),
('2', '2', 8.0),
('2', '3', 6.5),
('3', '1', 9.0),
('4', '4', 8.5);

update enrollment
set grade = 9.0
where student_id = '2'
  and course_id = '3';

select full_name, email, phone_number
from student;

-- Phần III:Câu hỏi phân loại (Hiểu về quan hệ)  
delete from course
where course_id = '1';	-- Không xoá được
-- Trong bảng enrollment có khoá ngoại course_id, việc xóa sẽ làm mất tính toàn vẹn dữ liệu 
