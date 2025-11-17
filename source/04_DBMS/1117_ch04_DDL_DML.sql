-- [ IV ] DDL, DCL, DML
/*
(1)DCL :
    사용자 계정 생성  CREATE USER,권한부여 GRANT
    권한박탈         REVOKE, 사용자계정삭제 DROP USER
    트렌젝션 명령어 (ROLLBACK,COMMIT)
(2)DDL:
    테이블생성 CREATE TABLE, 테이블구조변경 ALTER TABLE,테이블삭제 DROP TABLE
(3)DML :CRUD
    입력 INSERT, 검색 SELECT, 수정 UPDATE, 삭제 DELETE - DML은 취소 가능 */
    
------------------------------------
----------- ★ DDL ★ ---------------
-------------------------------------
-- 1. 테이블 생성(CREATE TABLE 테이블명 ...) : 테이블의 구조를 정의
    -- ORACLE타입 : NUMBER(38이하의 자릿수),DATE, VARCHAR2(4000이하의 바이트수),CLOB(2기가까지 가능/ 대부분 웹게시판형태)
CREATE TABLE BOOK(
    BOOKID NUMBER(4),        -- BOOKID필드의 타입은 숫자4자리
    BOOKNAME CLOB,   
    PUBLISHER VARCHAR2(20),  -- BOOKNAME필드의 타입은 문자 20바이트(한글1자=3바이트)  / VARCHAR2(4000)까지만 가능
    RDATE DATE,              -- RDATE필드의 타입은 DATE형(날짜+시간)
    PRICE NUMBER(8,2),       -- PRICE필드의 타입은 숫자 전체8자리 중 소숫점 2자리
    PRIMARY KEY(BOOKID)      -- 제약조건 : BOOKID를 주키(PRIMARY KEY)필드로 생성
);
SELECT * FROM BOOK;
DESC BOOK;
-- 2. 테이블삭제(DROP TABLE 테이블명)
DROP TABLE BOOK; --  테이블삭제(DROP TABLE 테이블명)
-- PRIMARY 다른 방식
CREATE TABLE BOOK(
    BOOKID NUMBER(4) PRIMARY KEY,        -- BOOKID필드의 타입은 숫자4자리
    BOOKNAME CLOB,   
    PUBLISHER VARCHAR2(20),  -- BOOKNAME필드의 타입은 문자 20바이트(한글1자=3바이트)  / VARCHAR2(4000)까지만 가능
    RDATE DATE,              -- RDATE필드의 타입은 DATE형(날짜+시간)
    PRICE NUMBER(8,2)        -- PRICE필드의 타입은 숫자 전체8자리 중 소숫점 2자리
);
SELECT * FROM BOOK;
DESC BOOK;
SELECT * FROM EMP;
SELECT * FROM DEPT; -- 10,20,30,40 부서
INSERT INTO EMP VALUES(7369,'홍길동',NULL,NULL,NULL,NULL,NULL,40);

-- DEPT와 유사한 DEPT01생성 : DEPTNO(숫자2-PK),DNAME(문14),LOC(문13)
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);
INSERT INTO DEPT01 VALUES(10,'전산실','신림');
SELECT * FROM DEPT01;
ROLLBACK;  --DML 취소
--EMP와 유사한 EMP01생성    : EMPNO(숫자4-PK),ENAME(문10),JOB(문9),HIREDATE(날),SAL(숫7.2),DEPTNO(숫자2-FK)
CREATE TABLE EMP01(
    EMPNO    NUMBER(4) PRIMARY KEY,
    ENAME    VARCHAR2(10),
    HIREDATE DATE,
    SAL      NUMBER(7,2),   -- 소숫점앞 5자리 소수점 뒤 2자리 총 7자리
    DEPTNO   NUMBER(2) REFERENCES DEPT01(DEPTNO)  -- 외래키(FOREIGN KEY) 제약조건
);

