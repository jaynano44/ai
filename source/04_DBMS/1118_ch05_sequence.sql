-- [V] Sequence : 순차번호 생성기. 대부분 인위적인 PK 사용 용도
DROP SEQUENCE FRIEND_SQ;
CREATE SEQUENCE FRIEND_SQ 
    START WITH 10      -- 101부터 생성(기본값: 1)
    INCREMENT BY -1    -- -1씩 감소(기본값: 1)
    MAXVALUE 9999      -- 최대값
    MINVALUE -9999     -- 최소값
    NOCYCLE            -- CYCLE 없이
    NOCACHE;           -- 캐시메모리를 사용 안 함
SELECT FRIEND_SQ.NEXTVAL FROM DUAL; -- NEXTVAL(순차번호생성), DUAL:오라클 제공테이블(1행1열)  
SELECT FRIEND_SQ.CURRVAL FROM DUAL; -- CURRVAL(현재까지 진행된 순차번호)


-- ex. 시퀀스를 이용한 FRIEND테이블
DROP TABLE FRIEND;
CREATE TABLE FRIEND(
    NO          NUMBER(5) PRIMARY KEY,
    NAME        VARCHAR2(30)  NOT NULL,
    TEL         VARCHAR2(20)  UNIQUE,
    ADDRESS     VARCHAR2(255),
    LAST_MODIFY DATE DEFAULT SYSDATE
);
DROP SEQUENCE FRIEND_SQ;
CREATE SEQUENCE FRIEND_SQ MAXVALUE 99999 NOCACHE NOCYCLE;
INSERT INTO FRIEND (NO,NAME,TEL,ADDRESS)
    VALUES (FRIEND_SQ.NEXTVAL,'홍길동',NULL,'신림'); -- 여러번 실행 가능
SELECT NO,NAME,TEL,ADDRESS,
    TO_CHAR(LAST_MODIFY,'RR/MM/DD AM HH:MI:SS') LAST_MODIFY
    FROM FRIEND;
INSERT INTO FRIEND
    VALUES (FRIEND_SQ.NEXTVAL,'김길동','010-9988-9999','봉천',SYSDATE); -전화번호가 UNIQUE라 한번 이상하면 에러

--<연습문제> 
--아래의 요구사항을 만족하는 데이터베이스를 설계하고, 테이블을 생성, 데이터를 입력하는 SQL문을 조건에 맞게 작성하시오.
--[제출 파일]
--ERD 캡처한 png파일(exERD.png)과  sql 작성 파일
--[요구사항]
--(1) 같은 이름의 테이블이나 시퀀스가 있을 수 있으니 먼저 삭제하고 테이블을 생성하시오
--(2) MEMBER 테이블은 필드 별로 다음의 조건을 지켜 생성하시오.
--	① mNO(번호) : 주키(시컨스 이용)
--	② mNAME(이름) : NULL값을 입력할 수 없다
--	③ mPW(비밀번호) : 반드시 1~8글자 이내의 문자를 입력한다
--      NOT NULL 8자리 /Check(length(mpw) between 1 and 8)
--	④ mEMAIL(메일) : 모든 데이터는 EMAIL 필드값이 모두 다르게 입력된다.
--	⑤ mPOINT(포인트) : 0이상의 값만 입력할 수 있다.
--	⑥ mRDATE(가입일) : 입력하지 않을 시, 기본적으로 현재날짜로 입력된다.
--⑦ LEVELNO : MEMBER_LEVEL 테이블의 LEVELNO 필드를 참조하는 외래키
--(3) MEMBER_LEVEL 테이블은 필드 별로 다음의 제약조건을 지킨다.
--	① LEVELNO : 주키
--	② LEVELNAME : NULL값을 입력할 수 없다	
--(4) MEMBER 테이블의 mNO번호는 시퀀스(MEMBER_MNO_SQ)를 생성한 뒤 자동생성 번호로 입력
-- [입력될 데이터 내용]
--[MEMBER 테이블]
--mNO mNAME  mPW  mMAIL            mPOINT  mRDATE  LEVELNO
--1     홍길동   aa     hong@hong.com      0      24/09/26     0
--2     신길동   bb     sin@sin.com        1000     22/04/01     1
--[MEMBER_LEVEL 테이블]
--LEVELNO LEVELNAME
-- -1           black
-- 0            일반
-- 1            실버
-- 2            골드
--[테스트 출력 내용]
-- mNO mNAME   mRDATE          mMAIL       point   levelname
--    1   홍길동   2022-03-10   hong@hong.com    0     일반고객
--    2   신길동   2022-04-01   sin@sin.com       1000   실버고객

DROP TABLE MEMBER;
DROP TABLE MEMBER_LEVEL;
CREATE TABLE MEMBER_LEVEL(
    LEVELNO     NUMBER(1) PRIMARY KEY,
    LEVELNAME   VARCHAR2(20)  NOT NULL
);
SELECT * FROM MEMBER_LEVEL;
CREATE TABLE MEMBER(
    mNO          NUMBER(5)    PRIMARY KEY,
    mNAME        VARCHAR2(20)  NOT NULL,
    mPW          VARCHAR2(8)   NOT NULL,
    mMAIL        VARCHAR2(30)  UNIQUE,
    mPOINT       NUMBER(9)     DEFAULT 1000 CHECK(mPOINT>=0),
    mRDATE       DATE          DEFAULT SYSDATE,
    LEVELNO      NUMBER(1) REFERENCES MEMBER_LEVEL(LEVELNO)
);
SELECT * FROM MEMBER;
DROP SEQUENCE MEMBER_MNO_SQ;
CREATE SEQUENCE MEMBER_MNO_SQ 
    START WITH 1      
    MAXVALUE 9999      
    NOCYCLE            
    NOCACHE;           

INSERT INTO MEMBER_LEVEL (LEVELNO,LEVELNAME)
        VALUES(-1,'black');
INSERT INTO MEMBER_LEVEL (LEVELNO,LEVELNAME)
        VALUES(0,'일반');
INSERT INTO MEMBER_LEVEL (LEVELNO,LEVELNAME)
        VALUES(1,'실버');
INSERT INTO MEMBER_LEVEL (LEVELNO,LEVELNAME)
        VALUES(2,'골드');
SELECT * FROM MEMBER_LEVEL; 

SELECT * FROM MEMBER;
INSERT INTO MEMBER (mNO,mNAME,mPW,mMAIL,Mpoint,mRDATE,LEVELNO)
    VALUES (MEMBER_MNO_SQ.NEXTVAL,'홍길동','aa','hong@hong.com',0,to_date('24/09/26','RR/MM/DD'),0);
INSERT INTO MEMBER (mNO,mNAME,mPW,mMAIL,Mpoint,mRDATE,LEVELNO)
    VALUES (MEMBER_MNO_SQ.NEXTVAL,'신길동','bb','sin@sin.com',1000,to_date('22/04/01','RR/MM/DD'),1);
SELECT M.mNO,M.mNAME,M.mRDATE,M.mMAIL,M.mPOINT,ML.LEVELNAME || '고객' AS LEVELNAME
        FROM MEMBER M,MEMBER_LEVEL ML
        WHERE M.LEVELNO = ML.LEVELNO;