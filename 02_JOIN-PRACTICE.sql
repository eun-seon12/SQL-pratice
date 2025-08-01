-- JOIN을 이용하여 여러 테이블을 조회 시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.

-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원의 사번, 이름, 직급명, 부서명, 지역명, 급여를 조회하세요
select
       a.emp_id,
       a.emp_name,
       c.job_name,
       b.dept_title,
       d.local_name,
       a.salary
  from employee a 
  join job c on a.job_code = c.job_code
  join department b on a.dept_code = b.dept_id
  join location d on b.location_id = d.local_code
 where c.job_code = 'J6'
   and d.local_name like '%ASIA%';
   
-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 전씨인 직원의 이름, 주민등록번호, 부서명, 직급명을 조회하세요.
select
       a.emp_name,
       a.emp_no,
       b.dept_title,
       c.job_name
  from employee a
  join department b on a.dept_code = b.dept_id
  join job c on a.job_code = c.job_code
 where a.emp_no like '7%'
   and a.emp_no like '_______2______'
   and a.emp_name like '전%';
   
-- 3. 이름에 '형'자가 들어가는 직원의 사번, 이름, 직급명을 조회하세요.
select
       a.emp_id,
       a.emp_name,
       c.job_name
  from employee a
  join job c on a.job_code = c.job_code
 where a.emp_name like '%형%';

-- 4. 해외영업팀에 근무하는 직원의 이름, 직급명, 부서코드, 부서명을 조회하세요.
select
       a.emp_name,
       c.job_name,
       a.dept_code,
       b.dept_title
  from employee a
  join department b on a.dept_code = b.dept_id
  join job c on a.job_code = c.job_code
 where b.dept_title like '해외영업%';

-- 5. 보너스포인트를 받는 직원의 이름, 보너스, 부서명, 지역명을 조회하세요.   
select
       a.emp_name,
       a.bonus,
       b.dept_id,
	   d.local_name
  from employee a
  join department b on a.dept_code = b.dept_id
  join location d on b.location_id = d.local_code
 where a.bonus is not null;

-- 6. 부서코드가 D2인 직원의 이름, 직급명, 부서명, 지역명을 조회하세오.           
select
       a.emp_name,
       c.job_name,
       b.dept_title,
       d.local_name
  from employee a
  join department b on a.dept_code = b.dept_id
  join job c on a.job_code = c.job_code
  join location d on b.location_id = d.local_code
 where a.dept_code = 'D2'; 

-- 7. 한국(KO)과 일본(JP)에 근무하는 직원의 이름, 부서명, 지역명, 국가명을 조회하세요.
select
       a.emp_name,
       b.dept_title,
       d.local_name,
       e.national_name
  from employee a
  join department b on a.dept_code = b.dept_id
  join location d on b.location_id = d.local_code
  join nation e on d.national_code = e.national_code
 where e.national_name = '한국'
    or e.national_name = '일본'