DROP TABLE EMP01;
CREATE TABLE EMP01(
  EMPNO    NUMBER(4),
  ENAME    VARCHAR2(10),
  HIREDATE DATE,
  SAL      NUMBER(7, 2), -- 소숫점앞 5자리 소수점뒤 2자리. 총 7자리
  DEPTNO   NUMBER(2), -- 외래키(FOREIGN KEY) 제약조건
  PRIMARY KEY(EMPNO),
  FOREIGN KEY(DEPTNO) REFERENCES DEPT01(DEPTNO)
);
INSERT INTO EMP01 VALUES(1001,'홍길동',SYSDATE,9999,10);
COMMIT; -- 트랜젝션 영역에 쌓여있는 DML명령어들을 ORACLE에 일괄적용
SELECT * FROM EMP01;
ROLLBACK; -- COMMIT된 것은 ROLLBACK되지 않음.

------------------------------------
----------- ★ DML ★ ---------------
------------------------------------
--1. INSERT INTO 테이블명(필드명1,필드명2,...) VALUES(값1,값2,...);
    -- INSERT INTO 테이블명 VALUES(값1,값2,값3,..값N);
SELECT * FROM DEPT01;
INSERT INTO DEPT01 VALUES(50,'ACCOUNTING','SEOUL');
INSERT INTO DEPT01 (DEPTNO,LOC,DNAME) VALUES(60,'신림','개발');
INSERT INTO DEPT01 (DEPTNO,LOC,DNAME) VALUES(70,NULL,'영업');  -- 명시적으로 NULL입력
INSERT INTO DEPT01 (DEPTNO,DNAME) VALUES(80,'연구');           -- 묵시적으로 NULL입력
--서브쿼리를 이용한 INSERT
    -- ex. DEPT테이블의 20~40부서의 내용을 DEPT01테이블에 INSERT
    INSERT INTO DEPT01 SELECT * FROM DEPT WHERE DEPTNO>10;
    
-- ※※※ PDF 1PAGE 연습문제 ※※※
--테이블 삭제
DROP TABLE SAM01;
--테이블 생성
CREATE TABLE SAM01(
  EMPNO    NUMBER(4),
  ENAME    VARCHAR2(10),
  JOB      VARCHAR2(9),
  SAL      NUMBER(7, 2), -- 소숫점앞 5자리 소수점뒤 2자리. 총 7자리
  PRIMARY KEY(EMPNO)
);
SELECT * FROM SAM01;
-- 한행씩 INSERT
INSERT INTO SAM01 VALUES(1000,'APPLE','POLICE',10000);
INSERT INTO SAM01 VALUES(1010,'BANANA','NURSE',15000);
INSERT INTO SAM01 VALUES(1020,'ORANGE','DOCTOR',25000);
INSERT INTO SAM01 VALUES(1030,'VERY',NULL,25000););
INSERT INTO SAM01 (EMPNO,ENAME,SAL) VALUES(1040,'CAT',2000);
-- 서브쿼리(10번부서인 EMP테이블 EMPNO,ENAME,JOB,SAL내용)을 이용한 3행 INSERT
SELECT * FROM EMP;
INSERT INTO SAM01 SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=10;
-- 트랜젝션에 쌓여있는 DML 오라클에 적용시키기
COMMIT;

--2. UPDATE 테이블명 SET 필드명1=값1[,필드명2=값2,... 필드명N=값N] [WHERE 조건];
DROP TABLE EMP01;
-- 서브쿼리를 이용한 테이블 생성(제약조건 제외된 데이터만 가져옴)
CREATE TABLE EMP01 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;
SELECT * FROM EMP01;
    --EX. 부서번호를 30번으로 수정
    UPDATE EMP01 SET DEPTNO=30 ;
    SELECT * FROM EMP01;
    ROLLBACK;
    -- ex. 모든 사원(EMP01)의 급여(SAL)를 10% 인상
    UPDATE EMP01 SET SAL=SAL*1.1;
    SELECT * FROM EMP01;
    ROLLBACK;
    -- ex. EMP01 테이블의 10번 부서의 직원을 30번 부서로 
    UPDATE EMP01 SET DEPTNO=30 WHERE DEPTNO=10;
    SELECT * FROM EMP01;
    ROLLBACK;
    -- ex. SCOTT의 부서번호(20)으로,JOB은 'MANAGER'로,SAL과 COMM은 500$씩 인상.
        -- 입사일은 오늘로, 상사는 'KING'으로 수정
    UPDATE EMP SET DEPTNO=10,
                JOB='MANAGER',
                SAL=SAL+500,
                COMM=NVL(COMM,0)+500,
                -- HIREDATE = TO_DATE('25/11/17','RR/MM/DD'),
                HIREDATE = SYSDATE,   -- SYSDATE: 지금
                MGR = (SELECT EMPNO FROM EMP01 WHERE ENAME='KING')
        WHERE ENAME='SCOTT';
