/* 
[JOIN 용어 정리]
  오라클       	  	                                SQL : 1999표준(ANSI)
----------------------------------------------------------------------------------------------------------------
등가 조인		                            내부 조인(INNER JOIN), JOIN USING / ON
                                            + 자연 조인(NATURAL JOIN, 등가 조인 방법 중 하나)
----------------------------------------------------------------------------------------------------------------
포괄 조인 		                        왼쪽 외부 조인(LEFT OUTER), 오른쪽 외부 조인(RIGHT OUTER)
                                            + 전체 외부 조인(FULL OUTER, 오라클 구문으로는 사용 못함)
----------------------------------------------------------------------------------------------------------------
자체 조인, 비등가 조인   	                    	JOIN ON
----------------------------------------------------------------------------------------------------------------
카테시안(카티션) 곱		               			교차 조인(CROSS JOIN)
CARTESIAN PRODUCT

- 미국 국립 표준 협회(American National Standards Institute, ANSI) 미국의 산업 표준을 제정하는 민간단체.
- 국제표준화기구 ISO에 가입되어 있음.
*/
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- JOIN
-- 하나 이상의 테이블에서 데이터를 조회하기 위해 사용.
-- 수행 결과는 하나의 Result Set으로 나옴.

/* 
- 관계형 데이터베이스에서 SQL을 이용해 테이블간 '관계'를 맺는 방법.

- 관계형 데이터베이스는 최소한의 데이터를 테이블에 담고 있어
  원하는 정보를 테이블에서 조회하려면 한 개 이상의 테이블에서 
  데이터를 읽어와야 되는 경우가 많다.
  이 때, 테이블간 관계를 맺기 위한 연결고리 역할이 필요한데,
  두 테이블에서 같은 데이터를 저장하는 컬럼이 연결고리가됨.   
*/

--------------------------------------------------------------------------------------------------------------------------------------------------

-- 기존에 서로 다른 테이블의 데이터를 조회 할 경우 아래와 같이 따로 조회함.

-- 직원번호, 직원명, 부서코드, 부서명을 조회 하고자 할 때
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
-- 직원번호, 직원면, 부서코드는 EMPLOYEE테이블에 조회가능

-- 부서명은은 DEPARTMENT테이블에서 조회 가능
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


/*  JOIN은 단순히 테이블을 두개를 붙이는 것이 아닌
 *  
 *  기준 삼은 테이블의 한 컬럼을 지정해
 *  다른 테이블의 한 컬럼과 같은 행을 찾아
 *   
 *  기준 테이블 옆에 한 행씩 붙여나감 
 *   */

---------------------------------------------------------

-- 1. 내부 조인(INNER JOIN) ( == 등가 조인(EQUAL JOIN))
--> 연결되는 컬럼의 값이 일치하는 행들만 조인됨.  
-- (== 일치하는 값이 없는 행은 조인에서 제외됨. )

-- 작성 방법 크게 ANSI구문과 오라클 구문 으로 나뉘고 
-- ANSI에서  USING과 ON을 쓰는 방법으로 나뉜다.

-- *ANSI 표준 구문
-- ANSI는 미국 국립 표준 협회를 뜻함, 미국의 산업표준을 제정하는 민간단체로 
-- 국제표준화기구 ISO에 가입되어있다.
-- ANSI에서 제정된 표준을 ANSI라고 하고 
-- 여기서 제정한 표준 중 가장 유명한 것이 ASCII코드이다.

-- *오라클 전용 구문
-- FROM절에 쉼표(,) 로 구분하여 합치게 될 테이블명을 기술하고
-- WHERE절에 합치기에 사용할 컬럼명을 명시한다



-- 1) 연결에 사용할 두 컬럼명이 다른 경우

-- EMPLOYEE 테이블, DEPARTMENT 테이블을 참조하여
-- 사번, 이름, 부서코드, 부서명 조회

SELECT
	EMP_ID, EMP_NAME , DEPT_ID ,DEPT_TITLE 
FROM 
	DEPARTMENT 
JOIN
	EMPLOYEE ON (DEPT_ID = DEPT_CODE);
	

-- EMPLOYEE 테이블에 DEPT_CODE컬럼과 DEPARTMENT 테이블에 DEPT_ID 컬럼은 
-- 서로 같은 부서 코드를 나타낸다.
--> 이를 통해 두 테이블이 관계가 있음을 알고 조인을 통해 데이터 추출이 가능.

