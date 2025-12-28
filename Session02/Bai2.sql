create table student (
		student_id int primary key,
        full_name varchar(20)
);

create table subject (
		subject_id int primary key,
        subject_name varchar(20),
        number_of_creadit int check(number_of_creadit > 0)
); 