SELECT * FROM EMP;
    -- ex. 모든 사원의 급여와 입사일을 'KING'의 급여와 입사일로 수정
    UPDATE EMP 
        SET SAL=(SELECT SAL FROM EMP WHERE ENAME='KING'),
            HIREDATE = (SELECT HIREDATE FROM EMP WHERE ENAME='KING');
    UPDATE EMP
        SET (SAL,HIREDATE) =(SELECT SAL,HIREDATE FROM EMP WHERE ENAME='KING');
SELECT * FROM EMP;
ROLLBACK;

-- 3. DELETE FROM 테이블명 [WHERE 조건];
DELETE FROM EMP01;
SELECT * FROM EMP01;
ROLLBACK;  -- INSERT, UPDATE, DELETE만 취소 가능
DELETE FROM DEPT; -- 불가(EMP테이블의 참조된 데이터가 있어서) child record found  
SELECT * FROM EMP;
        --ex. EMP01에서 'FORD'직원 퇴사
        DELETE FROM EMP01 WHERE ENAME='FORD';
        -- ex. EMP01에서 30번 부서 직원을 삭제
        DELETE FROM EMP01 WHERE DEPTNO=30;
        SELECT * FROM EMP01;
        -- ex. 부서명이 RESEARCH 부서인 직원을 삭제
        DELETE FROM EMP01 WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='RESEARCH');
        -- ex. SAM01테이블에서 JOB이 정해지지않은 사원 삭제
        SELECT * FROM SAM01;
        DELETE FROM SAM01 WHERE JOB IS  NULL;
        -- ex. SAM01테이블에서 이름이 ORANGE인 데이터 삭제
        DELETE FROM SAM01 WHERE ENAME = 'ORANGE';
       
-- ※※※ PDF 2~3PAGE(교안9PAGE) 연습문제 ※※※ 
-- DDL, DML 연습문제 page2
-- 1.아래의 구조를 만족하는 MY_DATA 테이블을 생성하시오 . 단 ID 가 PRIMARY KEY 이다
SELECT * FROM MY_DATA;
DROP TABLE MY_DATA;
CREATE TABLE MY_DATA(
  ID    NUMBER(4),
  NAME    VARCHAR2(10),
  USERID      VARCHAR2(30),
  SALARY     NUMBER(10, 2), -- 소숫점앞 5자리 소수점뒤 2자리. 총 7자리
  PRIMARY KEY(ID)
);
-- 2. 생성된 테이블에 위의 도표와 같은 값을 입력하는 SQL 문을 작성하시오
INSERT INTO MY_DATA VALUES(1,'Scott','sscott',10000.00);
INSERT INTO MY_DATA VALUES(2,'Ford','fford',13000.00);
INSERT INTO MY_DATA VALUES(3,'Patel','ppatel',33000.00);
INSERT INTO MY_DATA VALUES(4,'Report','rreport',23500.00);
INSERT INTO MY_DATA VALUES(5,'Good','ggood',44450.00);
SELECT * FROM MY_DATA;
-- 3. TO_CHAR 내장 함수를 이용하여 입력한 자료를 위의 도표와 같은 형식으로 출력하는 SQL 문을 작성하시오
SELECT ID,NAME,USERID,TO_CHAR(SALARY,'99,999,999.99') FROM MY_DATA;
-- 4.자료를 영구적으로 데이터베이스에 등록하는 명령어를 작성하시오
COMMIT;
-- 5.ID 가 3 번인 사람의 급여를 65000.00 으로 갱신하고 영구적으로 데이터베이스에 반영하라
UPDATE MY_DATA SET SALARY=65000.00 
    WHERE ID=3;
    COMMIT;
-- 6.NAME 이 Ford 인 사람을 삭제하고 영구적으로 데이터베이스에 반영하라
DELETE FROM MY_DATA WHERE NAME='Ford';
COMMIT;
--7.SALARY 가 15,000.00 이하인 사람의 급여를 15,000.00 으로 변경하라
UPDATE MY_DATA SET SALARY = 15000.00 WHERE SALARY <= 15000.00;
COMMIT;
SELECT * FROM MY_DATA;
--8.위에서 생성한 테이블을 삭제하라
DROP TABLE MY_DATA;
SELECT * FROM MY_DATA;

