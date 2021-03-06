<<<<<<< HEAD
--[VII] DDL, DML, DCL
--SQL = DDL(테이블 생성, 테이블 삭제, 테이블 구조변경, 테이블 모든 데이터 제거)
--      DML(SELECT(데이터 검색), INSERT(데이터 추가), UPDATE(데이터 수정), DELETE(데이터 삭제))
--      DCL(사용자계정생성, 사용자권한부여, 권한박탈, 사용자계정삭제, 트랜잭션 명령어 = ROLLBACK, COMMIT)

--☆1.DDL
--1) 테이블 생성(CREATE TABLE)
CREATE TABLE BOOK(
    BOOKID NUMBER(4),           --도서번호
    BOOKNAME VARCHAR2(300),     --책이름(BYTE)
    PUBLISHER VARCHAR2(300),    --출판사
    RDATE DATE,                 --출판일
    PRICE NUMBER(8),            --가격
    PRIMARY KEY(BOOKID) );      --BOOKID는 유일해야 하므로

SELECT * FROM BOOK;
DROP TABLE BOOK;    --테이블 삭제

CREATE TABLE book(
    bookid NUMBER(4) PRIMARY KEY,
    bookname VARCHAR2(20),
    publisher VARCHAR2(20),
    rdate DATE,
    price NUMBER(8) );
SELECT * FROM BOOK;
SELECT ROWNUM, EMPNO, ENAME FROM EMP;   --ROWNUM : 테이블에서 읽어들인 논리적 순서
SELECT ROWNUM, EMPNO, ENAME FROM EMP WHERE DEPTNO = 20 ORDER BY ENAME;
--EMP 테이블과 유사한 EMP01 : EMPNO(숫자4), ENAME(문자20), SAL(숫자7,2)
CREATE TABLE EMP01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    SAL NUMBER(7,2)
);
DESC EMP01;
--DEPT와 유사한 DEPT01 : DEPTNO(숫자2, PK), DNAME(문자14), LOC(문자13)
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13),
    PRIMARY KEY(DEPTNO)
);
DESC DEPT01;
DESC DEPT;
--서브쿼리
SELECT * FROM TAB;  --SCOTT이 생성한 테이블 LIST
SELECT * FROM EMP;

CREATE TABLE EMP02
    AS
    SELECT * FROM EMP;  --서브쿼리 결과만 EMP02테이블 생성 후 들어감(제약조건은 미포함)
SELECT * FROM EMP02;
DESC EMP02; --제약조건 미포함
    --EX.EMP03: EMP테이블에서 EMPNO, ENAME, DEPTNO만 추출한 데이터로 테이블
CREATE TABLE EMP03
    AS
    SELECT EMPNO, ENAME, DEPTNO FROM EMP;
SELECT * FROM EMP03;
    --EX.EMP04: EMP테이블에서 10번 부서만 추출한 데이터로 테이블
CREATE TABLE EMP04 
    AS
    SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP04;
    --EX.EMP05: EMP 테이블 구조(필드와 그의 타입)만 추출
CREATE TABLE EMP05
    AS
    SELECT * FROM EMP WHERE 1=0;    -- WHERE절에 반드시 거짓인것 넣음! ->모든것이 안나옴!
SELECT * FROM EMP05;
--2) 테이블 구조변경(ALTER TABLE)
--ALTER TABLE 테이블명 ADD || MODIFY || DROP ~
--(1) 필드 추가(ADD) : 추가된 필드의 데이터는 NULL
SELECT * FROM EMP03;    --EMPNO, ENAME, DEPTNO
ALTER TABLE EMP03 ADD(JOB VARCHAR2(20), SAL NUMBER(7,2));
SELECT * FROM EMP03;
ALTER TABLE EMP03 ADD (COMM NUMBER(7, 2));
--(2) 필드 수정(MODIFY)
SELECT * FROM EMP03;    --EMPNO(숫4), ENAME(문10), DEPTNO(숫2)/ JOB(문20), SAL, COMM(숫7,2)는 데이터 NULL
ALTER TABLE EMP03 MODIFY (EMPNO VARCHAR2(4));   --숫자 데이터가 들어 있는 상태에서는 숫자로만 변경 가능
ALTER TABLE EMP03 MODIFY (EMPNO NUMBER(3)); --에러 줄이는건 불가
ALTER TABLE EMP03 MODIFY (EMPNO NUMBER(5)); --가능 늘이는건 가능
ALTER TABLE EMP03 MODIFY (ENAME NUMBER(4)); --문자 데이터가 들어 있는 상태에서는 문자로만 변경 가능
SELECT MAX(LENGTH(ENAME)) FROM EMP;
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(30));
DESC EMP03;
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(6));   --이미 존재하는 이름중 6글자가 최대(데이터가 없다면 줄이는거 가능)
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(5)); --그래서 5글자로 줄이는 건 불가능
ALTER TABLE EMP03 MODIFY ( JOB NUMBER(4));
--(3) 필드 삭제(DROP)
ALTER TABLE EMP03 DROP COLUMN JOB;
DESC EMP03;
--논리적으로 특정 필드를 접근 못하도록(낮)
ALTER TABLE EMP03 SET UNUSED (DEPTNO);
SELECT * FROM EMP03;
--논리적으로 접근 불가했던 필드를 물리적으로 삭제(새벽)
ALTER TABLE EMP03 DROP UNUSED COLUMNS;

--3)테이블 삭제(DROP TABLE)
DROP TABLE EMP01;
DROP TABLE DEPT;    --다른 테이블에서 해당 테이블을 참조하여 사용하고 있는 경우 DROP 불가
SELECT * FROM EMP;

