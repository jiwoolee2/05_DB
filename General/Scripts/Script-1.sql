/* TB_USER 테이블 생성 */
CREATE TABLE TB_USER(
	USER_NO NUMBER,
	USER_ID VARCHAR2(30) NOT NULL,
	USER_PW VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30) NOT NULL,
	ENROLL_DATE DATE DEFAULT SYSDATE,
	
	CONSTRAINT TB_USER_PK PRIMARY KEY(USER_NO)

);

COMMENT ON COLUMN TB_USER.USER_NO IS '사용자 번호';
COMMENT ON COLUMN TB_USER.USER_ID IS '사용자 아이디';
COMMENT ON COLUMN TB_USER.USER_PW IS '사용자 비밀번호';
COMMENT ON COLUMN TB_USER.USER_NAME IS '사용자 이름';
COMMENT ON COLUMN TB_USER.ENROLL_DATE IS '회원 가입일';

/* 사용자 번호 생성용 시퀀스 */
CREATE SEQUENCE SEQ_USER_NO NOCACHE;

/* 샘플 데이터 2개 삽입 */
INSERT INTO TB_USER
VALUES(SEQ_USER_NO.NEXTVAL,'user01','pass01','짱구',DEFAULT );

INSERT INTO TB_USER
VALUES(SEQ_USER_NO.NEXTVAL,'user02','pass02','훈이',DEFAULT );

COMMIT;

SELECT * FROM TB_USER;


/* 입력 받은 아이디가 포함된 사용자의
 * 사용자 번호, 아이디, 이름, 가입일을
 * 회원번호 오름차순으로 조회(SELECT)
 */

SELECT USER_NO,USER_NAME,ENROLL_DATE
FROM TB_USER
WHERE USER_ID LIKE '%user'
ORDER BY USER_NO ASC;

SELECT * FROM TB_USER;


SELECT * FROM EMPLOYEE;












