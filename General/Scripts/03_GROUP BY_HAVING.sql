/* SELECT문 해석 순서
  5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
  1 : FROM 참조할 테이블명
  2 : WHERE 컬럼명 | 함수식 비교연산자 비교값
  3 : GROUP BY 그룹을 묶을 컬럼명
  4 : HAVING 그룹함수식 비교연산자 비교값
  6 : ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS FIRST | LAST];
*/

-----------------------------------------------------------------------------------------------------------------------------------------

-- * GROUP BY절 : 같은 값들이 여러개 기록된 컬럼을 가지고 같은 값들을
--              하나의 그룹으로 묶음
-- GROUP BY 컬럼명 | 함수식, ....
-- 여러개의 값을 묶어서 하나로 처리할 목적으로 사용함
-- 그룹으로 묶은 값에 대해서 SELECT절에서 그룹함수를 사용함

-- 그룹 함수는 단 한개의 결과 값만 산출하기 때문에 그룹이 여러 개일 경우 오류 발생
-- 여러 개의 결과 값을 산출하기 위해 그룹 함수가 적용된 그룹의 기준을 ORDER BY절에 기술하여 사용



-- EMPLOYEE 테이블에서 부서코드, 부서(그룹) 별 급여 합계 조회
/*3*/SELECT 
			DEPT_CODE ,
			SUM(SALARY)
/*1*/FROM 
			EMPLOYEE
/*2*/GROUP BY 
			DEPT_CODE ;
-- 1 EMPLOYEE 테이블에서
-- 2 DEPT_CODE가 같은 행을 그룹으로 만들어라
-- 3 묶은 그룹의 DEPT_CODE와 각 그룹에 속한 인원의 급여 합 조회



-- EMPLOYEE 테이블에서 
-- 부서코드, 부서 별 급여의 합계, 부서 별 급여의 평균(정수처리), 인원 수를 조회하고 
-- 부서 코드 순으로 정렬
SELECT 
	DEPT_CODE ,
	SUM(SALARY) ,
	FLOOR(AVG(SALARY)) AS 평균 ,
	COUNT(*) AS "인원 수"
FROM 	
	EMPLOYEE 
GROUP BY
	DEPT_CODE 
ORDER BY 
	DEPT_CODE ASC;



-- EMPLOYEE 테이블에서 
-- 부서코드와 부서별 보너스를 받는 사원의 수를 조회하고 
-- 부서코드 순으로 정렬
SELECT 
	DEPT_CODE ,
	COUNT(BONUS) AS "보너스 받는 사원 수" -- NULL값 제외하고 COUNT
FROM 
	EMPLOYEE 
GROUP BY
	DEPT_CODE 
ORDER BY 
	DEPT_CODE ;



-- EMPLOYEE 테이블에서
-- 성별과 성별 별 급여 평균(정수처리), 급여 합계, 인원 수 조회하고
-- 인원수로 내림차순 정렬
SELECT 
	DECODE(SUBSTR(EMP_NO,8,1),'1','남자','2','여자') AS 성별,
	FLOOR(AVG(SALARY)) AS "급여 평균",
	SUM(SALARY) AS "급여 합",
	COUNT(*) AS "인원 수"
FROM
	EMPLOYEE 
GROUP BY
	DECODE(SUBSTR(EMP_NO,8,1),'1','남자','2','여자')
ORDER BY
	"인원 수" DESC;



-- * WHERE절 GROUP BY절을 혼합하여 사용
--> WHERE절은 각 컬럼 값에 대한 조건 (SELECT문 해석 순서를 잘 기억하는 것이 중요!!)


-- EMPLOYEE 테이블에서 부서코드가 'D5', 'D6'인 부서의 평균 급여 조회
SELECT 
	DEPT_CODE 부서코드,
	FLOOR(AVG(SALARY)) AS "평균 급여" 
FROM 
	EMPLOYEE 
WHERE 
	DEPT_CODE IN ('D5','D6')
GROUP BY 
	DEPT_CODE ;





-- EMPLOYEE 테이블에서 직급 별 2010년도 이후 입사자들의 급여 합을 조회
SELECT 
	JOB_CODE AS 직급,
	SUM(SALARY) AS "급여 합"
FROM 
	EMPLOYEE 
WHERE 
	EXTRACT(YEAR FROM HIRE_DATE) >= 2010
GROUP BY
	JOB_CODE
ORDER BY
	JOB_CODE ASC;



-- * 여러 컬럼을 묶어서 그룹으로 지정 가능
-- *** GROUP BY 사용시 주의사항
--> SELECT문에 GROUP BY절을 사용할 경우
--  SELECT절에 명시한 조회할려면 컬럼 중
--  그룹함수가 적용되지 않은 컬럼을 
--  모두 GROUP BY절에 작성해야함.

