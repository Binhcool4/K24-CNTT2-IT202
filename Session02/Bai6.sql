create table class(
		class_id int primary key,
		name varchar(20) not null,
		year year not null
);

create table teacher(
		teacher_id int primary key,
		name varchar(20) not null,
		email varchar(20) unique not null
);

create table student(
		student_id int primary key,
		name varchar(20) not null,
		birth_day date,
		class_id int,
		constraint fk_student_class foreign key (class_id) references class(class_id)
);

create table subject(
		subject_id int primary key,
		subject_name varchar(20) not null,
		number_of_credits int check(number_of_credits > 0),
		teacher_id int,
		constraint fk_subject_teacher foreign key (teacher_id) references teacher(teacher_id)
);

create table enrollment(
		student_id int,
		subject_id int,
    
		primary key (student_id, subject_id),
    
		constraint fk_enrollment_student foreign key (student_id) references student(student_id),
		constraint fk_enrollment_subject foreign key (subject_id) references subject(subject_id)
);

create table score(
		student_id int,
		subject_id int,
		process_score decimal(4,2),
		final_score decimal(4,2),

primary key (student_id, subject_id),

constraint fk_score_student foreign key (student_id) references student(student_id),
constraint fk_score_subject foreign key (subject_id) references subject(subject_id),

constraint check_process_score check(process_score >= 0 and process_score <= 10),
constraint check_final_score check(final_score >= 0 and final_score <= 10)
); 