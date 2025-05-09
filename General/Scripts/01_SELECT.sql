/* SELECT
 * 
 * - 지정된 테이블에서 원하는 데이터가 존재하는
 *   행, 열을 선택해서 조회하는 SQL(구조적 질의 언어)
 * 
 * - 선택된 데이터 == 조회 결과 묶음 == RESULT SET
 * 
 * - 조회 결과는 0행 이상
 *   (조건에 맞는 행이 없을 수 있다!)
 */

/* [SELECT 작성법 -1]
 * 
 * 2) SELECT * 또는 컬럼명, .. 등
 * 1) FROM 테이블명;
 * 
 * - 지정된 테이블의 모든 행에서 특정 열(컬럼)만 조회하기
 */
 
-- EMPLOYEE 테이블에서
-- 모든 행의 이름(EMP_NAME), 급여(SALARY) 컬럼 조회

SELECT EMP_NAME, SALARY 
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서
-- 모든 행(== 모든 사원)의 사번, 이름, 급여, 입사일 조회
SELECT EMP_ID , EMP_NAME, SALARY, HIRE_DATE 
FROM EMPLOYEE;


-- EMPLOYEE 테이블의
-- 모든 행, 모든 열(컬럼) 조회
--> *(asterisk) : "모든", "포함"을 나타내는 기호
SELECT *
FROM EMPLOYEE;


-- DEPARTMENT 테이블에서
-- 부서코드, 부서명 조회
SELECT DEPT_ID , DEPT_TITLE
FROM DEPARTMENT;


-- EMPLOYEE 테이블에서
-- 이름, 이메일, 전화번호 조회
SELECT EMP_NAME, EMAIL ,PHONE 
FROM EMPLOYEE;

------------------------------------------------------

/* 컬럼 값 산술 연산*/

/*
 * 컴럼 값; 행과 열이 교차되는 한 칸에 작성된 값
 * 
 * - SELECT절 칼럼명에 산술 연산을 작성하면 조회결과(RESULT SET)에서
 * 모든 행에 산술 연산이 적용된 칼럼 값이 조회된다!!
 */

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여, 급여+100만 회
SELECT EMP_NAME, SALARY , SALARY + 10
FROM EMPLOYEE ;

-- 모든 사업의 이름, 급여(1개월), 연봉(급여~12) 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE 

--------------------------------------------------------------
/* - SYSDATE / CURRENT_DATE
 * SYSIMESTAMP / CURRENT_TIMESTAMP
 */

/* DB는 날짜, 시간 관련 데이터를 다룰 수 있도록하는 자료형 제공
 * 
 * - DATE 타입 : 년,월,일,시,분,초, 요일 저장
 * 
 * - TIMESTAMP 타입 : 년,월,일,시,분,초,요일,MS 지역 저장
 * 
 * -SYS(시스템) : 시슽엠에 설정된 사간
 * - CURRENT : 현재 접속한 세션(사용자)의 시간 기반
 * 
 * - SYSDATE : 현재 시스템 시간 불러오기
 * - CURRENT DATE : 헌재 사용자 계정 기반 시간 얻어오기
 * 
 * -> DATA -> TIMEStAMP 바꾸면 ms단위 + 지역
 */
SELECT SYSDATE ,CURRENT_DATE 
FROM DUAL;

SELECT SYSTIMESTAMP ,CURRENT_TIMESTAMP 
FROM DUAL;

/* DUAL(DUmmy tAble) 테이블
 * - 임시 테이블
 * - 조회하려는 데이터가 실제 테이블에 저장된 데이터가 아닌 경우
 *   사용하는 임시 테이블
 */

/* 날짜 데이터 연산하기 (+,-만 가능!!) */

-- 날짜 + 정수 : 정수 만큼 "일" 수 증가
-- 날짜 - 정수 : 정수 만큼 "일" 수 감소

-- 어제, 오늘, 내일, 모레 조회
SELECT
	CURRENT_DATE -1,
	CURRENT_DATE,
	CURRENT_DATE +1,
	CURRENT_DATE +2
FROM DUAL;


