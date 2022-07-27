--GRADE
DROP TABLE GRADE;
CREATE TABLE GRADE(
    GRADE CHAR(1) PRIMARY KEY,
    GNAME VARCHAR2(10) NOT NULL
);
INSERT 
    INTO GRADE (GRADE, GNAME)
    VALUES ('A', 'VIP');
INSERT 
    INTO GRADE (GRADE, GNAME)
    VALUES ('B', '일반');
INSERT 
    INTO GRADE (GRADE, GNAME)
    VALUES ('C', '직원');
SELECT * FROM GRADE;
COMMIT;
--MEMBER
DROP SEQUENCE MEMBER_SEQ;
CREATE SEQUENCE MEMBER_SEQ
    START WITH 1001
    NOCYCLE
    NOCACHE;
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
   CUSTNO NUMBER(6) PRIMARY KEY,
   CUSTNAME VARCHAR2(20),
   PHONE VARCHAR2(20),
   ADDRESS VARCHAR2(60),
   JOINDATE DATE,
   GRADE CHAR(1) REFERENCES GRADE,
   CITY CHAR(2)
);
INSERT 
    INTO MEMBER  (CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY) 
    VALUES (MEMBER_SEQ.NEXTVAL, '홍길동', '010-1111-2222', '서울 동대문구', TO_DATE('20220702','YYYYMMDD'), 'A', '01' );
INSERT 
    INTO MEMBER(CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY) 
    VALUES(MEMBER_SEQ.NEXTVAL, '신길동', '010-1111-3333', '서울 강남구', TO_DATE('20220601','YYYYMMDD'), 'B', '01' ); 
INSERT 
    INTO MEMBER(CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY) 
    VALUES(MEMBER_SEQ.NEXTVAL, '김길동', '010-1111-4444', '경기도 안양시', TO_DATE('20220501','YYYYMMDD'), 'B', '30' ); 
INSERT 
    INTO MEMBER(CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY) 
    VALUES(MEMBER_SEQ.NEXTVAL, '유길동', '010-1111-5555', '경기도 의정부시', TO_DATE('20220703','YYYYMMDD'), 'A', '30' ); 
INSERT 
    INTO MEMBER(CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY) 
    VALUES(MEMBER_SEQ.NEXTVAL, '정길동', '010-1111-6666', '서울시 용산구', TO_DATE('20220703','YYYYMMDD'), 'B', '60' ); 
SELECT * FROM MEMBER;
COMMIT;
--MONEY
DROP SEQUENCE MONEY_SEQ;
CREATE SEQUENCE MONEY_SEQ
    START WITH 202201
    NOCYCLE
    NOCACHE;
DROP TABLE MONEY;
CREATE TABLE MONEY(
    SALENO NUMBER(6) PRIMARY KEY,
    CUSTNO NUMBER(6) REFERENCES MEMBER NOT NULL,
    COST NUMBER(8),
    AMOUNT NUMBER(4),
    PRICE NUMBER(8),
    PCODE VARCHAR2(4),
    SDATE DATE
);
INSERT 
    INTO MONEY(SALENO, CUSTNO, COST, AMOUNT, PRICE, PCODE, SDATE)
    VALUES(MONEY_SEQ.NEXTVAL, 1001, 100, 20, 2000, 'A01', TO_DATE('20220701','YYYYMMDD'));
INSERT 
    INTO MONEY(SALENO, CUSTNO, COST, AMOUNT, PRICE, PCODE, SDATE)
    VALUES(MONEY_SEQ.NEXTVAL, 1001, 150, 20, 3000, 'A02', TO_DATE('20220701','YYYYMMDD'));
INSERT 
    INTO MONEY(SALENO, CUSTNO, COST, AMOUNT, PRICE, PCODE, SDATE)
    VALUES(MONEY_SEQ.NEXTVAL, 1002, 200, 10, 2000, 'A03', TO_DATE('20220701','YYYYMMDD'));
INSERT 
    INTO MONEY(SALENO, CUSTNO, COST, AMOUNT, PRICE, PCODE, SDATE)
    VALUES(MONEY_SEQ.NEXTVAL, 1003, 100, 5, 500, 'A01', TO_DATE('20220701','YYYYMMDD'));
INSERT 
    INTO MONEY(SALENO, CUSTNO, COST, AMOUNT, PRICE, PCODE, SDATE)
    VALUES(MONEY_SEQ.NEXTVAL, 1004, 100, 9, 900, 'A01', TO_DATE('20220702','YYYYMMDD'));
INSERT 
    INTO MONEY(SALENO, CUSTNO, COST, AMOUNT, PRICE, PCODE, SDATE)
    VALUES(MONEY_SEQ.NEXTVAL, 1003, 150, 6, 900, 'A02', TO_DATE('20220703','YYYYMMDD'));
INSERT 
    INTO MONEY(SALENO, CUSTNO, COST, AMOUNT, PRICE, PCODE, SDATE)
    VALUES(MONEY_SEQ.NEXTVAL, 1001, 200, 2, 400, 'A03', TO_DATE('20220704','YYYYMMDD'));
SELECT * FROM MONEY;
COMMIT;