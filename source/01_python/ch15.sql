-- d:/ai/source/01_python/ch15.sql
-- 테이블 생성(NAME,TEL,EMAIL,AGE,GRADE,ETC)
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    NAME    VARCHAR2(20),
    TEL     VARCHAR2(20),
    EMAIL   VARCHAR2(30) UNIQUE,
    AGE     NUMBER(3),
    GRADE   NUMBER(1),
    ETC     VARCHAR2(100)    
);
SELECT * FROM MEMBER;
-- CH15 데이터베이스연동 4절 연습문제
-- 실습형
-- -회원가입|전체조회|이름찾기|메일삭제|csv보내기|종료

-- 1번 입력
INSERT INTO MEMBER VALUES ('홍길동','010-9999-9999','H@H.COM',33,2,'까칠해');

-- 2번 전체 조회, 5번 CSV내보내기
SELECT * FROM MEMBER ORDER BY NAME;

-- 3번 이름 조회
SELECT * FROM MEMBER WHERE NAME = '홍길동';

-- 4번 메일로 삭제
DELETE FROM MEMBER WHERE EMAIL='A@A.COM';

COMMIT;