/* 시간 연산 응용 (알아두면 도움 많이됨!!) */
SELECT 
	CURRENT_DATE,
	CURRENT_DATE +1/24, -- + 1시간 
	CURRENT_DATE +1/24/60, -- + 1분 
	CURRENT_DATE +1/24/60/60, -- + 1초 
	CURRENT_DATE +1/24/60/60 *30 -- + 30초 
FROM DUAL ;


/* 날짜 끼리 - 연산 
 * 날짜 - 날짜 = 두 날짜 사이의 차이나는 일 수
 * 
 * * TO_DATE('날짜모양문자열','인식패턴')
 * -> '날짜모양문자열'을 '인식패턴'을 이용해 해석하여
 *    DATE 타입으로 변환
 * */
SELECT 
	TO_DATE('2025-02-19','YYYY-MM-DD'),
	'2025-02-19'
FROM
	DUAL;

-- 오늘(2/19)부터 2/28까지 남은 일 수
SELECT 
	TO_DATE('2025-02-28','YYYY-MM-DD') 
	- TO_DATE('2025-02-19','YYYY-MM-DD') 
FROM
	DUAL;



-- 종강일(7/17) 까지 남은 일 수 == 148
SELECT 
	TO_DATE('2025-07-17','YYYY-MM-DD') 
	- TO_DATE('2025-02-19','YYYY-MM-DD') 
FROM
	DUAL;



-- 퇴근시간까지 남은 시간(분)
SELECT 
	(TO_DATE('2025-02-19 17:50:00','YYYY-MM-DD HH24:MI:SS') 
	- CURRENT_DATE)*24*60
FROM
	DUAL;
	

-- EMPLOYEE TABLE에서
-- 모든 사원의 사번, 이름, 입사일, 현재까지 근무 일수, 연차 조회
SELECT 
	EMP_ID ,
	EMP_NAME ,
	HIRE_DATE ,	
	FLOOR(CURRENT_DATE -HIRE_DATE) , -- 내림
	CEIL((CURRENT_DATE -HIRE_DATE)/365)	-- 올림
FROM EMPLOYEE ;


----------------------------------------------------------

/* 컬럼명 별칭(Alias) 지정하기 
 * 
 * [지정 방법]
 * 1) 컬럼명 AS 별칭  : 문자 O, 띄어쓰기 X, 특수문자 X
 * 
 * 2) 컬럼명 AS "별칭": 문자 O, 띄어쓰기 O, 특수문자 O
 * 
 * * AS 구문은 생략 가능!!
 * 
 * * ORACLE에서 ""의 의미
 * - "" 내부에 작성된 글자 모양 그대로를 인식해라!!
 * 
 * ex) 문자열        오라클 인식
 * 		 	 abc    ->   ABC, abc (대소문자 구분X) 
 *      "abc"   ->     abc ("" 내부 작성된 모양으로만 인식)
 * */


-- EMPLOYEE TABLE에서
-- 모든 사원의 사번, 이름, 입사일, 현재까지 근무 일수, 연차 조회
-- 단, 별칭 꼭 지정!!
SELECT 
	EMP_ID AS 사번, -- AS별칭
	EMP_NAME 이름, -- AS생략
	HIRE_DATE "입사한 날짜", -- 띄어쓰기 있어서 "" 넣어야 함	
	FLOOR(CURRENT_DATE -HIRE_DATE) "근무 일수", 
	CEIL((CURRENT_DATE -HIRE_DATE)/365)	AS 연차
FROM EMPLOYEE ;


-- EMPLOYEE TABLE에서
-- 모든 사원의 사번, 이름, 급여(원),연봉(급여*12)를 조회
-- 단, 컬럼명은 모두 별칭 조회
SELECT 
	EMP_ID AS 사번, -- AS별칭
	EMP_NAME 이름, -- AS생략
	SALARY AS "급여(원)",
	SALARY*12 "연봉(급여*12)"
FROM EMPLOYEE ;


-------------------------------------------------

/* 연결 연산자(||) 
 * - 두 컬럼값 또는 리터럴을 하나의 문자열로 연결할 때 사용
 * */