--4)테이블의 모든 행을 제거(TRUNCATE)
SELECT * FROM EMP03;
TRUNCATE TABLE EMP03;   --EMP03안의 데이터 제거 (취소불가)
SELECT * FROM EMP03;

--5)테이블명 변경(RENAME 원래이름 TO 새이름)
SELECT * FROM EMP02;
RENAME EMP02 TO EMP2;
SELECT * FROM EMP2;
--6)데이터 딕셔너리(접근 불가) VS. 데이터 딕셔너리 뷰(사용자 접근용)
--종류
--USER_XXX : 현 계정이 소유하고 있는 객체(테이블, 인덱스, 제약조건, 뷰)
    --EX.USER_TABLES, USER_INDEXES, USER_CONSTRAINTS, USER_VIEWS
--ALL_XXX : 현 계정이 접근 가능한 객체(테이블, 인덱스, 제약조건, 뷰)
    --EX.ALL_TABLES, ALL_INDEXES, ALL_CONSTRAINTS, ALL_VIEWS
--DBA_XXX : DBA권한자만 접근 가능, DBMS의 모든 객체
    --EX.DBA_TABLES, DBA_INDEXES, DBA_CONSTRAINTS, DBA_VIEWS
    
SELECT * FROM USER_TABLES;  --내 계정이 소유한 테이블 객체 정보
SELECT * FROM USER_INDEXES; --내 계정이 소유한 인덱스 정보
SELECT * FROM USER_CONSTRAINTS; --내 계정이 소유한 제약조건들
SELECT * FROM USER_VIEWS;   --내 계정이 소유한 뷰 정보

SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_INDEXES;
SELECT * FROM ALL_CONSTRAINTS;
SELECT * FROM ALL_VIEWS;

SELECT * FROM DBA_TABLES;
SELECT * FROM DBA_INDEXES;
SELECT * FROM DBA_CONSTRAINTS;
SELECT * FROM DBA_VIEWS;

--DCL(사용자계정생성, 사용자권한부여, 권한박탈, 사용자계정삭제)
CREATE USER scott2 IDENTIFIED BY 1234;  --scott2 계정생성
--권한부여(세션권한, scott.EMP, scott.DEPT 테이블에 대해 모든 권한)
GRANT CREATE SESSION TO scott2;     --scott2에게 로그인 권한 부여
GRANT ALL ON EMP TO scott2; --EMP테이블에 대한 모든 권한(검색, 추가, 수정, 삭제)
GRANT ALL ON DEPT TO scott2;    --DEPT테이블에 대한 모든 권한
show user;
--권한박탈(권한박탈할 사용자계정이 접속해제)
REVOKE ALL ON EMP FROM scott2;  --scott2의 EMP 테이블에 대한 모든 권한 박탈
REVOKE ALL ON DEPT FROM scott2;
show user;
--사용자계정 삭제(접속 중인 계정 삭제 불가)
DROP USER scott2 CASCADE;

--DML(SELECT, INSERT, UPDATE, DELETE)
--1.INSERT INTO 테이블명 VALUES(값1, 값2, 값3, ...);
--  INSERT INTO 테이블명 (필드명1, 필드명2,...) VALUES (값1, 값2,...);
SELECT * FROM DEPT01;
INSERT INTO DEPT01 VALUES (50, 'ACCOUNTIN', 'NEWYORK');
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC) VALUES (60, 'IT', 'SEOUL');
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES (70, 'OPERATION');    --묵시적으로 LOC에 NULL로 추가
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC) VALUES (80, 'HR', NULL);    --명시적으로 NULL추가
INSERT INTO DEPT01 VALUES (90, 'SALES', NULL);--명시적으로 NULL추가
--서브쿼리를 이용한 INSERT
INSERT INTO DEPT01 SELECT * FROM DEPT;
--트랜잭션 명령어(DML명령어만 트랜잭션에서 데이터 베이스에 진짜 적용 -> ROLLBACK으로 삭제 불가능)
COMMIT; 


--2. UPDATE 테이블명 SET 필드명1 = 값1 [ ,필드명2=값2, ...] [WHERE 조건];
DROP TABLE EMP01;
SELECT * FROM EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
--EMP01 테이블의 부서번호를 30으로 수정(WHERE 절 없이는 모든 행이 수정)
UPDATE EMP01 SET DEPTNO = 30;
SELECT * FROM EMP01;
ROLLBACK;   --트랜잭션 취소(DML만 취소 가능)
SELECT * FROM EMP01;

--EX. EMP01 테이블의 모든 사원의 급여 10%인상
UPDATE EMP01 
    SET SAL = SAL*1.1;
SELECT * FROM EMP01;
--EX. 10번 부서의 직원의 입사일을 오늘로, 부서번호는 30번으로 수정
UPDATE EMP01 
    SET HIREDATE = SYSDATE,
        DEPTNO = 30
    WHERE DEPTNO=10;
SELECT * FROM EMP01;
--EX. SAL>=3000인 직원만 급여 10%인상
UPDATE EMP01
    SET SAL = SAL*1.1
    WHERE SAL>=3000;
SELECT * FROM EMP01;
--EX.'DALLAS'에 근무하는 직원의 급여를 1000$씩 인상(서브쿼리 이용)
UPDATE EMP01 SET SAL = SAL + 1000
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
SELECT * FROM EMP01;
--EX.SCOTT의 부서번호를 20으로, JOB을 MANAGER로, SAL과 COMM을 500씩 인상, 상사를 KING으로 수정
UPDATE EMP01 
    SET DEPTNO = 20,
        JOB = 'MANAGER',
        SAL = SAL+500,
        COMM = NVL(COMM,0) + 500,
        MGR = (SELECT EMPNO FROM EMP WHERE ENAME = 'KING')
    WHERE ENAME = 'SCOTT';
