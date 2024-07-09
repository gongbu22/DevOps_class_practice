-- 데이터베이스

-- DIKW  모델 : 데이터, 정보, 지식, 지혜

-- 스키마 : 데이터베이스에 저장되는 데이터 구조와 제약조건을 정의한 것
-- 인스턴스 : 스키마에 따라 데이터베이스에 실제로 저장된 값

-- DDL : CREATE, ALTER, DROP
-- create table abc (
--     b int not null,
--     c varchar(20),
--     primary key(b),
--     foreign key c references a(c)
-- );

-- drop table abc;
--
-- alter table MEMBERS2 add constraint mem_pk primary key (mid);


-- DML - insert, update, delete
-- insert into 테이블명 values (속성값);
--
-- insert all
--     into 테이블명 (속성이름,...) values (속성값, ...)
--     into 테이블명 (속성이름,...) values (속성값, ...)
--     into 테이블명 (속성이름,...) values (속성값, ...)
-- select 1 from dual;
--
-- insert into 테이블명(속성이름,...) values
--         (속성값, ...),
--         (속성값, ...),
--         (속성값, ...),
--         (속성값, ...);

create table abc (
    b int not null,
    c varchar(20),
    primary key(b)
);
 alter table abc add (d varchar(20));
alter table abc modify (c int);
alter table abc rename column b to bc;
alter table abc drop column c;

-- 8) 제품테이블에서 단가가 2000원이상이고
-- 3000원이하인 제품의 제품명, 단가, 제조업체를 조회하세요
select PNAME 제품명, PRICE 단가, MAKER 제조업체 from PRODUCTS
where PRICE between 2000 and 3000;

-- 8) 책이름이 '축구의 역사' 또는 '피겨 교본'인 도서의 출판사를 조회하세요
select BOOKNAME, PUBLISHER from BOOKS where BOOKNAME in ('축구의 역사', '피겨 교본');

-- 12. 2006년에 입사한 사원의 사원번호와 입사일을 조회하라.
select EMPLOYEE_ID, HIRE_DATE from EMPLOYEES
where to_char(HIRE_DATE, 'YYYY') = '2006';

-- 14. 연봉이 5000 에서 12000의 범위 이외인 사람들의 LAST_NAME 및 연봉을 조회힌다.
select LAST_NAME, SALARY from EMPLOYEES where SALARY not between 5000 and 12000;

-- 17. 1994년도에 고용된 모든 사람들의 LAST_NAME 및 고용일을 조회한다.
select LAST_NAME, HIRE_DATE from EMPLOYEES where to_char(HIRE_DATE, 'yyyy') = '1994';

-- 22. 연봉이 2,500, 3,500, 7000 이 아니며 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
select SALARY, JOB_ID from EMPLOYEES where SALARY not in (2500, 3500, 7000) and JOB_ID in ('SA_REP', 'ST_CLERK');

-- 고객테이블에서 고객이 몇명인지 조회
select count(CID) from CUSTOMERS;

-- 제품테이블에서 제조업체수 조회
select count( distinct maker) from PRODUCTS;

-- 제품테이블에서 3개 이상의 제품을 제조한 제조업체별로
-- 제품수와 제품 중 가장 비싼 단가를 조회
select maker, count(PID), max(PRICE) from PRODUCTS group by MAKER having count(PID) >= 3;

-- 고객 테이블에서 등급별 평균 적립금이
-- 1000원 이상인 등급에 대해
-- 등급별 고객수와 평균 적립금을 조회
select GRADE, count(CID), avg(MILEAGE) from CUSTOMERS
group by GRADE having avg(MILEAGE) >= 1000;

-- 28. 회사 전체의 최대 급여, 최소급여, 급여 총합 및 평균 급여를 조회하세요
select max(SALARY) "최대 급여", min(SALARY) "최소 급여",
       sum(SALARY) "급여 총합", round(avg(SALARY)) "평균 급여"
from EMPLOYEES;

-- 23) 주문테이블에서 banana 고객에 주문한
-- 상품의 이름을 조회하세요
select CID, PNAME from orders
inner join PRODUCTS using(PID) where CID='banana';

select CID, PNAME from ORDERS o
inner join PRODUCTS p on o.PID = p.PID
where CID = 'banana';

-- 28) 주문테이블에서 주문하지 않은 고객의 아이디, 이름을 조회하세요.
select CID, NAME from ORDERS
right join CUSTOMERS using(CID)
where OID is null;

-- 29) 주문테이블에서 주문되지 않은 제품의 이름, 제조업체를 조회하세요.
select PNAME, MAKER from ORDERS
right join PRODUCTS using(PID)
where OID is null;

-- 21) 도서를 구매하지 않은 고객을 포함하여
--    고객이름과 주문한 도서의 판매금액을 조회하세요
select NAME, sum(SALEPRICE) from CLIENTS
left join SPELLS using (CID)
group by NAME;

-- 급여가 3000이하인 사원의 이름과 급여, 근무지를 조회하세요
select FIRST_NAME, round(SALARY), CITY from EMPLOYEES
join DEPARTMENTS using (DEPARTMENT_ID)
join LOCATIONS using (LOCATION_ID)
where SALARY <= 3000;

-- 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의
-- 제품명과 업체 조회
select PNAME, MAKER from PRODUCTS
where PRICE > all (select PRICE from PRODUCTS where MAKER = '대한식품');

-- 2022년 3월 15일에 제품을 주문한 고객의 이름 조회
select NAME from CUSTOMERS c
where exists(select * from ORDERS o
                      where ODATE = '2022-03-15'
                          and c.CID = o.CID);

-- 23. 각 고객의 평균 주문금액보다
-- 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
select OID, CID, SALEPRICE from SPELLS o
where SALEPRICE > (select avg(SALEPRICE) from SPELLS s where o.cid = s.cid);

