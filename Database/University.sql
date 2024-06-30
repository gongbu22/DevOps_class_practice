-- 데이터베이스 개론 책 p.272 27번 문제
-- students 테이블 생성
create table students_book (
    stnum       varchar(10) constraint st_nn not null,
    stname      varchar(15),
    stscore     decimal(1,1),
    department  varchar(51)
);

-- 기본키 제약조건 추가
alter table students_book add constraint st_pk primary key (stnum);

-- 제약조건 조회
select constraint_name, constraint_type, search_condition from ALL_CONSTRAINTS where table_name='STUDENTS_BOOK';

-- 데이터 삽입
insert all
    into students_book values ('101', '이진아', 3.5, '컴퓨터 공학과')
    into students_book values ('102', '양가섭', 4.1, '컴퓨터 공학과')
    into students_book values ('103', '박수정', 3.7, '호텔관광경영학과')
    into students_book values ('104', '홍민호', 2.8, '호텔관광경영학과')
    into students_book values ('105', '오연주', 3.2, '호텔관광경영학과')
    into students_book values ('106', '김우리', 2.5, '건축학과')
    into students_book values ('107', '조유근', 4.3, '건축학과')
select 1 from dual;

-- 데이터 타입 변경
alter table students_book modify (stscore decimal(10,5));

-- 데이터베이스 개론 책 p.272 문제 시작

select department 학과, count(*) as 결과 from students_book
group by department having  count(*)>2;

-- 최대 20글자 가변 길이 문자열 타입의 연락처 속성을 추가하는 sql문
alter table students_book add (phone varchar(20));

select * from students_book;

select stname from students_book order by department desc, stscore asc;

select avg(stscore) "평균 학점" from students_book
where department = (select department from students_book where stname='김우리');

update students_book set department = '전자과', stscore = 4.5 where stnum = 105;

select * from students_book;