SELECT * FROM EMP01;
--EX.DEPT01에서 20부터의 지역명을 DEPT테이블의 60번 부서의 지역명으로 변경
SELECT * FROM DEPT01;
UPDATE DEPT01
    SET LOC = (SELECT LOC FROM DEPT WHERE DEPTNO = 60)  --DEPTNO=60인게 없어서 DEPT01의 LOC가 NULL값으로 바뀜
    WHERE DEPTNO >= 20;
--EX.EMP01테이블의 모든 사원의 급여와 입사일을 'KING'의 급여와 입사일로 수정
UPDATE EMP01
    SET (SAL, HIREDATE) = (SELECT SAL, HIREDATE FROM EMP WHERE ENAME = 'KING'); 
ROLLBACK;
UPDATE EMP01
    SET SAL = (SELECT SAL FROM EMP WHERE ENAME = 'KING'),
        HIREDATE = (SELECT HIREDATE FROM EMP WHERE ENAME = 'KING'); 
SELECT * FROM EMP01;
--EX.DEPT01 테이블의 20번 부서의 지역명과 부서명을 40번 부서의 지역명과 부서명으로 변경
UPDATE DEPT01
    SET (LOC, DNAME) = (SELECT LOC, DNAME FROM DEPT01 WHERE DEPTNO = 40)
    WHERE DEPTNO = 20;
COMMIT;
SELECT * FROM DEPT01;    

--3. DELETE FROM 테이블명 (WHERE 조건);   --ROLLBACK가능!
SELECT * FROM EMP01;    --WHERE절을 안쓸경우 전체행이 모두 삭제됨(취소 가능)
DELETE FROM EMP01;
ROLLBACK;
--EX.EMP01 테이블에서 'FORD'인 사원을 삭제
DELETE 
    FROM EMP01
    WHERE ENAME = 'FORD';
--EX.EMP01테이블에서 30번 부서 직원을 삭제
DELETE
    FROM EMP01
    WHERE DEPTNO = 30;
--EX.EMP01테이블에서 부서명이 'RESEARCH'부서의 직원을 삭제
DELETE
    FROM EMP01
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'RESEARCH');
--★연습문제1    
CREATE TABLE SAM01(
    EMPNO NUMBER(4),     
    ENAME VARCHAR2(10),  
    JOB VARCHAR2(9), 
    SAL NUMBER(7,2),
    PRIMARY KEY(EMPNO) ); 
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1000, 'APPLE', 'POLICE', 10000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1010, 'BANANA', 'NURSE', 15000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1020, 'ORANGE', 'DOCTOR', 10000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1030, 'VERY', NULL, 10000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1040, 'CAT', NULL, 10000);
INSERT INTO SAM01 SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE DEPTNO='10';
COMMIT;

--SAM01 테이블에서 JOB이 정해지지 않은 사원을 삭제
SELECT * FROM SAM01;
DELETE FROM SAM01 WHERE JOB IS NULL;
ROLLBACK;
--SAM01테이블에서 ENAME이 ORANGE인 사원을 삭제하시오
DELETE
    FROM SAM01
    WHERE ENAME = 'ORANGE';

