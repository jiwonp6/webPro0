DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER(
    ID VARCHAR2(50) PRIMARY KEY,
    PW VARCHAR2(50) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    TEL VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(50),
    ADDRESS VARCHAR2(250),
    GENDER VARCHAR2(10) NOT NULL,
    BIRTH DATE NOT NULL,
    RDATE DATE DEFAULT SYSDATE NOT NULL
);
SELECT * FROM CUSTOMER;
-- 1. 회원가입시 id중복체크
SELECT * FROM CUSTOMER WHERE ID = 'AAA';
-- 2. 회원가입
INSERT INTO CUSTOMER (ID, PW, NAME, TEL, EMAIL, ADDRESS, GENDER, BIRTH, RDATE)
    VALUES ('AAA', '1', '에이', '010-8888-8888', 'AAA@A.COM', '서울시 강남구', 'm', '1995-08-08', SYSDATE);
-- 3. 로그인
SELECT ID, PW FROM CUSTOMER WHERE ID = 'AAA';
-- 4. ID로 dto가져오기
SELECT * FROM CUSTOMER WHERE ID = 'AAA';
-- 5. 회원정보 수정
UPDATE CUSTOMER 
    SET PW='111', 
        NAME='에잇', 
        TEL='010-8888-8888', 
        EMAIL='MAIL@MAIL.COM', 
        ADDRESS='서울 강남', 
        GENDER='w', 
        BIRTH='1999-08-08' 
    WHERE ID = 'AAA'; 
SELECT * FROM CUSTOMER;
COMMIT;