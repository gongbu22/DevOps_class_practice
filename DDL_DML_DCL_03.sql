-- 데이터베이스 개론 p.273

-- 학생테이블 생성
create table students_3 (
    hakbun  varchar(10) constraint st3_nn not null,
    stname  varchar(15) constraint stname_nn not null,
    stgrade varchar(10),
    primary key (hakbun)
);

insert all
    into students_3 values ('20220031', '김학생', '3학년')
    into students_3 values ('20220141', '이학생', '2학년')
    into students_3 values ('20220551', '박학생', '4학년')
select 1 from dual;

-- 과목 테이블 생성
create table subject_3 (
    subnum  varchar(10),
    subname varchar(51),
    primary key (subnum)
);

insert all
    into subject_3 values ('A002', '사회복지개론')
    into subject_3 values ('A003', '청소년복지론')
    into subject_3 values ('A004', '사회복지법제론')
select 1 from dual;

delete from subject_3;

-- 수강 테이블 생성
create table class_3 (
    hakbun      varchar(10),
    subnum      varchar(10),
    middlescore int,
    finalscore  int,
    grade       decimal(5,2),
    primary key(hakbun, subnum),
    foreign key (hakbun) references students_3(hakbun),
    foreign key (subnum) references  subject_3(subnum)
);

insert all
    into class_3 values ('20220031', 'A002', 52, 89, 3.2)
    into class_3 values ('20220031', 'A003', 82, 69, 2.2)
    into class_3 values ('20220031', 'A004', 42, 79, 3.8)
    into class_3 values ('20220141', 'A002', 55, 82, 1.2)
    into class_3 values ('20220141', 'A003', 72, 66, 2.7)
    into class_3 values ('20220551', 'A002', 92, 79, 3.2)
    into class_3 values ('20220551', 'A003', 59, 39, 3.6)
    into class_3 values ('20220551', 'A004', 62, 99, 4.2)
SELECT 1 FROM DUAL;


SELECT s.stname "학생 이름", c.middlescore "중간 성적" FROM CLASS_3 c, students_3 s WHERE c.hakbun = s.hakbun and  c.finalscore >=80 AND c.subnum LIKE 'A%' order by s.stname , c.middlescore desc;

select count(c.hakbun) "학생 수", round(avg(c.finalscore),2) "성적 평균" from class_3 c group by c.subnum having count(c.hakbun) >=3

select COUNT(distinct subnum) from CLASS_3;

select s.stname "학생 이름", s.stgrade 학년 from students_3 s, class_3 c where s.hakbun=c.hakbun and c.subnum != 'A003';
select s.stname "학생 이름", s.stgrade 학년 from students_3 s, class_3 c where s.hakbun=c.hakbun and c.subnum not in ('A003');

select s.stname "학생 이름", s.stgrade 학년 from students_3 s where EXISTS (select 1 from class_3 c where s.hakbun = c.hakbun and c.subnum != 'A003');