SELECT 
	EMP_ID ,EMP_NAME, EMP_ID||EMP_NAME
FROM EMPLOYEE ;


-------------------------------------------------
/* 리터럴 : 값(DATA)을 표기하는 방식(문법)
 * - NUMBER 타입 : 20, 1.12, -44 (정수, 실수 표기)
 * - CHAR,VARCHAR2 타입(문자열) :
 * 	 'AB','가나다'(''홑따옴표)
 *  
 * * SELECT절에 리터럴을 작성하면 조회결과(RESULT SET) 
 * 	 모든 행에 리터럴이 추가된다
 */
SELECT SALARY , '원', SALARY || '원' 급여
FROM EMPLOYEE; 


------------------------------------------------
/* DISTINCT(별개의, 전혀다른)
 * 
 * - 조회 결과 집합(RESULT SET)에서 
 * 	 DISTINCT가 지정된 컬럼에 중복된 값이 존재할 경우 
 * 	 중복을 제거하고 한 번만 표시할 때 사용
 * 
 * (중복된 데이터를 가진 행을 제거)
 */

-- EMPLOYEE TABLE에서
-- 모든 사원의 부서 코드(DEPT_CODE) 조회
SELECT 
	DEPT_CODE
FROM
	EMPLOYEE ; -- 23행 조회(중복 O)


-- 사원들이 속한 부서 코드 조회
	--> 사원이 있는 부서만 조회
SELECT 
	DISTINCT DEPT_CODE
FROM
	EMPLOYEE ; -- 7행 조회(중복 X)

	
-----------------------------------
/* [SELECT 작성법 -2]
 * 
 * 3) SELECT 컬럼명 || 리터럴 || 
 * 1) FROM 테이블명 -- 테이블 선택
 * 2) WHERE 조건식; -- 행 선택
 * 
 */

/* *** WHERE ***
 * 
 * - 테이블에서 조건을 충족하는 행을 조회할때 사용
 * 
 * - WHERE 절에는 조건식(결과가 T/F)만 작성 가능
 * 
 * - 비교 연산자 : >, <, >=, <=, =(같다),!=
 * 
 * - 논리 연산자 : AND, OR, NOT
 */

-- EMPLOYEE 테이블에서
-- 급여가 400만원을 초과하는 사원의
-- 사번,이름,급여를 조회
SELECT EMP_ID, EMP_NAME,SALARY 
FROM EMPLOYEE 
WHERE SALARY > 4000000;


	
-- EMPLOYEE TABLE에서
-- 급여가 500만원 이하인 사원의
-- 사번, 이름, 급여, 부서코드, 직급코드를 조회
SELECT 
	EMP_ID ,
	EMP_NAME ,
	SALARY ,
	DEPT_CODE ,
	JOB_CODE 
FROM EMPLOYEE 
WHERE SALARY < 5000000;
	
	
-- EMPLOYEE 테이블에서
-- 연봉이 5천만원 이하인 사원의
-- 이름, 연봉 조회
SELECT 
	EMP_NAME 이름, SALARY *12 연봉
FROM EMPLOYEE 
WHERE SALARY*12 < 50000000;
	

-- 이름이 노옹철인 사원의
-- 사번, 이름, 전화번호 조회
SELECT 
	EMP_ID ,
	EMP_NAME ,
	PHONE 
FROM EMPLOYEE 
WHERE EMP_NAME = '노옹철';

-- 부서코드(DEPT_CODE)가 'D9'이 아닌 사원의
-- 이름, 부서코드 조회
SELECT 
	EMP_NAME ,
	DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE <> 'D9';

-- 부서코드가 'D9'인 사원만 조회
SELECT 
	EMP_NAME ,
	DEPT_CODE 
FROM 
	EMPLOYEE 
WHERE 
	DEPT_CODE = 'D9'; -- 3행 조회

-- 전체 : 23행, D9 : 3행, D9 아님 : 18행
--> 2행 어디로?

