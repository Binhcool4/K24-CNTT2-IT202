create table Student(
	student_id int primary key,
    full_name varchar(30) not null,
    date_of_birth date,
    email varchar(100) unique
);

insert into Student()
values
(1,"Nguyen Van A","2000-12-20","nva@gmail.com"),
(2,"Nguyen Van B","2001-11-19","nvb@gmail.com"),
(3,"Nguyen Van C","2002-10-18","nvc@gmail.com"),
(4,"Trieu Quoc Binh","2003-09-17","tqb@gmail.com"),
(5,"Le Thi B","2004-08-16","ltb@gmail.com");

select * from Student;

select student_id,full_name from Student;