-- DML 연습문제 page3
--1. EMP 테이블과 같은 구조와 같은 내용의 테이블 EMP01 을 생성 테이블이 있을시 제거한 후 하고 ,모든 사원의 부서번호를 30 번으로 수정합니다
SELECT * FROM EMP01;
DROP TABLE EMP01;
COMMIT;
SELECT * FROM EMP;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
UPDATE EMP01 SET DEPTNO=30;
SELECT * FROM EMP01;

--2. EMP01 테이블의 모든 사원의 급여를 10% 인상시키는 UPDATE 문을 작성
UPDATE EMP01 SET SAL=SAL*1.1;
--3. 급여가 3000 이상인 사원만 급여를 10% 인상
UPDATE EMP01 SET SAL=SAL*1.1 WHERE SAL>=3000;
--4. EMP01 테이블에서 ‘DALLAS' 에서 근무하는 직원들의 월급 을 1000 인상
UPDATE EMP01 
    SET SAL=SAL+1000 
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS');
SELECT * FROM EMP01;
--5. SCOTT 사원의 부서번호는 20 번으로 , 직급은 MANAGER 로 한꺼번에 수정
UPDATE EMP01 SET DEPTNO=20, JOB='MANAGER' WHERE ENAME='SCOTT';
--6. 부서명이 SALES 인 사원을 모두 삭 제하는 SQL 작성
SELECT * FROM DEPT;
DELETE FROM EMP01 WHERE DEPTNO =(SELECT  DEPTNO FROM DEPT WHERE DNAME='SALES');
ROLLBACK;
--7. 사원명이 ‘FORD‘ 인 사원을 삭제하는 SQL 작성
SELECT * FROM EMP01;
DELETE FROM EMP01 WHERE ENAME='FORD';
--8. SAM01 테이블에서 JOB 이 NULL 인 사원을 삭제하시오
SELECT * FROM SAM01;
DELETE FROM SAM01 WHERE JOB IS NULL;
--9. SAM01 테이블에서 ENAME 이 ORANGE 인 사원을 삭제하시오
DELETE FROM SAM01 WHERE ENAME='ORANGE';
--10. 급여가 1500 이하인 사람의 급여를 1500 으로 수정
UPDATE EMP01 SET SAL=1500 WHERE SAL<=1500;
SELECT * FROM EMP01;
--11. JOB 이 ‘MANAGER' 인 사원의 급여를 10% 인하하시오
UPDATE EMP01 SET SAL=SAL*0.9 WHERE JOB='MANAGER';
SELECT * FROM EMP01;


-- ★★★ 제약조건
-- (1) PRIMARY KEY : 테이블의 각 행을 유일한 값으로 식별하기 위한 필드
-- (2) FOREIGN KEY : 테이블의 열이 다른 테이블의 열을 참조
-- (3) NOT NULL    : NULL을 포함하지 않는다.
-- (4) UNIQUE      : 모든 행의 값이 유일해야. NULL값은 허용(NULL은 여러개 가능)
-- (5) CHECK(조건)  : 해당 조건이 만족(NULL값 허용)
-- DEFAULT 기본값 : 기본값 설정(해당 열의 데이터를 입력하지 않고 INSERT하면 NULL이 들어갈 것을 DEFAULT 값이 들어가도록)

-- DEPT1 & EMP1 테이블 생성
CREATE TABLE DEPT1(   -- 제약 조건을 옆에 기술 / NOT NULL은 오른쪽에만 가능
    DEPTNO NUMBER(2)    PRIMARY KEY,
    DNAME  VARCHAR2(14) NOT NULL  UNIQUE,
    LOC    VARCHAR2(14) NOT NULL
);

CREATE TABLE EMP1(    -- 제약조건을 옆에 기술
    EMPNO    NUMBER(4)      PRIMARY KEY,
    ENAME    VARCHAR2(20)   NOT NULL,
    JOB      VARCHAR2(20)   NOT NULL,
    MGR      NUMBER(4),
    HIREDATE DATE           DEFAULT SYSDATE,
    SAL      NUMBER(7,2)    CHECK(SAL>0),
    COMM     NUMBER(7,2),
    DEPTNO   NUMBER(7,2)    REFERENCES DEPT1(DEPTNO)    
);
SELECT * FROM DEPT1;
SELECT * FROM EMP1;