--★연습문제2
--아럐의 구조를 만족하는 MY_DATA 테이블을 생성하시오. 단 ID가 PRIMARY KEY이다.
CREATE TABLE MY_DATA(
    ID NUMBER(4),     
    NAME VARCHAR2(10),  
    USERID VARCHAR2(30), 
    SALARY NUMBER(10,2),
    PRIMARY KEY(ID) ); 
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (1, 'Scott', 'sscott', 10000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (2, 'Ford', 'fford', 13000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (3, 'Patel', 'ppatel', 33000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (4, 'Report', 'rreport', 23500.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (5, 'Good', 'ggood', 44450.00);
SELECT * FROM MY_DATA;
ROLLBACK;
SELECT ID, NAME, USERID, TO_CHAR(SALARY, '99,999')
    FROM MY_DATA
    ORDER BY ID;
COMMIT;
UPDATE MY_DATA
    SET SALARY = 65000.00
    WHERE ID = 3;
COMMIT;
DELETE
    FROM MY_DATA
    WHERE NAME = 'Ford';
COMMIT;
UPDATE MY_DATA
    SET SALARY = 15000.00
    WHERE SALARY <= 15000.00;
    
DROP TABLE MY_DATA;

--★★★제약조건 : 부적합한 데이터가 테이블에 삽입, 수정되는 것을 방지하기 위해
SELECT * FROM EMP;
INSERT INTO EMP VALUES('NULL', '홍', NULL, NULL, SYSDATE,  NULL, NULL, 40);  --SMITH 사번과 중복 에러
UPDATE EMP SET EMPNO =7369 WHERE ENAME = 'ALLEN';   --SMITH 사번과 중복 에러
--(1) PRIMARY KEY : 유일하게 테이블의 각 행을 식별. NOT NULL
    INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (7369,  '홍', 40); --중복된 사번 입력 불가(에러남)
--(2) NOT NULL : NULL값을 포함하지 않음
--(3) UNIQUE : 모든 행에 대해  유일해야. NULL값을 허용(NULL은 여러행 입력 가능)
--(4) FOREIGN KEY : 테이블의 열은 다른 테이블의 열을 참조(EX. EMP테이블의 DEPTNO는 DEPT 테이블의 DEPTNO를 참조)
    --비식별관계 : 부모테이블의 주키가 자식테이블의 일반속성에 속한 필드로 관계(exERD에서 빨간점선화살표)
    --식별관계 : 부모테이블의 주키가 자식테이블의 주키(주키군)에 속한 필드로 관계(exERD에서 초록점선화살표)
    INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (1111,  '홍', 90); -- 외래키로 90번 입력 불가(에러남)
--(5) CHECHK(조건) : 해당조건이 만족 (NULL값 허용)
--DEFAULT : 해당 열의 데이터 입력값이 없으면 NULL값 대신에 (기본값을 설정하면) 기본값이 들어감 
DROP TABLE DEPT1;
CREATE TABLE DEPT1(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14) UNIQUE,
    LOC VARCHAR2(13) NOT NULL);
DROT TABLE EMP1;
CREATE TABLE EMP1(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL NUMBER(7, 2) CHECK(SAL>0),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2) REFERENCES DEPT1(DEPTNO));     --REFERENCES : DEPT1 테이블을 참조하는 EMP1 테이블
DROP TABLE EMP1;    --자식테이블(참조하는
DROP TABLE DEPT1;

DROP TABLE DEPT1 CASCADE CONSTRAINTS; --비추긴함... (참조하는 테이블이 있어도 무시하고 DROP)

CREATE TABLE DEPT1(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13) NOT NULL,
    PRIMARY KEY (DEPTNO),
    UNIQUE(DNAME));
CREATE TABLE EMP1(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(20),
    PRIMARY KEY(EMPNO),
    CHECK (SAL>0),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT1(DEPTNO));
SELECT * FROM DEPT1;
INSERT INTO DEPT1 SELECT * FROM DEPT;
INSERT INTO DEPT1 VALUES(40, 'IT', 'SEOUL');--PK위배
INSERT INTO DEPT1 VALUES(50, 'SALES', 'SEOUL');--UINQUE 위배
INSERT INTO DEPT1 VALUES(50, 'IT', NULL); -- NOT NULL위배

INSERT INTO EMP1(EMPNO, ENAME, DEPTNO)
    VALUES(1001, '홍', 10);
SELECT * FROM EMP1; --HIREDATE에 설정된 기본값 입력
INSERT INTO EMP1 (EMPNO, ENAME, DEPTNO)
    VALUES(1001, '김', 10);  --PK 위배
INSERT INTO EMP1 (EMPNO, DEPTNO)
    VALUES(1002, 20);   --ENAME인 NOT NULL 위배
INSERT INTO EMP1 (EMPNO, ENAME, SAL, DEPTNO)
    VALUES (1002, '박', -1); --SAL>0 위배
INSERT INTO EMP1 VALUES(1002, '윤', NULL, NULL, TO_DATE('95/01/01', 'YY//MM/DD'), 900, NULL, 99);--FK 위배

--연습문제
--EX1.
DROP TABLE BOOKCATEGORY;
CREATE TABLE BOOKCATEGORY(
    CATEGORY_CODE NUMBER(3) PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(50) UNIQUE,
    OFFICE_LOC VARCHAR2(50) NOT NULL
);
DROP TABLE BOOK;
CREATE TABLE BOOK(
    CATEGORY_CODE NUMBER(4) REFERENCES BOOKCATEGORY(CATEGORY_CODE),
    bookNO VARCHAR2(10) PRIMARY KEY,
    bookNAME VARCHAR2(50),
    PUBLISHER VARCHAR2(50),
    PUBYEAR NUMBER(4) DEFAULT EXTRACT(YEAR FROM SYSDATE)
     );
INSERT INTO BOOKCATEGORY VALUES ( 100, '철학', '3층 인문실');
INSERT INTO BOOKCATEGORY VALUES ( 200, '인문', '3층 인문실');
INSERT INTO BOOKCATEGORY VALUES ( 300, '자연과학', '4층 과학실');
INSERT INTO BOOKCATEGORY VALUES ( 400, 'IT', '4층 과학실');
SELECT * FROM BOOKCATEGORY;

INSERT INTO BOOK (CATEGORY_CODE, bookNO, bookNAME, PUBLISHER) 
    VALUES ( 100, '100A01', '철학자의 삶', '더존출판');
INSERT INTO BOOK (CATEGORY_CODE, bookNO, bookNAME, PUBLISHER) 
    VALUES ( 400, '400A01', '이것이 DB다', '더존출판');
SELECT * FROM BOOK;

--연습문제
--EX2.
DROP TABLE MAJOR;
CREATE TABLE MAJOR(
    MAJOR_CODE NUMBER(3) PRIMARY KEY,
    MAJOR_NAME VARCHAR2(50) UNIQUE,
    MAJOR_OFFICE_LOC VARCHAR2(50) NOT NULL
);
DROP TABLE STUDENT;
CREATE TABLE STUDENT(
    student_code VARCHAR2(50) PRIMARY KEY,
    student_NAME VARCHAR2(50) NOT NULL,
    SCORE NUMBER(4) CHECK(SCORE>=0 AND SCORE<=100),
    MAJOR_CODE NUMBER(3) REFERENCES MAJOR(MAJOR_CODE)
);
INSERT INTO MAJOR VALUES ( 1, '경영정보', '경영관 305호');
INSERT INTO MAJOR VALUES ( 2, '소프트웨어공학', '정보관 808호');
INSERT INTO MAJOR VALUES ( 3, '디자인', '예술관 606호');
INSERT INTO MAJOR VALUES ( 4, '경제', '경상관 202호');
SELECT * FROM MAJOR;

INSERT INTO STUDENT VALUES ( 'A01', '김길동', 100, 1);
INSERT INTO STUDENT VALUES ( 'A02', '문길동', 90, 2);
INSERT INTO STUDENT VALUES ( 'A03', '홍길동', 95, 1);
SELECT * FROM STUDENT;














=======
--[VII] DDL, DML, DCL
--SQL = DDL(테이블 생성, 테이블 삭제, 테이블 구조변경, 테이블 모든 데이터 제거)
--      DML(SELECT(데이터 검색), INSERT(데이터 추가), UPDATE(데이터 수정), DELETE(데이터 삭제))
--      DCL(사용자계정생성, 사용자권한부여, 권한박탈, 사용자계정삭제, 트랜잭션 명령어 = ROLLBACK, COMMIT)

--☆1.DDL
--1) 테이블 생성(CREATE TABLE)
CREATE TABLE BOOK(
    BOOKID NUMBER(4),           --도서번호
    BOOKNAME VARCHAR2(300),     --책이름(BYTE)
    PUBLISHER VARCHAR2(300),    --출판사
    RDATE DATE,                 --출판일
    PRICE NUMBER(8),            --가격
    PRIMARY KEY(BOOKID) );      --BOOKID는 유일해야 하므로

SELECT * FROM BOOK;
DROP TABLE BOOK;    --테이블 삭제

CREATE TABLE book(
    bookid NUMBER(4) PRIMARY KEY,
    bookname VARCHAR2(20),
    publisher VARCHAR2(20),
    rdate DATE,
    price NUMBER(8) );
SELECT * FROM BOOK;
SELECT ROWNUM, EMPNO, ENAME FROM EMP;   --ROWNUM : 테이블에서 읽어들인 논리적 순서
SELECT ROWNUM, EMPNO, ENAME FROM EMP WHERE DEPTNO = 20 ORDER BY ENAME;
--EMP 테이블과 유사한 EMP01 : EMPNO(숫자4), ENAME(문자20), SAL(숫자7,2)
CREATE TABLE EMP01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    SAL NUMBER(7,2)
);
DESC EMP01;
--DEPT와 유사한 DEPT01 : DEPTNO(숫자2, PK), DNAME(문자14), LOC(문자13)
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13),
    PRIMARY KEY(DEPTNO)
);
DESC DEPT01;
DESC DEPT;
--서브쿼리
SELECT * FROM TAB;  --SCOTT이 생성한 테이블 LIST
SELECT * FROM EMP;

