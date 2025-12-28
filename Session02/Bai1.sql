create table class (
		class_id int primary key,
        name varchar(20),
        year year
);

create table student (
		student_id int primary key,
		full_name varchar(20),
		birthDay datetime,
		class_id int
); 

alter table student
	add constraint fk_class foreign key (class_id) references Class(class_id)
;