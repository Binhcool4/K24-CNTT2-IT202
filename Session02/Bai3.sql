create table student (
		student_id int primary key,
        full_name varchar(20)
);

create table subject (
		subject_id int primary key,
        subject_name varchar(20),
        number_of_creadit int check(number_of_creadit > 0)
); 

create table enrollment(
		student_id int,
		subject_id int,
    
		primary key (student_id, subject_id),
    
		constraint fk_enrollment_student foreign key (student_id) references student(student_id),
		constraint fk_enrollment_subject foreign key (subject_id) references subject(subject_id)
);