CREATE TABLE EMP02
    AS
    SELECT * FROM EMP;  --서브쿼리 결과만 EMP02테이블 생성 후 들어감(제약조건은 미포함)
SELECT * FROM EMP02;
DESC EMP02; --제약조건 미포함
    --EX.EMP03: EMP테이블에서 EMPNO, ENAME, DEPTNO만 추출한 데이터로 테이블
CREATE TABLE EMP03
    AS
    SELECT EMPNO, ENAME, DEPTNO FROM EMP;
SELECT * FROM EMP03;
    --EX.EMP04: EMP테이블에서 10번 부서만 추출한 데이터로 테이블
CREATE TABLE EMP04 
    AS
    SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP04;
    --EX.EMP05: EMP 테이블 구조(필드와 그의 타입)만 추출
CREATE TABLE EMP05
    AS
    SELECT * FROM EMP WHERE 1=0;    -- WHERE절에 반드시 거짓인것 넣음! ->모든것이 안나옴!
SELECT * FROM EMP05;
--2) 테이블 구조변경(ALTER TABLE)
--ALTER TABLE 테이블명 ADD || MODIFY || DROP ~
--(1) 필드 추가(ADD) : 추가된 필드의 데이터는 NULL
SELECT * FROM EMP03;    --EMPNO, ENAME, DEPTNO
ALTER TABLE EMP03 ADD(JOB VARCHAR2(20), SAL NUMBER(7,2));
SELECT * FROM EMP03;
ALTER TABLE EMP03 ADD (COMM NUMBER(7, 2));
--(2) 필드 수정(MODIFY)
SELECT * FROM EMP03;    --EMPNO(숫4), ENAME(문10), DEPTNO(숫2)/ JOB(문20), SAL, COMM(숫7,2)는 데이터 NULL
ALTER TABLE EMP03 MODIFY (EMPNO VARCHAR2(4));   --숫자 데이터가 들어 있는 상태에서는 숫자로만 변경 가능
ALTER TABLE EMP03 MODIFY (EMPNO NUMBER(3)); --에러 줄이는건 불가
ALTER TABLE EMP03 MODIFY (EMPNO NUMBER(5)); --가능 늘이는건 가능
ALTER TABLE EMP03 MODIFY (ENAME NUMBER(4)); --문자 데이터가 들어 있는 상태에서는 문자로만 변경 가능
SELECT MAX(LENGTH(ENAME)) FROM EMP;
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(30));
DESC EMP03;
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(6));   --이미 존재하는 이름중 6글자가 최대(데이터가 없다면 줄이는거 가능)
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(5)); --그래서 5글자로 줄이는 건 불가능
ALTER TABLE EMP03 MODIFY ( JOB NUMBER(4));
--(3) 필드 삭제(DROP)
ALTER TABLE EMP03 DROP COLUMN JOB;
DESC EMP03;
--논리적으로 특정 필드를 접근 못하도록(낮)
ALTER TABLE EMP03 SET UNUSED (DEPTNO);
SELECT * FROM EMP03;
--논리적으로 접근 불가했던 필드를 물리적으로 삭제(새벽)
ALTER TABLE EMP03 DROP UNUSED COLUMNS;

--3)테이블 삭제(DROP TABLE)
DROP TABLE EMP01;
DROP TABLE DEPT;    --다른 테이블에서 해당 테이블을 참조하여 사용하고 있는 경우 DROP 불가
SELECT * FROM EMP;

