create table enrollment(
	student_id int,
    subject_id int,
    enroll_date date,

primary key (student_id, subject_id),
    
constraint fk_enrollment_student foreign key (student_id) references student(student_id),
constraint fk_enrollment_subject foreign key (subject_id) references subject(subject_id)
);

insert into enrollment
values(2,1,"2000-02-02"),
(3,1,"2000-02-02");

select * from enrollment;
select * from enrollment where student_id = 1;