-- 두 테이블 삭제 후 제약조건을 아래에 기술
DROP TABLE DEPT1; --참조하는 것이 잇으면 안지워짐. 
DROP TABLE EMP1;
DROP TABLE DEPT1;
SELECT * FROM DEPT1;
SELECT * FROM EMP1;
CREATE TABLE DEPT1(   -- 제약 조건을 아래에 기술 / NOT NULL은 오른쪽에만 가능
    DEPTNO NUMBER(2),
    DNAME  VARCHAR2(14) NOT NULL,
    LOC    VARCHAR2(14) NOT NULL,
    PRIMARY KEY(DEPTNO),
    UNIQUE(DNAME)
);
CREATE TABLE EMP1(    -- 제약조건을 아래에 기술
    EMPNO    NUMBER(4),
    ENAME    VARCHAR2(20)   NOT NULL,
    JOB      VARCHAR2(20)   NOT NULL,
    MGR      NUMBER(4),
    HIREDATE DATE           DEFAULT SYSDATE,
    SAL      NUMBER(7,2),
    COMM     NUMBER(7,2),
    DEPTNO   NUMBER(2),     
    PRIMARY KEY(EMPNO),
    CHECK(SAL>0),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT1(DEPTNO)   
);

SELECT * FROM DEPT1;
SELECT * FROM EMP1;
INSERT INTO DEPT1 SELECT * FROM DEPT;
INSERT INTO DEPT1 VALUES(50,'SALES','서울');  -- UNIQUE에러
INSERT INTO DEPT1 (DEPTNO,DNAME) VALUES(50,'전산'); -- NOT NULL 에러(LOC은 NOT NULL)
INSERT INTO EMP1 (EMPNO,ENAME,JOB,DEPTNO) VALUES(9001,'HONG','MANAGER',40);
-- INSERT에서 언급되지 않은 필드는 DEFAULT값이나 NULL값 입력.
SELECT * FROM EMP1;
INSERT INTO EMP1 (EMPNO,ENAME,JOB,SAL) VALUES(9002,'KIM','MANAGER',-90); --CHECK 에러
INSERT INTO EMP1 (EMPNO,ENAME,JOB,SAL) VALUES(9002,'KIM','MANAGER',90);

--  연습문제 page4
--테이블을 삭제 후 생성하고 , 데이터를 입력한 후 , 아래 조건에 맞게 출력하는 sql 문을 작성하시오
--student.exerd 와 sql 소스
--STUDENT : SCORE 은 0 점 이상 100 점 이하
DROP TABLE STUDENT;
DROP TABLE MAJOR;
SELECT * FROM MAJOR;
SELECT * FROM STUDENT;

CREATE TABLE MAJOR( 
    mCODE      NUMBER(2)    PRIMARY KEY,
    mNAME      VARCHAR2(20) NOT NULL  UNIQUE,
    mOFFICE    VARCHAR2(20) NOT NULL
);

CREATE TABLE STUDENT(    -- 제약조건을 옆에 기술
    sNO      NUMBER(4)      PRIMARY KEY,
    sNAME    VARCHAR2(14),
    sSCORE   NUMBER(3)    CHECK(sSCORE BETWEEN 0 AND 100),
    mCODE     NUMBER(2)    REFERENCES MAJOR(mCODE)    
);
INSERT INTO MAJOR (mCODE,mNAME,mOFFICE) VALUES(1,'컴퓨터공학','A101호');
INSERT INTO MAJOR (mCODE,mNAME,mOFFICE) VALUES(2,'빅데이터','A102호');

INSERT INTO STUDENT (sNO,sNAME,sSCORE,mCODE) VALUES(101,'홍길동',99,1);
INSERT INTO STUDENT (sNO,sNAME,sSCORE,mCODE) VALUES(102,'신길동',100,2);
-- 출력
SELECT
    S.sNO AS 학번,          
    S.sNAME AS 이름,        
    S.sSCORE AS 점수,       
    M.mCODE AS 학과코드,    
    M.mNAME AS 학과명,      
    M.mOFFICE AS 학과사무실 
    FROM STUDENT S,MAJOR M               
    WHERE S.mCODE = M.mCODE; 