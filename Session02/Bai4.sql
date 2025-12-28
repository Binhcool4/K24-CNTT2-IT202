create table teacher(
		teacher_id int primary key,
		full_name varchar(50),
		email varchar(50) unique
);

alter table subject
		add column teacher_id int;
    
alter table subject
		add constraint fk_subject_teacher
		foreign key (teacher_id) references teacher(teacher_id);