--4)테이블의 모든 행을 제거(TRUNCATE)
SELECT * FROM EMP03;
TRUNCATE TABLE EMP03;   --EMP03안의 데이터 제거 (취소불가)
SELECT * FROM EMP03;

--5)테이블명 변경(RENAME 원래이름 TO 새이름)
SELECT * FROM EMP02;
RENAME EMP02 TO EMP2;
SELECT * FROM EMP2;
--6)데이터 딕셔너리(접근 불가) VS. 데이터 딕셔너리 뷰(사용자 접근용)
--종류
--USER_XXX : 현 계정이 소유하고 있는 객체(테이블, 인덱스, 제약조건, 뷰)
    --EX.USER_TABLES, USER_INDEXES, USER_CONSTRAINTS, USER_VIEWS
--ALL_XXX : 현 계정이 접근 가능한 객체(테이블, 인덱스, 제약조건, 뷰)
    --EX.ALL_TABLES, ALL_INDEXES, ALL_CONSTRAINTS, ALL_VIEWS
--DBA_XXX : DBA권한자만 접근 가능, DBMS의 모든 객체
    --EX.DBA_TABLES, DBA_INDEXES, DBA_CONSTRAINTS, DBA_VIEWS
    
SELECT * FROM USER_TABLES;  --내 계정이 소유한 테이블 객체 정보
SELECT * FROM USER_INDEXES; --내 계정이 소유한 인덱스 정보
SELECT * FROM USER_CONSTRAINTS; --내 계정이 소유한 제약조건들
SELECT * FROM USER_VIEWS;   --내 계정이 소유한 뷰 정보

SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_INDEXES;
SELECT * FROM ALL_CONSTRAINTS;
SELECT * FROM ALL_VIEWS;

SELECT * FROM DBA_TABLES;
SELECT * FROM DBA_INDEXES;
SELECT * FROM DBA_CONSTRAINTS;
SELECT * FROM DBA_VIEWS;

--DCL(사용자계정생성, 사용자권한부여, 권한박탈, 사용자계정삭제)
CREATE USER scott2 IDENTIFIED BY 1234;  --scott2 계정생성
--권한부여(세션권한, scott.EMP, scott.DEPT 테이블에 대해 모든 권한)
GRANT CREATE SESSION TO scott2;     --scott2에게 로그인 권한 부여
GRANT ALL ON EMP TO scott2; --EMP테이블에 대한 모든 권한(검색, 추가, 수정, 삭제)
GRANT ALL ON DEPT TO scott2;    --DEPT테이블에 대한 모든 권한
show user;
--권한박탈(권한박탈할 사용자계정이 접속해제)
REVOKE ALL ON EMP FROM scott2;  --scott2의 EMP 테이블에 대한 모든 권한 박탈
REVOKE ALL ON DEPT FROM scott2;
show user;
--사용자계정 삭제(접속 중인 계정 삭제 불가)
DROP USER scott2 CASCADE;

--DML(SELECT, INSERT, UPDATE, DELETE)
--1.INSERT INTO 테이블명 VALUES(값1, 값2, 값3, ...);
--  INSERT INTO 테이블명 (필드명1, 필드명2,...) VALUES (값1, 값2,...);
SELECT * FROM DEPT01;
INSERT INTO DEPT01 VALUES (50, 'ACCOUNTIN', 'NEWYORK');
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC) VALUES (60, 'IT', 'SEOUL');
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES (70, 'OPERATION');    --묵시적으로 LOC에 NULL로 추가
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC) VALUES (80, 'HR', NULL);    --명시적으로 NULL추가
INSERT INTO DEPT01 VALUES (90, 'SALES', NULL);--명시적으로 NULL추가
--서브쿼리를 이용한 INSERT
INSERT INTO DEPT01 SELECT * FROM DEPT;
--트랜잭션 명령어(DML명령어만 트랜잭션에서 데이터 베이스에 진짜 적용 -> ROLLBACK으로 삭제 불가능)
COMMIT; 


--2. UPDATE 테이블명 SET 필드명1 = 값1 [ ,필드명2=값2, ...] [WHERE 조건];
DROP TABLE EMP01;
SELECT * FROM EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
--EMP01 테이블의 부서번호를 30으로 수정(WHERE 절 없이는 모든 행이 수정)
UPDATE EMP01 SET DEPTNO = 30;
SELECT * FROM EMP01;
ROLLBACK;   --트랜잭션 취소(DML만 취소 가능)
SELECT * FROM EMP01;

--EX. EMP01 테이블의 모든 사원의 급여 10%인상
UPDATE EMP01 
    SET SAL = SAL*1.1;
SELECT * FROM EMP01;
--EX. 10번 부서의 직원의 입사일을 오늘로, 부서번호는 30번으로 수정
UPDATE EMP01 
    SET HIREDATE = SYSDATE,
        DEPTNO = 30
    WHERE DEPTNO=10;
SELECT * FROM EMP01;
--EX. SAL>=3000인 직원만 급여 10%인상
UPDATE EMP01
    SET SAL = SAL*1.1
    WHERE SAL>=3000;
SELECT * FROM EMP01;
--EX.'DALLAS'에 근무하는 직원의 급여를 1000$씩 인상(서브쿼리 이용)
UPDATE EMP01 SET SAL = SAL + 1000
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
SELECT * FROM EMP01;
--EX.SCOTT의 부서번호를 20으로, JOB을 MANAGER로, SAL과 COMM을 500씩 인상, 상사를 KING으로 수정
UPDATE EMP01 
    SET DEPTNO = 20,
        JOB = 'MANAGER',
        SAL = SAL+500,
        COMM = NVL(COMM,0) + 500,
        MGR = (SELECT EMPNO FROM EMP WHERE ENAME = 'KING')
    WHERE ENAME = 'SCOTT';
