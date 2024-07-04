-- identity와 등록일 테이블 생성
--customers  테이블 생성
create table customers_home (
    cusno   generated always as identity primary key,
    cid     varchar(6) not null,
    name    varchar(15),
    age     int,
    grade   varchar(6)  default 'silver',
    job     varchar(20),
    mileage int         default 0,
    regdate date        default sysdate
 );

-- 사원들 중 많은 연봉을 받는 사원 15명 조회
select FIRST_NAME 이름, SALARY 연봉 from EMPLOYEES
order by SALARY desc
offset 0 rows fetch next 15 rows only;

-- 사원들 중 연봉순위 11위 ~ 15위 조회
select FIRST_NAME 이름, SALARY 연봉 from EMPLOYEES
order by SALARY desc
offset 10 rows fetch next 5 rows only;

select FIRST_NAME, SALARY from EMPLOYEES
order by SALARY desc;

-- 사원들 중 연봉순위 16위 ~ 20위 조회'
select FIRST_NAME 이름, SALARY 연봉 from EMPLOYEES
order by SALARY desc
offset 15 rows fetch next 5 rows only;

-- function

-- 사원 테이블에서 사원 이름의 첫글자만 대문자로 출력하세요.
select initcap(FIRST_NAME) 이름 from EMPLOYEES;

-- 사원 테이블에서 사원 이름의 길이를 출력하세요.
select NAME,
       length(NAME) length,
       lengthb(NAME) bytelength
from CUSTOMERS;

-- 사원 테이블에서 사원이름의 세번째 자리가 R인 사원의 정보를
-- 출력하세요.
select FIRST_NAME
from EMPLOYEES
where instr(upper(FIRST_NAME), 'R') = 3;

-- (Clients, Books, Spells)
-- 도서제목에 야구가 포함된 도서를
-- 농구로 변경한 후 도서 목록을 보이시오.
select BOOKNAME 도서명,
       replace(BOOKNAME, '야구', '농구')
from BOOKS
where instr(BOOKNAME, '야구') >0;

-- 고객 중에서 같은 성(姓)을 가진 사람이
-- 몇 명이나 되는지 성별 인원수를 구하시오.
select substr(NAME, 1, 1),
       count(substr(NAME, 1, 1))
from CLIENTS
group by substr(NAME, 1, 1);

-- 마당서점은 각 주문일기준 월말에 재고보충을
-- 확정한다. 각 주문의 재고보충일자를 구하시오
select OID,
       ORDERDATE 주문일,
       last_day(ORDERDATE) 재고보충일자
from SPELLS;

----(hr)--------

-- 입사한 사원은 3개월후에 정직원으로 채용된다
-- 사원 이름, 입사일, 정식채용일을 조회하세요
select FIRST_NAME 이름, HIRE_DATE 입사일,
       add_months(HIRE_DATE, 3) 정식채용일
from EMPLOYEES;

-- 사원 테이블에서 이름의 끝자리가
-- N으로 끝나는 사원의 정보를 출력하세요.
select FIRST_NAME 이름
from EMPLOYEES
where instr(upper(FIRST_NAME), 'N',-1) = length(FIRST_NAME);

-- 사원 테이블에서 이름과 입사일자
-- 그리고 현재날까지의 경과일을 산출하세요
-- (소숫점을 빼버리고 해당이름을 경과일로 바꾸세요)
select FIRST_NAME, sysdate, HIRE_DATE,
       round(sysdate - HIRE_DATE)  경과일
from EMPLOYEES;

-- 사원 테이블에서 입사후 6개월이
-- 지난날짜 바로 다음 일요일을 구하세요.
select HIRE_DATE,
       add_months(HIRE_DATE, 6),
       next_day(add_months(HIRE_DATE, 6), '일')
from EMPLOYEES
order by HIRE_DATE;