-- ANSI
-- 연결에 사용할 컬럼명이 다른 경우 ON()을 사용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-- 오라클 (JOIN이라는 단어를 작성하지 않음)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;







-- DEPARTMENT 테이블, LOCATION 테이블을 참조하여
-- 부서명, 지역명 조회

-- ANSI 방식
SELECT * FROM DEPARTMENT ;
SELECT * FROM LOCATION ;

SELECT 
	DEPT_TITLE ,LOCAL_NAME
FROM 
	DEPARTMENT 
JOIN
	LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 오라클 방식
SELECT 
	DEPT_TITLE ,LOCAL_NAME,
	LOCATION_ID ,LOCAL_CODE
FROM 
	DEPARTMENT ,LOCATION 
WHERE
	LOCATION_ID = LOCAL_CODE;



-- 2) 연결에 사용할 두 컬럼명이 같은 경우

-- EMPLOYEE 테이블, JOB테이블을 참조하여
-- 사번, 이름, 직급코드, 직급명 조회

-- ANSI
-- 연결에 사용할 컬럼명이 같은 경우 USING(컬럼명)을 사용함
SELECT * FROM EMPLOYEE ;
SELECT * FROM JOB;

SELECT *
FROM 
	EMPLOYEE 
JOIN
	JOB ON(JOB_CODE = JOB_CODE);
-- ORA-00918: 열의 정의가 애매합니다
--> 컬럼명이 겹칠 경우 발생하는 오류

/* 오류 해결 방법 1 : 어떤 테이블의 컬럼인지 구분하기 */
SELECT *
FROM EMPLOYEE 
JOIN
	JOB ON(EMPLOYEE.JOB_CODE = JOB.JOB_CODE);
-> 조회 결과에 JOB_CODE 컬럼이 2개(각각의 테이블 컬럼)

/* 오류 해결 방법 2 : JOIN USING() 구분 사용하기 
 * - JOIN에 사용되는 컬럼명이 같은 경우 USING 사용 가능
 * */
SELECT *
FROM EMPLOYEE 
JOIN
	JOB USING (JOB_CODE);
--> USING을 이용해서 JOIN을 하면 
-- JOIN에 사용된 컬럼이 하나로 합쳐진다!!!

-- 오라클 -> 별칭 사용
-- 테이블 별로 별칭을 등록할 수 있음.

SELECT T1.JOB_CODE ,JOB_NAME
FROM EMPLOYEE T1,JOB T2 
WHERE T1.JOB_CODE = T2.JOB_CODE ;


SELECT *
FROM EMPLOYEE ;  --> DEPT_CODE 값이 NULL인 행이 2행 존재

SELECT *
FROM DEPARTMENT ; --> DEPT_ID 값이 NULL인 행이 없음

/* INNER JOIN :
 * JOIN에 사용된 컬럼 값이 일치하는 행들끼리 연결
 * --> 일치하지 않은 행은 연결 X -> 결과 포함 X
 */

SELECT *
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 21행 조회
-- 왜? 23행이 아니라 21행?
-- EMPLOYEE에 DEPT_CODE값이 NULL인행이 2개 있지만
-- DEPARTMENT의 DEPT_ID는 NULL인 행이 없기 때문에 연결 X



---------------------------------------------------------------------------------------------------------------


-- 2. 외부 조인(OUTER JOIN)

-- 두 테이블의 지정하는 컬럼값이 일치하지 않는 행도 조인에 포함을 시킴
-->  *반드시 OUTER JOIN임을 명시해야 한다.

-- OUTER JOIN과 비교할 INNER JOIN 쿼리문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> JOIN 기본 값 == INNER

-- 1) LEFT [OUTER] JOIN  : 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의 
-- 컬럼 수를 기준으로 JOIN

-- ANSI 표준
SELECT
	EMP_NAME, DEPT_CODE, DEPT_ID, NVL(DEPT_TITLE,'부서없음') AS DEPT_TITLE 
FROM
	EMPLOYEE 
LEFT OUTER JOIN
	DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM EMPLOYEE ;