SELECT * FROM EMP01;
--EX.DEPT01에서 20부터의 지역명을 DEPT테이블의 60번 부서의 지역명으로 변경
SELECT * FROM DEPT01;
UPDATE DEPT01
    SET LOC = (SELECT LOC FROM DEPT WHERE DEPTNO = 60)  --DEPTNO=60인게 없어서 DEPT01의 LOC가 NULL값으로 바뀜
    WHERE DEPTNO >= 20;
--EX.EMP01테이블의 모든 사원의 급여와 입사일을 'KING'의 급여와 입사일로 수정
UPDATE EMP01
    SET (SAL, HIREDATE) = (SELECT SAL, HIREDATE FROM EMP WHERE ENAME = 'KING'); 
ROLLBACK;
UPDATE EMP01
    SET SAL = (SELECT SAL FROM EMP WHERE ENAME = 'KING'),
        HIREDATE = (SELECT HIREDATE FROM EMP WHERE ENAME = 'KING'); 
SELECT * FROM EMP01;
--EX.DEPT01 테이블의 20번 부서의 지역명과 부서명을 40번 부서의 지역명과 부서명으로 변경
UPDATE DEPT01
    SET (LOC, DNAME) = (SELECT LOC, DNAME FROM DEPT01 WHERE DEPTNO = 40)
    WHERE DEPTNO = 20;
COMMIT;
SELECT * FROM DEPT01;    

--3. DELETE FROM 테이블명 (WHERE 조건);   --ROLLBACK가능!
SELECT * FROM EMP01;    --WHERE절을 안쓸경우 전체행이 모두 삭제됨(취소 가능)
DELETE FROM EMP01;
ROLLBACK;
--EX.EMP01 테이블에서 'FORD'인 사원을 삭제
DELETE 
    FROM EMP01
    WHERE ENAME = 'FORD';
--EX.EMP01테이블에서 30번 부서 직원을 삭제
DELETE
    FROM EMP01
    WHERE DEPTNO = 30;
--EX.EMP01테이블에서 부서명이 'RESEARCH'부서의 직원을 삭제
DELETE
    FROM EMP01
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'RESEARCH');
--★연습문제1    
CREATE TABLE SAM01(
    EMPNO NUMBER(4),     
    ENAME VARCHAR2(10),  
    JOB VARCHAR2(9), 
    SAL NUMBER(7,2),
    PRIMARY KEY(EMPNO) ); 
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1000, 'APPLE', 'POLICE', 10000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1010, 'BANANA', 'NURSE', 15000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1020, 'ORANGE', 'DOCTOR', 10000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1030, 'VERY', NULL, 10000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1040, 'CAT', NULL, 10000);
INSERT INTO SAM01 SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE DEPTNO='10';
COMMIT;

--SAM01 테이블에서 JOB이 정해지지 않은 사원을 삭제
SELECT * FROM SAM01;
DELETE FROM SAM01 WHERE JOB IS NULL;
ROLLBACK;
--SAM01테이블에서 ENAME이 ORANGE인 사원을 삭제하시오
DELETE
    FROM SAM01
    WHERE ENAME = 'ORANGE';