-- EMPLOYEE 테이블에서 부서 별로 같은 직급인 사원의 급여 합계를 조회하고
-- 부서 코드 오름차순으로 정렬
SELECT 
	DEPT_CODE ,JOB_CODE, SUM(SALARY) 
FROM 
	EMPLOYEE 
GROUP BY
	DEPT_CODE ,JOB_CODE -- 1) 부서 그룹   2) 부서내 직급 그룹
ORDER BY 
	DEPT_CODE ASC ;




-- EMPLOYEE 테이블에서 부서 별로 급여 등급이 같은 직원의 수를 조회하고
-- 부서코드, 급여 등급 오름차순으로 정렬
SELECT 
	DEPT_CODE 부서코드,
	SAL_LEVEL 급여등급 ,
	COUNT(*) 직원수
FROM 
	EMPLOYEE 
GROUP BY
	DEPT_CODE , SAL_LEVEL 
ORDER BY 
	DEPT_CODE ASC;




--------------------------------------------------------------------------------------------------------------------------

/* WHERE 절
 * - FROM절에서 지정된 테이블의 전체 행 중
 * 	 조건에 맞는 행만 선택
 */


-- * HAVING 절 : 그룹함수로 구해 올 그룹에 대한 조건을 설정할 때 사용

/* GROUP BY를 통해서 만들어진 그룹 중
 * 조건에 맞는 그룹만 선택
 */

-- HAVING 컬럼명 | 그룹함수식 비교연산자 비교값

-- 부서별 평균 급여가 3500000원 이상인 부서를 조회하여 부서코드 오름차순으로 정렬
SELECT 
	DEPT_CODE 부서 ,
	FLOOR(AVG(SALARY)) AS "부서별 평균 급여"
FROM 
	EMPLOYEE 
WHERE 
	SALARY >= 3500000
GROUP BY
	DEPT_CODE 
ORDER BY 
	DEPT_CODE ASC;
--> 개인 급여가 350만 이상인 사람들만 모아서 
--> 부서별로 그룹을 나누고 평균 구함

SELECT 
	DEPT_CODE 부서 ,
	FLOOR(AVG(SALARY)) AS "부서별 평균 급여"
FROM 
	EMPLOYEE 
GROUP BY
	DEPT_CODE 
HAVING 
	FLOOR(AVG(SALARY))>=3500000
ORDER BY 
	DEPT_CODE ASC;
-- 나눠진 부서 그룹별로 급여 평균을 구했을 때
-- 급여 평균이 350만 이상인 부서만 조회



-- 부서별 그룹의 급여 합계 중 9백만원을 초과하는 부서코드와 급여 합계 조회
-- 부서 코드 순으로 정렬
SELECT 
	DEPT_CODE AS "부서 코드",
	SUM(SALARY) AS "급여 합계"
FROM 
	EMPLOYEE 
GROUP BY
	DEPT_CODE
HAVING 
	SUM(SALARY)>=9000000
ORDER BY 
	DEPT_CODE ;



                      
------ 연습 문제 ------

-- 1. EMPLOYEE 테이블에서 각 부서별 가장 높은 급여, 가장 낮은 급여를 조회하여
-- 부서 코드 오름차순으로 정렬하세요.
SELECT 
	DEPT_CODE ,
	MAX(SALARY) AS "부서별 가장 높은 급여",
	MIN(SALARY) AS "부서별 가장 낮은 급여"
FROM 
	EMPLOYEE 
GROUP BY
	DEPT_CODE 
ORDER BY 
	DEPT_CODE ASC;



-- 2.EMPLOYEE 테이블에서 각 직급별 보너스를 받는 사원의 수를 조회하여
-- 직급코드 오름차순으로 정렬하세요
SELECT 
	JOB_CODE 직급,
	COUNT(BONUS) AS "보너스 받는 사원 수"
FROM 
	EMPLOYEE 
GROUP BY
	JOB_CODE
ORDER BY 
	JOB_CODE ASC;
--> 전체를 일단 그룹으로 만들어서
-- BONUS 받는 사람들을 카운트 하는 것이
-- 0이라는 결과가 조회되기 때문에
-- 통계 자료 측면에 더 좋다!!
	
-- 3.EMPLOYEE 테이블에서 
-- 부서별 80년대생의 급여 평균이 400만 이상인 부서를 조회하여
-- 부서 코드 오름차순으로 정렬하세요
SELECT
	DEPT_CODE AS "부서 코드",
	FLOOR(AVG(SALARY)) AS "부서별 급여 평균"