SELECT * FROM DEPARTMENT ;
-- 오라클 구문
SELECT
	EMP_NAME, DEPT_CODE, DEPT_ID, NVL(DEPT_TITLE,'부서없음') AS DEPT_TITLE 
FROM
	EMPLOYEE , DEPARTMENT 
WHERE 
	DEPT_CODE = DEPT_ID(+) ;


-- 2) RIGHT [OUTER] JOIN : 합치기에 사용한 두 테이블 중 
-- 오른편에 기술된 테이블의  컬럼 수를 기준으로 JOIN

-- ANSI 표준
SELECT
	EMP_NAME, DEPT_CODE, DEPT_ID, NVL(DEPT_TITLE,'부서없음') AS DEPT_TITLE 
FROM
	EMPLOYEE 
RIGHT OUTER JOIN
	DEPARTMENT ON (DEPT_CODE = DEPT_ID)
ORDER BY 
	DEPT_CODE ASC NULLS FIRST;

-- 오라클 구문
SELECT
	EMP_NAME, DEPT_CODE, DEPT_ID, NVL(DEPT_TITLE,'부서없음') AS DEPT_TITLE 
FROM
	EMPLOYEE, DEPARTMENT 
WHERE 
	DEPT_CODE(+) = DEPT_ID
ORDER BY 
	DEPT_CODE ASC NULLS FIRST;

-- 3) FULL [OUTER] JOIN   : 합치기에 사용한 두 테이블이 가진 모든 행을 결과에 포함
-- ** 오라클 구문은 FULL OUTER JOIN을 사용 못함

-- ANSI 표준
SELECT
	EMP_NAME, DEPT_CODE, DEPT_ID, NVL(DEPT_TITLE,'부서없음') AS DEPT_TITLE 
FROM
	EMPLOYEE 
FULL OUTER JOIN
	DEPARTMENT ON (DEPT_CODE = DEPT_ID)
ORDER BY 
	DEPT_CODE ASC NULLS FIRST;



---------------------------------------------------------------------------------------------------------------

-- 3. 교차 조인(CROSS JOIN == CARTESIAN PRODUCT)
--  조인되는 테이블의 각 행들이 모두 매핑된 데이터가 검색되는 방법(곱집합)

-- ANSI 방식
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE 
CROSS JOIN DEPARTMENT 
ORDER BY EMP_NAME, DEPT_CODE;

-- 오라클 방식
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE ,DEPARTMENT 
ORDER BY EMP_NAME, DEPT_CODE;
	
--> NATURAL JOIN(자연 조인)의
-- 실패 결과로 나타나는 모습으로 기억하자!!

---------------------------------------------------------------------------------------------------------------

-- 4. 비등가 조인(NON EQUAL JOIN)

-- '='(등호)를 사용하지 않는 조인문
--  지정한 컬럼 값이 일치하는 경우가 아닌, 값의 범위에 포함되는 행들을 연결하는 방식
SELECT * FROM SAL_GRADE ;

-- 사원의 급여가
-- SAL_LEVEL에 작성된 최소(MIN_SAL) ~ 최대(MAX_SAL)
-- 범위에 맞게 책정되어 있을 때만 조회 결과(RESULT SET)에 포함하기

SELECT 
	E.EMP_NAME, E.SAL_LEVEL, E.SALARY,
	S.SAL_LEVEL, S.MIN_SAL, S.MAX_SAL
FROM
	EMPLOYEE E
JOIN
 	SAL_GRADE S  
 	ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
--	SAL_GRADE USING(SAL_LEVEL);

---------------------------------------------------------------------------------------------------------------

-- 5. 자체 조인(SELF JOIN)

-- 같은 테이블을 조인.
-- 자기 자신과 조인을 맺음
--> tip : 같은 테이블이 2개 있다고 생각하면 쉽다!!

-- EMPLOYEE 테이블에서
-- 모든 사원의 사번, 이름, 사수번호(MANAGER_ID), 사수 이름 조회

-- ANSI 표준
SELECT
	EMP.EMP_ID, 
	EMP.EMP_NAME, 
	NVL(MGR.EMP_ID,'없음') "사수 번호", 
	NVL(MGR.EMP_NAME,'없음') "사수 이름"
FROM
	EMPLOYEE EMP
LEFT JOIN
	EMPLOYEE MGR ON (EMP.MANAGER_ID = MGR.EMP_ID)
