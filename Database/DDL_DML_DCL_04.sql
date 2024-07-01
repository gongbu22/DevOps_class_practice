-- group by, having, inner join 복습
-- 2024.07.01

-- 연습문제 B3 - HR 데이터베이스
-- 모든 사원들의 LAST_NAME, 부서 이름 및
-- 부서 번호을 조회하세요
select LAST_NAME 이름, DEPARTMENT_NAME 부서명, DEPARTMENT_ID 부서번호
from EMPLOYEES e inner join DEPARTMENTS d
                            using (DEPARTMENT_ID);

-- 부서번호 30의 모든 직업들과 부서명으로 조회하세요
-- 90 부서 또한 포함한다.
select e.EMPLOYEE_ID 사원번호, d.DEPARTMENT_ID 부서번호, d.DEPARTMENT_NAME 부서명, JOB_TITLE 직업
from EMPLOYEES e inner join DEPARTMENTS d
                            on e.DEPARTMENT_ID = d.DEPARTMENT_ID
                 inner join JOBS j
                            on e.JOB_ID = j.JOB_ID
where d.DEPARTMENT_ID in (30, 90);

-- 부서번호 30 이하의 모든 직업들과
-- 부서명으로 조회하세요
select EMPLOYEE_ID 사원번호, JOB_TITLE 직업명, DEPARTMENT_ID 부서번호, DEPARTMENT_NAME 부서명
from DEPARTMENTS inner join EMPLOYEES
                            using(DEPARTMENT_ID)
                 inner join JOBS
                            using(JOB_ID)
where DEPARTMENT_ID <=30;

-- 커미션을 버는 모든 사람들의 LAST_NAME,
-- 부서명, 지역 ID 및 도시 명을 조회하세요
select LAST_NAME 이름, DEPARTMENT_NAME 부서명, CITY 도시명, REGION_ID 지역ID
from EMPLOYEES inner join DEPARTMENTS
                          using (DEPARTMENT_ID)
               inner join LOCATIONS
                          using (LOCATION_ID)
               inner join COUNTRIES
                          using (COUNTRY_ID)
where COMMISSION_PCT is not NULL;

SELECT * FROM EMPLOYEES e inner join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID where e.COMMISSION_PCT IS not NULL;

SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

-- 커미션을 버는 사람들 중 시애틀에 거주하는
-- 사람들의 LAST_NAME, 부서명, 지역 ID 및
-- 도시 명을 조회하세요 (옥스포드)
select e.LAST_NAME 이름, d.DEPARTMENT_NAME 부서명, c.REGION_ID 지역ID, l.CITY 도시명, e.COMMISSION_PCT
from EMPLOYEES e inner join DEPARTMENTS d
using (DEPARTMENT_ID)
inner join LOCATIONS l
using (LOCATION_ID)
inner join COUNTRIES c
using (COUNTRY_ID) where e.COMMISSION_PCT is not NULL and l.CITY = 'Seattle';

-- 자신의 매니저의 이름과 고용일을 조회하세요
select m.FIRST_NAME 매니저명
from EMPLOYEES e inner join EMPLOYEES m
on e.MANAGER_ID = m.EMPLOYEE_ID;


-- 자신의 매니저보다 먼저 고용된 사원들의
-- LAST_NAME 및 고용일을 조회하세요.
select e.LAST_NAME 이름, e.HIRE_DATE 고용일, m.HIRE_DATE "매니저 고용일"
from EMPLOYEES e inner join EMPLOYEES m
on e.MANAGER_ID = m.EMPLOYEE_ID where e.HIRE_DATE < m.HIRE_DATE;

-- 부서별 사원수를 조회하세요
select sum(e.EMPLOYEE_ID) 사원수
from EMPLOYEES e inner join DEPARTMENTS d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by d.DEPARTMENT_ID;