FROM 
	EMPLOYEE 
WHERE 
	SUBSTR(EMP_NO,1,1) = '8'
GROUP BY
	DEPT_CODE 
HAVING 
	FLOOR(AVG(SALARY)) >= 4000000
ORDER BY 
	DEPT_CODE ASC;
                      
         

--------------------------------------------------------------------------------------------------------------                     

-- 집계함수(ROLLUP, CUBE)
-- 그룹 별 산출한 결과 값의 집계를 계산하는 함수
-- GOURP BY 절에만 작성하는 함수


-- ROLLUP 함수 : 그룹별로 중간 집계 처리를 하는 함수
-- 그룹별로 묶여진 값에 대한 '중간 집계'와 '총 집계'를 계산하여 자동으로 추가하는 함수
-- * 인자로 전달받은 그룹중에서 가장 먼저 지정한 그룹별 합계와 총 합계를 구하는 함수

-- EMPLOYEE 테이블에서 
-- 각 부서에 소속된 직급 별 급여합, 
-- 부서 별 급여 합,
-- 전체 직원 급여 총합 조회

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;


------------------------------------------------


-- CUBE 함수 : 그룹별 산출한 결과를 집계하는 함수이다.
-- * 그룹으로 지정된 모든 그룹에 대한 집계와 총 합계를 구하는 함수

-- EMPLOYEE 테이블에서 각 부서 마다 직급별 급여합,
-- 부서 전체 급여 합,

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- ROLLUP 결과에 아래 두 SQL문의 결과가 추가됨
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;


---------------------------------------------------------------------------------------------------------------------------------


-- * SET OPERATION(집합 연산)
-- 여러 개의 SELECT 결과물을 하나의 쿼리로 만드는 연산자
-- 여러가지의 조건이 있을 때 그에 해당하는 여러개의 결과값을 결합시키고 싶을때 사용
-- 초보자들이 사용하기 쉽다.(조건들을 어떻게 엮어야 되는지 덜 생각해도 되니깐)
-- (주의) 집합 연산에 사용되는 SELECT문은 SELECT절이 동일해야함

-- UNION은 OR 같은 개념 (합집합) --> 중복 제거
-- INTERSECT는 AND 같은 개념 (교집합)
-- UNION ALL은 OR 결과 값에 AND 결과값이 더해진거(합집합 + 교집합) --> 중복 미제거
-- MINUS는 차집합 개념 


-- UNION : 여러개의 쿼리 결과를 하나로 합치는 연산자
-- 중복된 영역을 제외하여 하나로 합친다.

-- 부서코드가 'D5'인 사원의 이름, 부서코드, 직급코드 조회
SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	DEPT_CODE = 'D5'
	
	UNION -- 합집합 (중복되는 행 한 번만 출력)
-- 직급 코드가 'J7'인 사원의 이름, 부서코드, 직급코드 조회
SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	JOB_CODE = 'J7';


-- 합집합의 결과는 OR 연산과 같다
SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	JOB_CODE = 'J7'
OR
	DEPT_CODE = 'D5';



-- INTERSECT : 여러개의 SELECT한 결과에서 공통 부분만 결과로 추출 (교집합)

SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	DEPT_CODE = 'D5'
	
	INTERSECT -- 교집합

-- 직급 코드가 'J7'인 사원의 이름, 부서코드, 직급코드 조회
SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	JOB_CODE = 'J7';


-- 교집합의 결과는 AND 연산과 같다
SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	JOB_CODE = 'J7'
AND
	DEPT_CODE = 'D5';

-- UNION ALL : 여러개의 쿼리 결과를 하나로 합치는 연산자
-- UNION과의 차이점은 중복영역을 모두 포함시킨다. (합집합 +  교집합)

SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	DEPT_CODE = 'D5'
	
	UNION ALL -- 합집합 + 교집합 (중복 존재)

-- 직급 코드가 'J7'인 사원의 이름, 부서코드, 직급코드 조회
SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	JOB_CODE = 'J7';

-- MINUS : 선행 SELECT 결과에서 다음 SELECT 결과와 겹치는 부분을 
-- 제외한 나머지 부분만 추출(차집합)


SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	DEPT_CODE = 'D5'
	
	MINUS -- 차집합

-- 직급 코드가 'J7'인 사원의 이름, 부서코드, 직급코드 조회
SELECT 
	EMP_NAME ,
	DEPT_CODE ,
	JOB_CODE 
FROM 
	EMPLOYEE 
WHERE 
	JOB_CODE = 'J7';