/* *** NULL ***
 * 
 * - DB에서 NULL : 빈 칸 (저장된 값 없음)
 * 
 * - NULL은 비교 대상이 없기 때문에
 * 	 =, != 등의 비교연산 결과가 무조건 FALSE
 */

/* *** NULL 비교연산 ***
 * 
 * 1) 컬럼명 IS NULL : 해당 컬럼 값이 NULL 이면 TRUE 반환
 * 
 * 2) 컬럼명 IS NOT NULL : 해당 컬럼 값이 NULL이 아니면 TRUE 반환
 * 												== 컬럼에 값이 존재하면 TRUE
 * (컬럼 값의 존재 유무를 비교하는 연산)
 */

-- EMPLOYEE 테이블에서
-- 부서코드(DEPT_CODE)가 없는 사원의
-- 사번, 이름, 부서 코드 조회
SELECT
	EMP_ID, EMP_NAME, DEPT_CODE
FROM
	EMPLOYEE 
WHERE 
	DEPT_CODE IS NULL;
--DEPT_CODE = NULL <-이거 안됨!


-- BONUS가 존재하는 사원의
-- 이름, 보너스 조회
SELECT EMP_NAME ,BONUS
FROM 
	EMPLOYEE 
WHERE 
	BONUS IS NOT NULL;


-------------------------------------------------

/* *** 논리 연산자(AND/OR) ***
 * 
 * - 두 조건식의 결과에 따라 새로운 결과를 만드는 연산
 * - AND(그리고)
 * 두 연산의 결과가 TRUE 일때만 최종결과 TRUE
 * -> 두 조건을 모두 만족하는 행을 결과 집합에 포함
 * 
 * - OR(또는)
 * 두 연산의 결과가 FALSE 일때만 최종결과 FALSE
 * -> 두 조건 중하나라도 만족하는 행을 결과 집합에 포함
 * 
 * - 우선 순위 : AND>OR
 * 
 */


-- EMPLOYEE 테이블에서
-- 부서코드가 'D6'인 사원 중
-- 급여가 400만원을 초과하는 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME ,DEPT_CODE ,SALARY 
FROM 
	EMPLOYEE 
WHERE 
	SALARY>4000000 AND DEPT_CODE = 'D6';


-- EMPLOYEE 테이블에서
-- 급여가 300만원 이상, 500만원 미만인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID ,EMP_NAME ,SALARY 
FROM 
	EMPLOYEE 
WHERE 
	SALARY>=3000000 AND SALARY<5000000;


-- EMPLOYEE 테이블에서
-- 급여가 300만 미만 또는 500만 이상인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID,EMP_NAME ,SALARY
FROM
	EMPLOYEE 
WHERE 
	SALARY<3000000 OR SALARY>=5000000; -- 7행 조회

	
-------------------------------------------------------
	/* 컬럼명 BETWEEN (A) AND (B)
	 * 
	 * - 컬럼값이 A이상 B이하인 경우 TRUE(조회하겠다) 
	 */

	-- EMPLOYEE TABLE에서
	-- 급여가 400만 ~600만인 사원의 이름, 급여 조회
	SELECT EMP_NAME, SALARY
	FROM
		EMPLOYEE 
	WHERE 
		SALARY BETWEEN 4000000 AND 6000000; -- 6행 조회


-------------------------------------------------------
	/* 컬럼명 NOT BETWEEN (A) AND (B)
	 * 
	 * - 컬럼값이 A이상 B이하인 경우 FALSE
	 * -> A미만 B초과인 경우에만 TRUE 
	 */
	
-- EMPLOYEE TABLE에서
-- 급여가 400만 미만, 600만 초과인 사원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM
	EMPLOYEE 
WHERE 
	SALARY  NOT BETWEEN 4000000 AND 6000000; -- 


/* 날짜 비교에 더 많이 사용 !!! */
-- EMPLOYEE 테이블에서
--	2010년대(2010.01.01 ~ 2019,.12.31)에
--	입사한 사원의 이름, 입사일 조회
SELECT EMP_NAME ,HIRE_DATE 
FROM
	EMPLOYEE