ORDER BY
	EMP.EMP_ID ASC;


-- 오라클 구문
SELECT
	EMP.EMP_ID, 
	EMP.EMP_NAME, 
	NVL(MGR.EMP_ID,'없음') "사수 번호", 
	NVL(MGR.EMP_NAME,'없음') "사수 이름"
FROM
	EMPLOYEE EMP, EMPLOYEE MGR
WHERE
	EMP.MANAGER_ID = MGR.EMP_ID(+)
ORDER BY
	EMP.EMP_ID ASC;


---------------------------------------------------------------------------------------------------------------

-- 6. 자연 조인(NATURAL JOIN)
-- 동일한 타입과 이름을 가진 컬럼이 있는 테이블 간의 조인을 간단히 표현하는 방법
-- 반드시 두 테이블 간의 동일한 컬럼명, 타입을 가진 컬럼이 필요
--> 없을 경우 교차조인이 됨.

-- EMPLOYEE 테이블 JOB 테이블 INNER JOIN

-- 1) ON 이용 방법 // 두 테이블 간의 공통 컬럼이 합쳐지지않고 두개 다 나옴
									 --> 따라서 별칭을 지정해 줘야 한다
SELECT *
--	EMP_NAME, E.JOB_CODE, JOB_NAME
FROM
	EMPLOYEE E 
JOIN 
	JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- 2) USING 이용 방법 //두 테이블 간의 공통 컬럼이 하나로 합쳐짐
SELECT *
--	EMP_NAME, JOB_CODE, JOB_NAME
FROM
	EMPLOYEE 
JOIN
	JOB USING (JOB_CODE);


-- NATURAL JOIN 이용
SELECT
	EMP_NAME, JOB_CODE, JOB_NAME
FROM
	EMPLOYEE 
NATURAL JOIN JOB;
-- JOIN 컬럼명 명시 X
--> 자동으로 같은 타입, 같은 이름의 컬럼을 찾아서 JOIN
--> 사용자가 테이블의 구조를 모두 파악하고 있어야 사용 가능
--> 그래서 거의 안씀

/* NATURAL JOIN 실패하는 경우 
 * -> 같은 타입, 같은 이름의 컬럼이 없을 경우 발생
 * -> 결과 CROSS JOIN 형태가 조회된다
 * */
SELECT
	EMP_NAME, DEPT_TITLE
FROM
	EMPLOYEE 
NATURAL JOIN 
	DEPARTMENT ;




---------------------------------------------------------------------------------------------------------------

-- 7. 다중 조인
-- N개의 테이블을 조회할 때 사용  (순서 중요!)

-- EMPLOYEE, DEPARTMENT, LOCATION 테이블 JOIN

-- ANSI 표준
SELECT 
	EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM
	EMPLOYEE 
JOIN 
	DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- 21행 17열
JOIN 
	LOCATION ON (LOCATION_ID = LOCAL_CODE); -- 21행 20열

-- 오라클 전용 (AND 구문을 이용해서 추가 JOIN)
SELECT 
	EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM
	EMPLOYEE, DEPARTMENT, LOCATION
WHERE 
	DEPT_CODE = DEPT_ID
AND
	LOCATION_ID = LOCAL_CODE;

	

-- 조인 순서를 지키지 않은 경우(에러발생)
--> JOIN은 같은 값을 가지는 컬럼을 연결고리 삼아서 
--  두 테이블을 연결하는 것인데
-- 	JOIN 순서가 잘못되면 같은 값을 가지는 컬럼이
--  존재하지 않을 수 있다.

--SELECT 
--	EMP_NAME, DEPT_TITLE, LOCAL_NAME
--FROM
--	EMPLOYEE 
--JOIN 
--	LOCATION ON (LOCATION_ID = LOCAL_CODE); -- 21행 20열
---- EMPLOYEE,LOCATION 각각의 테이블에 서로의 테이블에 존재하는
---- 공통 컬럼이 존재하지 않음
--JOIN 
--	DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- 21행 17열


--[다중 조인 연습 문제]

-- 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요

SELECT * FROM JOB ; -- 직급

SELECT * FROM LOCATION -- 아시아 지역
WHERE LOCAL_NAME LIKE 'ASIA%';

SELECT EMP_ID, EMP_NAME 
FROM EMPLOYEE ; -- 사번, 이름

