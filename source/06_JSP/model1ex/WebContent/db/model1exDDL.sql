-- ??΄λΈ?/????€ drop & create
-- CUSTOMER ??΄λΈ?
DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER(
    cID VARCHAR2(50) PRIMARY KEY,
    cPW VARCHAR2(50) NOT NULL,
    cNAME VARCHAR2(50) NOT NULL,
    cTEL VARCHAR2(50) NOT NULL,
    cEMAIL VARCHAR2(50),
    cADDRESS VARCHAR2(250),
    cGENDER VARCHAR2(10) NOT NULL,
    cBIRTH DATE NOT NULL,
    cRDATE DATE DEFAULT SYSDATE
);
-- BOOK ??΄λΈ? & ????€
DROP TABLE BOOK;
DROP SEQUENCE BOOK_SEQ;
CREATE SEQUENCE BOOK_SEQ
    MAXVALUE 99999
    NOCACHE
    NOCYCLE;
CREATE TABLE BOOK(
    bID NUMBER(5) PRIMARY KEY,  -- μ±λ²?Έ
    bTITLE VARCHAR2(100) NOT NULL,   -- μ±μ λͺ?
    bPRICE NUMBER(7) NOT NULL,  -- μ±κ?κ²? 
    bIMAGE1 VARCHAR2(30),    -- μ±? ??? ?΄λ―Έμ?(μ²¨λ??? κ²½μ° : noImg.png)
    bIMAGE2 VARCHAR2(30),    -- μ±? λΆ?κ°? ?΄λ―Έμ?(μ²¨λ??? κ²½μ° : NOTHING.JPG)
    bCONTENT VARCHAR2(4000),    -- μ±? ?€λͺ?(?κΈ? 1,333κΈ?? ?΄?΄)
    bDISCOUNT NUMBER(3) NOT NULL,    -- ? ?Έ?¨(0~100% ?΄?΄) μ§???΄? λ°λ³΄?€ μ§???΄? λͺ½μ΄?΄?€ ?΄λ§?.G1G1
    bRDATE DATE DEFAULT SYSDATE     -- μ±? ?±λ‘μΌ
);
select * from book;
select * from customer;
-- FILEBOARD ??΄λΈ? & ????€
DROP SEQUENCE FILEBOARD_SEQ;
CREATE SEQUENCE FILEBOARD_SEQ
    MAXVALUE 9999999
    NOCACHE
    NOCYCLE;
DROP TABLE FILEBOARD;
CREATE TABLE FILEBOARD(
    fNUM NUMBER(7) PRIMARY KEY, -- κΈ?λ²νΈ
    cID VARCHAR2(50) REFERENCES CUSTOMER(cID),  -- ??±? ID
    fSUBJECT VARCHAR2(250) NOT NULL,    -- κΈ? ? λͺ?
    fCONTENT VARCHAR2(4000),    -- λ³Έλ¬Έ
    fFILENAME VARCHAR2(50), -- μ²¨λ???Όλͺ?
    fPW VARCHAR2(50) NOT NULL,  -- λΉλ²
    fHIT NUMBER(7) DEFAULT 0 NOT NULL,    -- μ‘°ν?
    fREF NUMBER(7) NOT NULL,    -- κΈ? κ·Έλ£Ή
    fRE_STEP NUMBER(7) NOT NULL,    -- κ·Έλ£Ή?΄ μΆλ ₯??
    fRE_LEVEL NUMBER(7) NOT NULL,   -- ?€?¬?°κΈ? ? ?
    fIP VARCHAR2(50) NOT NULL,  -- κΈ??΄ μ»΄ν¨?° IP
    fRDATE DATE DEFAULT SYSDATE NOT NULL-- κΈ? ?±λ‘? ?? 
);
COMMIT;