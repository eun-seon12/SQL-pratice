-- 1. 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회하세요.
select
       emp_name
  from employee
 where dept_code = (select
                           dept_code
					  from employee
					 where emp_name = '노옹철');

-- 2. 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
select
       emp_id,
       emp_name,
       job_code,
       salary
  from employee
 where salary > (select
                        avg(salary)
				   from employee);

-- 3. 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여를 조회하세요.
select
       emp_id,
       emp_name,
       dept_code,
       job_code,
       salary
  from employee
 where salary > (select
				        salary
				   from employee
				  where emp_name = '노옹철');

-- 4. 가장 적은 급여를 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여, 입사일을 조회하세요.
select
       emp_id,
       emp_name,
       dept_code,
       job_code,
       salary,
       hire_date
  from employee
 where salary = (select
                        min(salary)
                   from employee);
			     
-- *** 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.

-- 5. 부서별 최고 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회하세요.
select
       emp_name,
       job_code,
       dept_code,
       salary
  from employee
 where salary in (select
                        max(salary)
				   from employee
				  group by dept_code);
                  

-- 6. 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 정보를 추출하여 조회하세요.
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- HINT!! is not null, union(혹은 then, else), distinct

select
       a.emp_id as 사번,
       a.emp_name as 이름,
       b.dept_title as 부서명,
       c.job_name as 직급,
       '관리자' as 구분
  from employee a
  join department b on a.dept_code = b.dept_id
  join job c on a.job_code = c.job_code
 where emp_id in (select
				   distinct manager_id
                     from employee
                    where manager_id is not null)
 
union
select
       a.emp_id as 사번,
       a.emp_name as 이름,
       b.dept_title as 부서명,
       c.job_name as 직급,
       '직원' as 구분
  from employee a
  join department b on a.dept_code = b.dept_id
  join job c on a.job_code = c.job_code
 where a.emp_id not in (select
				   distinct manager_id
                     from employee
                    where manager_id is not null);
			

-- 7. 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
-- 단, 급여와 급여 평균은 만원단위로 계산하세요.
-- HINT!! round(컬럼명, -5)
select
       emp_id,
       emp_name,
       job_code,
       salary
  from employee a
 where round(salary, -5) in (select
								    round(avg(salary), -5)
						       from employee
                               where job_code = a.job_code);
					
                   
 

-- 8. 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 직원의 이름, 직급코드, 부서코드, 입사일을 조회하세요.
select
       emp_id,
       emp_name,
       job_code,
       dept_code,
       hire_date
  from employee
 where ent_yn = 'N' 
   and (dept_code, job_code) = (select
                                      dept_code,
                                      job_code
								 from employee
								where ent_yn = 'Y');

-- 9. 급여 평균 3위 안에 드는 부서의 부서 코드와 부서명, 평균급여를 조회하세요.
-- HINT!! limit
select
       a.dept_code,
       b.dept_title,
       avg(salary) as 평균급여
  from employee a
  join department b on a.dept_code = b.dept_id
 group by a.dept_code, b.dept_title
 order by avg(a.salary) desc          
 limit 3;

-- 10. 부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은 부서의 부서명과, 부서별 급여 합계를 조회하세요.
select
       b.dept_title,
       sum(a.salary)
  from employee a
  join department b on a.dept_code = b.dept_id
 group by b.dept_title, sum(a.salary)
 