SELECT  DEPT_ID, DEPT_TITLE
FROM DEPARTMENT ; -- 부서코드, 부서명

-- ANSI
SELECT 
 E.EMP_ID , E.EMP_NAME , J.JOB_NAME , 
 D.DEPT_TITLE , L.LOCAL_NAME , E.SALARY 
FROM 
	EMPLOYEE E
JOIN
	JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN 
	DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN 
	LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE
	J.JOB_NAME = '대리'
AND
	LOCAL_NAME LIKE 'ASIA%';
	
-- 오라클 전용




---------------------------------------------------------------------------------------------------------------
SELECT * FROM EMPLOYEE ;
SELECT * FROM DEPARTMENT ;
SELECT * FROM JOB ;
SELECT * FROM LOCATION ;
SELECT * FROM SAL_GRADE ;
SELECT * FROM NATIONAL ;

-- [연습문제]

-- 1. 주민번호가 80년대 생이면서 성별이 여자이고, 성이 '전'씨인 직원들의 
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT 
	E.EMP_NAME, E.EMP_NO, DEPT_TITLE, J.JOB_NAME 
FROM 
	EMPLOYEE E
JOIN
	DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN
	JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE 
	E.EMP_NO LIKE '8%'
AND 
	SUBSTR(E.EMP_NO,8,1) = '2'
AND
	E.EMP_NAME LIKE '전%';
      
      
-- 2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT 
	E.EMP_ID, E.EMP_NAME , J.JOB_NAME 
FROM 
	EMPLOYEE E 
JOIN
	JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE 
	E.EMP_NAME LIKE '%형%';


-- 3. 해외영업 1부, 2부에 근무하는 사원의 
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT 
	E.EMP_NAME, J.JOB_NAME, E.DEPT_CODE , DEPT_TITLE 
FROM 
	EMPLOYEE E
JOIN
	DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN
	JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE
	DEPT_TITLE IN ('해외영업1부','해외영업2부')
ORDER BY
	DEPT_TITLE DESC;
	
	
--4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT 
	EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM 
	EMPLOYEE 
JOIN
	DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN 
	LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE 
	BONUS IS NOT NULL;
	

--5. 부서가 있는 사원의 사원명, 직급명, 부서명, 지역명 조회
SELECT 
 E.EMP_NAME, J.JOB_NAME , DEPT_TITLE , LOCAL_NAME
FROM 
	EMPLOYEE E
JOIN
	DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN 
	LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN
	JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE 
	DEPT_TITLE IS NOT NULL;


-- 6. 급여등급별 최소급여(MIN_SAL)를 초과해서 받는 직원들의
--사원명, 직급명, 급여, 연봉(보너스포함)을 조회하시오.
--연봉에 보너스포인트를 적용하시오.
SELECT 
	E.EMP_NAME , J.JOB_NAME , E.SALARY , E.SALARY*(1+NVL(E.BONUS,0)) *12 "연봉"
FROM 
	EMPLOYEE E
JOIN
	JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN
 	SAL_GRADE S ON (E.SAL_LEVEL = S.SAL_LEVEL)
WHERE
	E.SALARY > S.MIN_SAL;


-- 7.한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT 
	EMP_NAME "사원명", DEPT_TITLE "부서명", 
	L.LOCAL_NAME "지역명", N.NATIONAL_NAME "국가명"
FROM 
	EMPLOYEE E
JOIN
	DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN 
	LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN
	NATIONAL N ON (N.NATIONAL_CODE = L.NATIONAL_CODE)
WHERE
	N.NATIONAL_NAME IN ('한국','일본');



-- 8. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- SELF JOIN 사용
SELECT
	E.EMP_NAME , E.DEPT_CODE, F.EMP_NAME
FROM 
	EMPLOYEE E
JOIN
	EMPLOYEE F ON (E.DEPT_CODE = F.DEPT_CODE)
WHERE 
	E.EMP_NAME != F.EMP_NAME
ORDER BY
	E.EMP_NAME ASC;


-- 9. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, JOIN, IN 사용할 것
SELECT
	E.EMP_NAME, J.JOB_NAME, E.SALARY 
FROM 
	EMPLOYEE E
JOIN
	JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE
	BONUS IS NULL
AND
	E.JOB_CODE IN ('J4','J7');