--★연습문제2
--아럐의 구조를 만족하는 MY_DATA 테이블을 생성하시오. 단 ID가 PRIMARY KEY이다.
CREATE TABLE MY_DATA(
    ID NUMBER(4),     
    NAME VARCHAR2(10),  
    USERID VARCHAR2(30), 
    SALARY NUMBER(10,2),
    PRIMARY KEY(ID) ); 
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (1, 'Scott', 'sscott', 10000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (2, 'Ford', 'fford', 13000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (3, 'Patel', 'ppatel', 33000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (4, 'Report', 'rreport', 23500.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (5, 'Good', 'ggood', 44450.00);
SELECT * FROM MY_DATA;
ROLLBACK;
SELECT ID, NAME, USERID, TO_CHAR(SALARY, '99,999')
    FROM MY_DATA
    ORDER BY ID;
COMMIT;
UPDATE MY_DATA
    SET SALARY = 65000.00
    WHERE ID = 3;
COMMIT;
DELETE
    FROM MY_DATA
    WHERE NAME = 'Ford';
COMMIT;
UPDATE MY_DATA
    SET SALARY = 15000.00
    WHERE SALARY <= 15000.00;
    
DROP TABLE MY_DATA;

--★★★제약조건 : 부적합한 데이터가 테이블에 삽입, 수정되는 것을 방지하기 위해
SELECT * FROM EMP;
INSERT INTO EMP VALUES('NULL', '홍', NULL, NULL, SYSDATE,  NULL, NULL, 40);  --SMITH 사번과 중복 에러
UPDATE EMP SET EMPNO =7369 WHERE ENAME = 'ALLEN';   --SMITH 사번과 중복 에러
--(1) PRIMARY KEY : 유일하게 테이블의 각 행을 식별. NOT NULL
    INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (7369,  '홍', 40); --중복된 사번 입력 불가(에러남)
--(2) NOT NULL : NULL값을 포함하지 않음
--(3) UNIQUE : 모든 행에 대해  유일해야. NULL값을 허용(NULL은 여러행 입력 가능)
--(4) FOREIGN KEY : 테이블의 열은 다른 테이블의 열을 참조(EX. EMP테이블의 DEPTNO는 DEPT 테이블의 DEPTNO를 참조)
    --비식별관계 : 부모테이블의 주키가 자식테이블의 일반속성에 속한 필드로 관계(exERD에서 빨간점선화살표)
    --식별관계 : 부모테이블의 주키가 자식테이블의 주키(주키군)에 속한 필드로 관계(exERD에서 초록점선화살표)
    INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (1111,  '홍', 90); -- 외래키로 90번 입력 불가(에러남)
--(5) CHECHK(조건) : 해당조건이 만족 (NULL값 허용)
--DEFAULT : 해당 열의 데이터 입력값이 없으면 NULL값 대신에 (기본값을 설정하면) 기본값이 들어감 
DROP TABLE DEPT1;
CREATE TABLE DEPT1(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14) UNIQUE,
    LOC VARCHAR2(13) NOT NULL);
DROT TABLE EMP1;
CREATE TABLE EMP1(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL NUMBER(7, 2) CHECK(SAL>0),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2) REFERENCES DEPT1(DEPTNO));     --REFERENCES : DEPT1 테이블을 참조하는 EMP1 테이블
DROP TABLE EMP1;    --자식테이블(참조하는
DROP TABLE DEPT1;

DROP TABLE DEPT1 CASCADE CONSTRAINTS; --비추긴함... (참조하는 테이블이 있어도 무시하고 DROP)

CREATE TABLE DEPT1(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13) NOT NULL,
    PRIMARY KEY (DEPTNO),
    UNIQUE(DNAME));
CREATE TABLE EMP1(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(20),
    PRIMARY KEY(EMPNO),
    CHECK (SAL>0),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT1(DEPTNO));
SELECT * FROM DEPT1;
INSERT INTO DEPT1 SELECT * FROM DEPT;
INSERT INTO DEPT1 VALUES(40, 'IT', 'SEOUL');--PK위배
INSERT INTO DEPT1 VALUES(50, 'SALES', 'SEOUL');--UINQUE 위배
INSERT INTO DEPT1 VALUES(50, 'IT', NULL); -- NOT NULL위배

INSERT INTO EMP1(EMPNO, ENAME, DEPTNO)
    VALUES(1001, '홍', 10);
SELECT * FROM EMP1; --HIREDATE에 설정된 기본값 입력
INSERT INTO EMP1 (EMPNO, ENAME, DEPTNO)
    VALUES(1001, '김', 10);  --PK 위배
INSERT INTO EMP1 (EMPNO, DEPTNO)
    VALUES(1002, 20);   --ENAME인 NOT NULL 위배
INSERT INTO EMP1 (EMPNO, ENAME, SAL, DEPTNO)
    VALUES (1002, '박', -1); --SAL>0 위배
INSERT INTO EMP1 VALUES(1002, '윤', NULL, NULL, TO_DATE('95/01/01', 'YY//MM/DD'), 900, NULL, 99);--FK 위배

--연습문제
--EX1.
DROP TABLE BOOKCATEGORY;
CREATE TABLE BOOKCATEGORY(
    CATEGORY_CODE NUMBER(3) PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(50) UNIQUE,
    OFFICE_LOC VARCHAR2(50) NOT NULL
);
DROP TABLE BOOK;
CREATE TABLE BOOK(
    CATEGORY_CODE NUMBER(4) REFERENCES BOOKCATEGORY(CATEGORY_CODE),
    bookNO VARCHAR2(10) PRIMARY KEY,
    bookNAME VARCHAR2(50),
    PUBLISHER VARCHAR2(50),
    PUBYEAR NUMBER(4) DEFAULT EXTRACT(YEAR FROM SYSDATE)
     );
INSERT INTO BOOKCATEGORY VALUES ( 100, '철학', '3층 인문실');
INSERT INTO BOOKCATEGORY VALUES ( 200, '인문', '3층 인문실');
INSERT INTO BOOKCATEGORY VALUES ( 300, '자연과학', '4층 과학실');
INSERT INTO BOOKCATEGORY VALUES ( 400, 'IT', '4층 과학실');
SELECT * FROM BOOKCATEGORY;

INSERT INTO BOOK (CATEGORY_CODE, bookNO, bookNAME, PUBLISHER) 
    VALUES ( 100, '100A01', '철학자의 삶', '더존출판');
INSERT INTO BOOK (CATEGORY_CODE, bookNO, bookNAME, PUBLISHER) 
    VALUES ( 400, '400A01', '이것이 DB다', '더존출판');
SELECT * FROM BOOK;

--연습문제
--EX2.
DROP TABLE MAJOR;
CREATE TABLE MAJOR(
    MAJOR_CODE NUMBER(3) PRIMARY KEY,
    MAJOR_NAME VARCHAR2(50) UNIQUE,
    MAJOR_OFFICE_LOC VARCHAR2(50) NOT NULL
);
DROP TABLE STUDENT;
CREATE TABLE STUDENT(
    student_code VARCHAR2(50) PRIMARY KEY,
    student_NAME VARCHAR2(50) NOT NULL,
    SCORE NUMBER(4) CHECK(SCORE>=0 AND SCORE<=100),
    MAJOR_CODE NUMBER(3) REFERENCES MAJOR(MAJOR_CODE)
);
INSERT INTO MAJOR VALUES ( 1, '경영정보', '경영관 305호');
INSERT INTO MAJOR VALUES ( 2, '소프트웨어공학', '정보관 808호');
INSERT INTO MAJOR VALUES ( 3, '디자인', '예술관 606호');
INSERT INTO MAJOR VALUES ( 4, '경제', '경상관 202호');
SELECT * FROM MAJOR;

INSERT INTO STUDENT VALUES ( 'A01', '김길동', 100, 1);
INSERT INTO STUDENT VALUES ( 'A02', '문길동', 90, 2);
INSERT INTO STUDENT VALUES ( 'A03', '홍길동', 95, 1);
SELECT * FROM STUDENT;














>>>>>>> 96d58a64e5ebb5b1e4ae407f3b35890afe1e7606