WHERE 
	HIRE_DATE BETWEEN
	TO_DATE('2010.01.01','YYYY.MM.DD') 
	AND 
	TO_DATE('2019.12.31','YYYY.MM.DD'); -- 10행 조회
	

/* 일치하는 값만 조회*/

-- 부서코드가 'D5','D6','D9'인 사원의
--	사번, 이름, 부서코드 조회
SELECT EMP_ID ,EMP_NAME ,DEPT_CODE 
FROM
	EMPLOYEE
WHERE 
		DEPT_CODE = 'D5'
OR  DEPT_CODE = 'D6'
OR  DEPT_CODE = 'D9'; -- 12행 조회

/* 컬럼명 IN (값1, 값2, 값3, ...)
 * 
 * - 컬럼 값이 IN () 안에 존재한다면 TRUE
 *  == 연속으로 OR 연산을 작성한 것과 같은 효과
 * */

-- SQL에서 OR -> IN으로 변경
SELECT 
	EMP_ID, EMP_NAME, DEPT_CODE
FROM
	EMPLOYEE 
WHERE 
	DEPT_CODE IN ('D5','D6','D9');

/* 컬럼명 NOT IN (값1, 값2, 값3, ...)
 * 
 * - 컬럼 값이 IN () 안에 존재한다면 FLASE
 *  == 값이 포함되지 않는 행만 조회
 * */
SELECT 
	EMP_ID, EMP_NAME, DEPT_CODE
FROM
	EMPLOYEE 
WHERE 
	DEPT_CODE NOT IN ('D5','D6','D9');

-- DEPT_CODE가 NULL인 사원은 포함 X

-- 부서 코드가 'D5','D6','D9'이 아닌 사원을 조회
-- + NLLL인 사원도 포함
SELECT 
	EMP_ID, EMP_NAME, DEPT_CODE
FROM
	EMPLOYEE 
WHERE 
	DEPT_CODE NOT IN ('D5','D6','D9')
OR 
	DEPT_CODE IS NULL;



/* *** LIKE(~와 같은, 비슷한) ***
 * 
 * - 비교하려는 값이 특정한 패턴을 만족하면 조회하는 연산자
 * 
 * [작성법]
 * 
 * WHERE 컬럼명 LIKE '패턴'
 * 
 * [패턴에 사용되는 기호(와일드 카드)]
 * 
 * 1) '%' (포함)
 * '%A' : A로 끝나는 문자열인 경우 TRUE
 * 				-> 앞쪽에는 어떤 문자열이든 관계 없음(빈 칸도 가능)
 * 
 * 'A%' : A로 시작하는 문자열인 경우 TRUE
 * 
 * '%A%' : A를 포함한 문자열인 경우 TRUE
 * 
 * 2) '_' (글자 수, _ 1개당 1글자)
 * 
 * ___ : 문자열이 3글자인 경우 TRUE
 * 
 * A___ : A로 시작하고 뒤에 3글자인 경우
 * 			EX) ABCD(O), ABCDE(X)
 * 
 * ___A : 앞에 3글자, 마지막은 A로 끝나는 경우 TRUE
 */

--EMPLOYEE TABLE에서
--성이 '전' 씨인 사원 찾기
SELECT 
	EMP_NAME
FROM
	EMPLOYEE 
WHERE 
	EMP_NAME LIKE '전%'; --전형동, 전지연
	
--이름이 '수'로 끝나는 사원 찾기
SELECT 
	EMP_NAME
FROM
	EMPLOYEE 
WHERE 
	EMP_NAME LIKE '%수'; --방명수
	
--이름에 '하'가 포함된 사원 찿기
SELECT 
	EMP_NAME
FROM
	EMPLOYEE 
WHERE 
	EMP_NAME LIKE '%하%'; --정중하,하이유,하동운,유하진
	

--전화번호가 010으로 시작하는 사원의
--이름, 전화번호 조회
SELECT 	
	EMP_NAME, PHONE
FROM
	EMPLOYEE
WHERE 
	-- % 방법
--	PHONE LIKE '010%';

	-- _ 방법
	PHONE LIKE '010________';


