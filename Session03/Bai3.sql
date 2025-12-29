create table subject(
	subject_id int primary key,
    subject_name varchar(25),
    credit int check(credit > 0)
);

insert into subject
value(3, "CSDL", 3),
(2, "PMHDV", 4);

update subject
set credit = 5
where subject_id = 1;

update subject
set subject_name = "CSDL&GT"
where subject_id = 1;