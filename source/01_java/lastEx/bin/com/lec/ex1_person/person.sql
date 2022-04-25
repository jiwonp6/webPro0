-- 테이블 생성 (같은 이름의 테이블이 생성되었을 경우 DROP) & -- 더미데이터(JOB->PERSON)
DROP TABLE JOB;
CREATE TABLE JOB(
    jNO NUMBER(2) PRIMARY KEY,
    jNAME VARCHAR(30) NOT NULL
);
INSERT INTO JOB VALUES (10, '배우');
INSERT INTO JOB VALUES (20, '가수');
SELECT * FROM JOB;

DROP SEQUENCE PERSON_NO_SQ;
CREATE SEQUENCE PERSON_NO_SQ
    MAXVALUE 9999
    NOCACHE 
    NOCYCLE;
DROP TABLE PERSON;
CREATE TABLE PERSON(
    pNO NUMBER(5) PRIMARY KEY,
    pNAME VARCHAR2(30) NOT NULL,
    jNO NUMBER(2) REFERENCES JOB(jNO),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MAT NUMBER(3)
);
INSERT INTO PERSON VALUES (PERSON_NO_SQ.NEXTVAL, '정우성', 10, 90, 80, 81);
INSERT INTO PERSON VALUES (PERSON_NO_SQ.NEXTVAL, '박세영', 10, 80, 90, 80 );
INSERT INTO PERSON VALUES (PERSON_NO_SQ.NEXTVAL, '배수지', 20, 20, 90, 90 );
INSERT INTO PERSON VALUES (PERSON_NO_SQ.NEXTVAL, '설현', 20, 95, 95, 95 );
INSERT INTO PERSON VALUES (PERSON_NO_SQ.NEXTVAL, '송혜교', 10, 100, 100, 100 );
SELECT * FROM PERSON;
-- 1번 : PNAME, JNAME, KOR, ENG, MAT을 입력받아 INSERT
INSERT INTO PERSON VALUES (PERSON_NO_SQ.NEXTVAL, PNAME, (SELECT jNO FROM JOB WHERE jNAME = '배우'), KOR, ENG, MAT);
-- 2번 : GRADE, PNO, JNAME, KOR, ENG, MAT, SUM 출력(총점 높은순)
SELECT ROWNUM "RANK", SG.*
    FROM (SELECT  pNAME||'('||pNO||'번)' pname, jNAME, KOR, ENG, MAT, KOR+ENG+MAT SUMGRADE 
            FROM PERSON P, JOB J 
            WHERE P.jNO = J.jNO AND jNAME = '배우' 
            ORDER BY SUMGRADE DESC) SG;

-- 3번 : 모든 행의 GRADE, PNO, JNAME, KOR, ENG, MAT, SUM 출력 (총점 높은순)
SELECT ROWNUM ||'등', SG.*
    FROM (SELECT  pNAME||'('||pNO||'번)', jNAME, KOR, ENG, MAT, KOR+ENG+MAT SUMGRADE 
            FROM PERSON P, JOB J 
            WHERE P.jNO = J.jNO 
            ORDER BY SUMGRADE DESC) SG;
-- 
SELECT ROWNUM RANK, A.* 
    FROM (SELECT PNAME||'('||PNO||'번)' PNAME, JNAME, KOR, ENG, MAT, KOR+ENG+MAT SUM 
            FROM PERSON P, JOB J
            WHERE P.JNO=J.JNO  
            ORDER BY SUM DESC) A;
-- 콤보박스에 들어갈 직업명 list
SELECT JNAME FROM JOB;
commit;



--확인
SELECT * FROM PERSON;
DELETE PERSON WHERE pNAME='김길순';
COMMIT;
