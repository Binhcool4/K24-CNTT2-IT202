create table score(
	student_id int,
    subject_id int,
    mid_score decimal(4,2),
    final_score decimal(4,2),

primary key (student_id, subject_id),
    
constraint fk_score_student foreign key (student_id) references student(student_id),
constraint fk_score_subject foreign key (subject_id) references subject(subject_id),

constraint check_mid_score check(mid_score >= 0 and mid_score <= 10),
constraint check_final_score check(final_score >= 0 and final_score <= 10)
);

insert into score
values(1,1, 7, 8),
(2,1,8,7);

update score
set final_score = 9
where student_id = 1;

select * from score;
select * from score where final_score > 8;