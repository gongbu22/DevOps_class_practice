-- 데이터베이스 개론 p.273 28번

-- 환자 테이블 생성
create table Patients (
    pnum    varchar(10) constraint p_nn not null,
    pname   varchar(15) constraint name_nn not null,
    page    int,
    dnum    varchar(10),
    primary key(pnum),
    foreign key (dnum) references doctors(dnum)
);

-- 의사 데이블 생성
create table doctors (
    dnum        varchar(10) constraint d_nn not null,
    dname       varchar(15) constraint dname_nn not null,
    department  varchar(21) default '내과',
    workday     int check( workday between 1 and 40 ),
    primary key (dnum)
);

insert all
    into CLOUDS2.PATIENTS values ('P001', '오우진', 31, 'D002')
    into CLOUDS2.PATIENTS values ('P002', '채광주', 50, 'D001')
    into CLOUDS2.PATIENTS values ('P003', '김용옥', 43, 'D003')
select 1 from dual;

insert all
    into doctors values ('D001', '정지영', '내과', 5)
    into doctors values ('D002', '김선주', '피부과', 10)
    into doctors values ('D003', '정성호', '정형외과', 15)
select 1 from dual;

select pnum 환자번호, pname 환자이름 from PATIENTS where page >=40 and dnum = 'D003';

select count(dnum) "의사 수", avg(workday) 근무연수 from doctors group by department;

select dname 의사이름, department 소속, workday 근무연수 from doctors where dnum = (select dnum from PATIENTS where pname = '김용옥');
select d.dname 의사이름, d.department 소속, d.workday 근무연수 from doctors d, PATIENTS p where p.pname='김용옥' and p.dnum = d.dnum;