--EMAIL 컬럼에서 @ 앞에 아이디 글자 수가 5글자인 사원의
--사번,이름,이메일 조회
SELECT 
	EMP_ID ,EMP_NAME ,EMAIL 
FROM
	EMPLOYEE 
WHERE 
	EMAIL LIKE '_____@%'; -- 4행
	

--EMAIL 아이디 중 '_' 앞 글자 수가 3글자인 사원의
--사번, 이름, 이메일 조회
SELECT 
	EMP_ID ,EMP_NAME ,EMAIL 
FROM
	EMPLOYEE 
WHERE 
	EMAIL LIKE '____%'; -- 전체조회
--> 이메일이 4글자 이상이면 조회
/* 발생한 문제 : "구분자"로 사용하려던 '_'가
 * LIKE의 와일드카드 '_'로 해석되면서 문제 발생
 * 
 * [해결 방법]
 * - LIKE ESCAPE OPTION 이용
 * 	-> 지정된 특수문자 뒤 '딱 한 글자' 를
 * 		 와일드 카드가 아닌 단순 문자열로 인식시키는 옵션
 * 
 * - 작성법
 * WHERE LIK '___#_' ESCAPE '#'
 * -> '#' 바로 뒤 '_'는 와일드 카드X, 단순 문자열 O
 */
SELECT 
	EMP_ID ,EMP_NAME ,EMAIL 
FROM
	EMPLOYEE 
WHERE 
	EMAIL LIKE '___#_%' ESCAPE '#';

--------------------------------------------------------------

/* [SELECT 작성법 -1]
 * 
 * 3) SELECT 컬럼명...  -- 열선택
 * 1) FROM   테이블명   -- 테이블 선택
 * 2) WHERE  조건식			-- 행 선택
 * 4) ORDER BY 					-- 조회 결과 정렬
 * 
 * *** ORDER BY 절 ***
 * - SELECT의 조회 결과 집합(RESULT SET)을
 * 	 원하는 순서로 정렬할 때 사용하는 구문
 * 
 * - 작성법
 * 
 * ORDER BY 컬럼명 | 별칭 | 컬럼순서 | 함수
 * 				[ASC/ DESC] (오름차순/내림차순)
 * 				[NULLS FIRST/NULLS LAST] (NULL 데이터 위치 지정)
 * 
 * ** 중요!!! **
 * ORDER BY 절은 해당 SELECT문 제일 마지막에만 수행!!!
 * 
 * - 오름차순(ASCENDING) : 점점 커지는 순서로 정렬
 * EX) 1->10 / A->Z / 가->하 / 과거->미래
 * 
 * - 내림차순(DESCENDING) : 점점 작아지는 순서로 정렬
 * 
 */

--EMPLOYEE 테이블의 모든 사원을
--이름 오름차순으로 정렬하여 조회
SELECT 
	EMP_NAME
FROM
	EMPLOYEE 
ORDER BY
	EMP_NAME ASC;


--급여 내림 차순으로 이름, 급여 조회
SELECT 	
	EMP_NAME,SALARY
FROM
	EMPLOYEE 
ORDER BY
	SALARY DESC;

-- + WHERE 절 추가
--부서코드가 'D5'.'D6','D9'인 사원의
--사번, 이름, 급여, 부서코드
--를 급여 내림차순으로 조회
SELECT 
	EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM
	EMPLOYEE 
WHERE 
	DEPT_CODE IN ('D5' ,'D6', 'D9')
ORDER BY 
	SALARY DESC;


--부서코드가 'D5'.'D6','D9'인 사원의
--사번, 이름, 급여, 부서코드
--를 부서코드 오름차순으로 조회
SELECT 
	EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM
	EMPLOYEE 
WHERE 
	DEPT_CODE IN ('D5' ,'D6', 'D9')
ORDER BY 
	DEPT_CODE ASC;


-----------------------------------------------------------

