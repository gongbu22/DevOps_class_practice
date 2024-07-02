-- 1. 부서 이름과 함께 직원 조회
select DEPARTMENT_NAME 부서이름, LAST_NAME 직원명 from EMPLOYEES
join DEPARTMENTS using (DEPARTMENT_ID);

-- 2. 부서가 배정되지 않은 직원 조회
select EMPLOYEE_ID 사번 from EMPLOYEES
where DEPARTMENT_ID is null;

-- 3. 각 직급별 직원 수 및 평균 급여 조회
select JOB_ID 직급, count(EMPLOYEE_ID) "직원 수", avg(SALARY) "평균 급여" from EMPLOYEES
group by JOB_ID;

-- 4. 가장 높은 급여를 받는 직원이 근무하는 부서를 식별하세요.
select EMPLOYEE_ID 직원 from EMPLOYEES where SALARY = (select max(SALARY) from EMPLOYEES);

select DEPARTMENT_ID 부서번호 from EMPLOYEES
where EMPLOYEE_ID = (select EMPLOYEE_ID 직원 from EMPLOYEES
                        where SALARY = (select max(SALARY) from EMPLOYEES));

-- 5. 직원의 직함을 성에 따라 알파벳 순으로 나열하세요.
select FIRST_NAME from EMPLOYEES order by FIRST_NAME;

-- 6. 직원이 10명 이상인 부서를 찾아 부서 이름과 직원 수를 나열하세요.
select DEPARTMENT_NAME 부서명,  count(EMPLOYEE_ID) 직원수 from EMPLOYEES
join DEPARTMENTS using (DEPARTMENT_ID)
group by DEPARTMENT_NAME having (count(EMPLOYEE_ID) >= 10);

-- 7. 2003년 1월 1일 이전에 입사한 직원들의 평균 급여를 계산하세요.
select avg(SALARY) "평균 급여" from EMPLOYEES where HIRE_DATE < '2003-01-01';

-- 8. 회사 전체 평균 연봉보다 더 받는 사원들의 사번 및 LAST_NAME 을 조회한다.
select avg(SALARY) from EMPLOYEES;

select EMPLOYEE_ID 사번, LAST_NAME 이름 from EMPLOYEES
where SALARY > (select avg(SALARY) from EMPLOYEES);

-- 9. 직원의 연봉이 2000만 달러를 넘지 않는 부서를 찾아 보세요.
select distinct DEPARTMENT_NAME 부서명 from EMPLOYEES
join DEPARTMENTS using (DEPARTMENT_ID) where SALARY < 2000;

-- 10. 각 부서별 총 급여와 평균 급여 조회
select sum(SALARY) "총 급여", round(avg (SALARY)) "평균 급여" from EMPLOYEES group by DEPARTMENT_ID;