-- 42. LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및
-- 고용날짜를 조회한다. 단, Zlotkey 는 제외한다.
select EMPLOYEE_ID, LAST_NAME, HIRE_DATE from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID from EMPLOYEES where LAST_NAME = 'Zlotkey')
and LAST_NAME != 'Zlotkey';

-- 56. 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의
-- LAST_NAME, 부서 번호 및 연봉을 조회한다.
select LAST_NAME, DEPARTMENT_ID, SALARY from EMPLOYEES
where (DEPARTMENT_ID, SALARY) in (select distinct DEPARTMENT_ID, SALARY from EMPLOYEES
                                        where COMMISSION_PCT is not null);

-- 57. 위치 ID 가 1700 인 사원들의 연봉과 커미션이 동일한 사원들의 LAST_NAME,
-- 부서 번호 및 연봉을 조회한다.
-- NVL(컬럼명, null일 때 대체값) : NULL을 적절한 값을 변환하는 함수
select LAST_NAME, DEPARTMENT_ID, SALARY from EMPLOYEES
where (SALARY, NVL(COMMISSION_PCT, 0)) in (select SALARY, nvl(COMMISSION_PCT,0) from EMPLOYEES
                                            join DEPARTMENTS using(DEPARTMENT_ID)
                                            where LOCATION_ID = 1700)
and DEPARTMENT_ID not in (
    select DEPARTMENT_ID from DEPARTMENTS
    where LOCATION_ID = 1700
    );

-- vip 고객의 아이디, 이름, 나이로 구성된 뷰 생성
-- 단,이름은 우수고객으로 작성
create view 우수고객 as
    select CID, NAME, AGE from CUSTOMERS where GRADE = 'vip';

drop view 우수고객;

-- 제품번호가 p03인 제품의 이름을 '통큰파이'로 변경
update PRODUCTS
set PNAME = '통큰파이'
where PID = 'p03';

select * from PRODUCTS where PNAME = '통큰파이';

rollback;

select * from PRODUCTS;

-- 학생 테이블 생성
create table students (
    stdno   int     generated always as identity primary key,
    hakbun  varchar(20)     not null,
    name    varchar(10)     not null,
    regdate date    default sysdate
);

-- 사원들 중 많은 연봉을 받는 사원 10명 조회
select FIRST_NAME, DEPARTMENT_ID, SALARY from EMPLOYEES
order by SALARY desc, FIRST_NAME
offset 0 rows fetch next 10 rows only;

-- 사원들 중 많은 연봉을 받는 사원 11위 ~ 20위를 조회
select FIRST_NAME, DEPARTMENT_ID, SALARY from EMPLOYEES
order by SALARY desc, FIRST_NAME
offset 11 rows fetch next 10 rows only;

-- 사원들 중 많은 연봉을 받는 사원 21위 ~ 30위를 조회
select FIRST_NAME, DEPARTMENT_ID, SALARY from EMPLOYEES
order by SALARY desc, FIRST_NAME
offset 21 rows fetch next 10 rows only;

-- 주민번호에서 생일만 추출해서 출력
-- ex) 123456-1234567
-- substr(대상, 시작위치, 길이)
-- 시작위치는 1부터 시작!
select '123456-1234567',
    substr('123456-1234567', 0, 6)
from dual;

-- 사원의 이름과 성을 붙여서 출력
-- concat(합칠문자1, 합칠문자2)
-- '합칠문자1 || 합칠문자2' 로도 사용 가능
select concat(FIRST_NAME, ' ', LAST_NAME) from EMPLOYEES;

select FIRST_NAME || ' ' || LAST_NAME from EMPLOYEES;

-- ' abc123 ' 라는 문자열의 공백을 제거하고 출력
-- trim(문자열), ltrim(문자열), rtrim(문자열)
select trim(' abc123') from dual;

-- 'CORPORATE FLOOR' 라는 문자열에서
-- 3번째에서 시작해서 2번째 OR이 나타나는
-- 자리수(위치)를 출력
-- instr(대상, 찾을문자열, 찾을위치, 빈도위치)
-- 찾을 위치를 -n으로 지정하면 문자열 끝을 기준으로 찾음
-- 문자열 위치는 1부터 시작!!
select 'CORPORATE FLOOR',
       instr('CORPORATE FLOOR', 'OR'),
       instr('CORPORATE FLOOR', 'OR', -1),
       instr('CORPORATE FLOOR', 'OR', 3),
       instr('CORPORATE FLOOR', 'OR', 3, 2)
from dual;

-- 숫자형 데이터를 문자로 변환
-- 숫자가 문자형함수의 매개변수로 사용되면
-- 자동으로 문자로 형변환됨!
select 1234,
       to_char(1234),
       substr(1234, 4, 1)
from dual;

-- 기타 날짜함수
-- add_month(기준일, 개월수)
-- last_day
-- months_between(날짜1, 날짜2)
-- next_day(날짜, 찾을요일)

select sysdate,
       add_months(sysdate, 6),
       last_day(sysdate)
from dual;

-- 사원 테이블에서 사원 이름의 첫글자만 대문자로 출력하세요.
select initcap(FIRST_NAME) from EMPLOYEES;

-- 사원들의 급여를 통화 기호를 앞에 붙이고
-- 천 단위마다 콤마를 붙여서 조회하세요
-- format(값, 반올림자릿수) : 숫자에 컴마를 붙여 출력
select to_char(SALARY, 'L99,999') from EMPLOYEES;

-- 9월에 입사한 사원을 조회하세요
select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE from EMPLOYEES
where substr(to_char(HIRE_DATE, 'yyyy-mm-dd'), 6, 2) = '09';