/* 별칭을 이용하여 정렬하기 
 * 
 * - ORDER BY 절은 제일 마지막에 해석된다!!
 * 
 * - ORDER BY절 보다 먼저 먼저 해석되는
 *   SELECT절에 별칭을 
 * 	 ORDER BY절에서 인식할 수 있다!!!
 * 
 * ?? 그렇다면 SELECT절 보다 먼저 해석되는
 * 	WHERE절에서 별칭 사용이 가능할까??? -> 안됨!!!
 * */

-- 사번, 이름, 연봉을
-- 연봉 오름차순으로 정렬(컬럼명 별칭 적용하기)
-- 연봉 오름차순으로 정렬
SELECT 
	EMP_ID AS 사번,
	EMP_NAME AS 이름,
	SALARY*12 연봉
FROM
	EMPLOYEE 
ORDER BY
	연봉 ASC; -- 별칭 이용해서 오름차순 정렬
-- SALARY *12 ASC


-- 연봉을 5천만원 이상 받는 사원의
-- 사번, 이름, 연봉 조회
-- 연봉 오름차순으로 정렬
SELECT 
	EMP_ID AS 사번,
	EMP_NAME AS 이름,
	SALARY*12 연봉
FROM
	EMPLOYEE 
WHERE 
--	연봉 >= 50000000 --> 오류발생! -> 아직 별칭 인식 전
	SALARY *12 >= 50000000
ORDER BY
	연봉 ASC; -- 별칭 이용해서 오름차순 정렬
	
	
/* 컬럼 순서를 이용하여 정렬하기
 * 
 * - SELECT절이 해석되면
 * 	조회하면서 컬럼이 지정되면서
 * 	컬럼의 순서도 같이 지정된다!
 * 
 * -> ORDER BY절에서 컬럼 순서 이용 가능 (권장 x)
 */
	
-- 급여가 400만원 이상, 600만원 이하인 사원의
-- 사번, 이름, 급여를	
-- 급여 내림차순으로 조회
SELECT 
	EMP_ID, EMP_NAME, SALARY
FROM
	EMPLOYEE 
WHERE 
	SALARY BETWEEN 4000000 AND 6000000
ORDER BY 
--	SALARY DESC;
	3 DESC;


---------------------------------------------------------

/* SELECT절에 작성되지 않은 컬럼을 이용해 정렬하기 */
-- 모든 사원의 사번, 이름을
-- 부서코드 오름차순으로 조회

SELECT
	EMP_ID, EMP_NAME
FROM
	EMPLOYEE 
ORDER BY
	DEPT_CODE  ASC; -- SELECT절에 DEPT_CODE가 포함되지 않았어도 정렬잘됨
-- ORDER BY절 해석 전
-- SELECT, FROM 절 모두 해석 되어있기 때문에
-- SELECT절에 없는 컬럼을 작성해도 정렬가능			

---------------------------------------------------------
	
	/* NULLS FIRST, NULLS LAST 확인 */
	
	SELECT
		EMP_NAME, BONUS
	FROM
	  EMPLOYEE 
	ORDER BY
		BONUS DESC NULLS LAST ;

-- 오름차순 기본값 : NULLS LAST

----------------------------------------------------------

/*  정렬 기준 "중첩" 작성
 * 
 * - 먼저 작성된 정렬을 적용하고
 * 	 그 안에서 형성된 그룹별로 정렬 진행
 * 
 * - 형성되는 그룹 == 같은 컬럼 값을 가지는 행
 */

-- EMPLOYEE 테이블에서
-- 이름, 부서코드, 급여를
-- 부서코드 오름차순, 급여 내림차순으로 정렬해서 조회
SELECT 
	EMP_NAME, DEPT_CODE, SALARY
FROM
	EMPLOYEE 
ORDER BY
	DEPT_CODE ASC, SALARY DESC; 

-- EMPLOYEE 테이블에서
-- 이름, 부서코드, 직급코드 조회
-- 부서코드 오름차순, 직급코드 내림차순, 이름 오름차순으로 정렬
-- 별칭 적용
SELECT 
	EMP_NAME 이름, DEPT_CODE 부서코드, JOB_CODE 직급코드
FROM
	EMPLOYEE 
ORDER BY
	DEPT_CODE ASC, JOB_CODE DESC , EMP_NAME ASC;







	











 




