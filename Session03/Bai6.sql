insert into student
value(4, "D", "2006-12-12", "D@gmail.com");

insert into enrollment
values(4,1,"2022-02-02"),
(4,2, "2022-02-02");

insert into score
value(4,1,8,8);

update score 
set final_score = 10
where student_id = 4;

delete from enrollment where student_id = 1;

select * from student where student_id = 4;
select * from score where student_id = 4;