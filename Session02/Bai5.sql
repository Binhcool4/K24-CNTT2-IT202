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