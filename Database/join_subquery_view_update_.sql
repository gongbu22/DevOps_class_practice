-- 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의
-- LAST_NAME, 부서 번호 및 연봉을 조회한다.
select distinct DEPARTMENT_ID, SALARY from EMPLOYEES where COMMISSION_PCT is not null;

select LAST_NAME 이름, DEPARTMENT_ID 부서번호, SALARY 연봉 from EMPLOYEES
where (DEPARTMENT_ID, SALARY) in (
    select distinct DEPARTMENT_ID, SALARY
    from EMPLOYEES
    where COMMISSION_PCT is not null
    );

-- LAST_NAME 이 'Kochhar' 인 사원과 동일한 연봉 및 커미션을 버는 사원들의
-- LAST_NAME, 부서 번호 및 연봉을 조회한다.
select SALARY, COMMISSION_PCT from EMPLOYEES where LAST_NAME = 'Kochhar';

select LAST_NAME 이름, DEPARTMENT_ID 부서번호, SALARY 연봉 from EMPLOYEES
where (SALARY, NVL(COMMISSION_PCT,0)) in (
    select SALARY, NVL(COMMISSION_PCT,0)
    from EMPLOYEES
    where LAST_NAME = 'Kochhar'
    );

-- 위치 ID 가 1700 인 사원들의 연봉과 커미션이 동일한 사원들의 LAST_NAME,
-- 부서 번호 및 연봉을 조회한다.
-- NVL(컬럼명, null일 때 대체값) : NULL을 적절한 값을 변환하는 함수

select LAST_NAME, DEPARTMENT_ID, SALARY, NVL(COMMISSION_PCT, 0) from EMPLOYEES
join DEPARTMENTS using (DEPARTMENT_ID) WHERE LOCATION_ID = 1700;

select LAST_NAME 이름, DEPARTMENT_ID 부서번호, SALARY 연봉 from EMPLOYEES
where (SALARY , NVL(COMMISSION_PCT, 0)) in (
    select SALARY , NVL(COMMISSION_PCT, 0)
    from EMPLOYEES
    join DEPARTMENTS using (DEPARTMENT_ID)
    WHERE LOCATION_ID = 1700
    );


--  ( Customers, Orders, Products )
-- 제품번호, 재고량, 제조업체를 골라서
-- 제품1라는 뷰를 생성하고
-- 제품번호는 p08, 재고량은 1000,
-- 제조업체는 신선식품이라는 정보를 추가함

create view 제품1 as
select PID 제품번호, STOCK 재고량, MAKER 제조업체 from PRODUCTS;

insert into 제품1 values ('p09', 1000, '신선식품');

drop view 제품1;

--- 부서번호와 부서별 최대 급여, 부서명을 조회하고 뷰 생성 (hr 테이블)
create view max_salary as
select DEPARTMENT_ID 부서번호, max(SALARY) 최대급여, DEPARTMENT_NAME 부서명 from EMPLOYEES
    join DEPARTMENTS using (DEPARTMENT_ID)
    group by DEPARTMENT_ID, DEPARTMENT_NAME;

drop view max_salary;

-- 판매테이블에서 정소화 고객이 주문한 제품의 수량을 5개로 수정하고 확인

 select NAME, QTY from CUSTOMERS join ORDERS using (CID) where NAME = '정소화';

update ORDERS set QTY = 5
where CID = (select cid from CUSTOMERS where NAME = '정소화');

rollback;

-- 마일리지가 300이상일때 silver에서 gold로 변경하기

select NAME, GRADE, MILEAGE from CUSTOMERS;

update CUSTOMERS set GRADE = 'gold'
where MILEAGE >= 300 and GRADE = 'silver';

rollback;

-- 고객별 주문의 총 가격 계산하는 뷰 만들기

create view sum_price as
select CID 고객번호, count(oid) 주문수, sum(PRICE) 총금액 from ORDERS
join PRODUCTS using (PID)
join CUSTOMERS using (CID)
group by CID;

select * from sum_price;

drop view sum_price;