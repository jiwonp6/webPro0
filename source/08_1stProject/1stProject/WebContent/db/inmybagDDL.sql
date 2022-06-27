--CREATE TABLE
--***ADMIN***
DROP TABLE ADMIN CASCADE CONSTRAINTS;
CREATE TABLE ADMIN(
    aID VARCHAR2(30) PRIMARY KEY,
    aPW VARCHAR2(30) NOT NULL,
    aNAME VARCHAR2(30) NOT NULL,
    aKING NUMBER(1) DEFAULT 0 NOT NULL
);
SELECT * FROM ADMIN;
--***MEMBER***
DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE MEMBER(
    mID VARCHAR2(30) PRIMARY KEY,
    mPW VARCHAR2(30) NOT NULL,
    mNAME VARCHAR2(30) NOT NULL,
    mBIRTH DATE,
    mEMAIL VARCHAR2(30) NOT NULL,
    mRDATE DATE DEFAULT SYSDATE NOT NULL
);
SELECT * FROM MEMBER;
--------------BOARD------------------
--***QNA_SEQ***
DROP SEQUENCE QNA_SEQ;
CREATE SEQUENCE QNA_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
--***QNA***
DROP TABLE QNABOARD CASCADE CONSTRAINTS;
CREATE TABLE QNABOARD(
    qID NUMBER(10) PRIMARY KEY,
    aID VARCHAR2(30) REFERENCES ADMIN (aID),
    mID VARCHAR2(30) REFERENCES MEMBER (mID),
    qTITLE VARCHAR2(30) NOT NULL,
    qCONTENT VARCHAR2(4000) NOT NULL,
    qFILENAME VARCHAR2(100),
    qHIT NUMBER(6) DEFAULT 0 NOT NULL,
    qRDATE DATE DEFAULT SYSDATE NOT NULL,
    qGROUP NUMBER(6),
    qSTEP NUMBER(6),
    qINDENT NUMBER(6),
    qIP VARCHAR2(30) NOT NULL
);
SELECT * FROM QNABOARD;
--***NOTICE_SEQ***
DROP SEQUENCE NOTICE_SEQ ;
CREATE SEQUENCE NOTICE_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
--***NOTICE_inQNA***
DROP TABLE NOTICEBOARD CASCADE CONSTRAINTS;
CREATE TABLE NOTICEBOARD(
    nID NUMBER(10) PRIMARY KEY,
    aID VARCHAR2(30) REFERENCES ADMIN (aID),
    nTITLE VARCHAR2(30) NOT NULL,
    nCONTENT VARCHAR2(4000) NOT NULL,
    nFILENAME VARCHAR2(100),
    nHIT NUMBER(6) DEFAULT 0 NOT NULL,
    nRDATE DATE DEFAULT SYSDATE NOT NULL,
    nIP VARCHAR2(30) NOT NULL
);
SELECT * FROM NOTICEBOARD;
--***myBAG_SEQ***
DROP SEQUENCE myBAG_SEQ;
CREATE SEQUENCE myBAG_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
--***myBAGBOARD***
DROP TABLE myBAGBOARD CASCADE CONSTRAINTS;
CREATE TABLE myBAGBOARD(
    bID NUMBER(10) PRIMARY KEY,
    mID VARCHAR2(30) REFERENCES MEMBER (mID),
    bNAME VARCHAR2(30) NOT NULL,
    bCONTENT VARCHAR2(4000) NOT NULL,
    bFILENAME VARCHAR2(100),
    bHIT NUMBER(6) DEFAULT 0 NOT NULL,
    bRDATE DATE DEFAULT SYSDATE NOT NULL,
    bIP VARCHAR2(30) NOT NULL
);
SELECT * FROM myBAGBOARD;
--***LIKEmyBAG***
DROP SEQUENCE LIKE_SEQ;
CREATE SEQUENCE LIKE_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
DROP TABLE LIKEmyBAG CASCADE CONSTRAINTS;
CREATE TABLE LIKEmyBAG(
    lID NUMBER(10) NOT NULL,
    mID VARCHAR2(30) REFERENCES MEMBER (mID),
    bID NUMBER(10) REFERENCES myBAGBOARD (bID),
    lRDATE DATE DEFAULT SYSDATE NOT NULL
);
SELECT * FROM LIKEmyBAG;
--***REPLYmyBAG***
DROP SEQUENCE REPLY_SEQ;
CREATE SEQUENCE REPLY_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
DROP TABLE REPLYmyBAG CASCADE CONSTRAINTS;
CREATE TABLE REPLYmyBAG(
    rID NUMBER(1) NOT NULL,
    mID VARCHAR2(30) REFERENCES MEMBER (mID),
    bID NUMBER(10) REFERENCES myBAGBOARD (bID),
    rCONTENT VARCHAR2(500) NOT NULL,
    rRDATE DATE DEFAULT SYSDATE NOT NULL,
    rGROUP NUMBER(6),
    rSTEP NUMBER(6),
    rINDENT NUMBER(6),
    rIP VARCHAR2(30) NOT NULL
);
SELECT * FROM REPLYmyBAG;
--***ITEM_SEQ***
DROP SEQUENCE ITEM_SEQ;
CREATE SEQUENCE ITEM_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
--***QNA***
DROP TABLE ITEMBOARD CASCADE CONSTRAINTS;
CREATE TABLE ITEMBOARD(
    iID NUMBER(10) PRIMARY KEY,
    mID VARCHAR2(30) REFERENCES MEMBER (mID),
    iTITLE VARCHAR2(30) NOT NULL,
    iCONTENT VARCHAR2(4000) NOT NULL,
    iFILENAME VARCHAR2(100),
    iHIT NUMBER(6) DEFAULT 0 NOT NULL,
    iRDATE DATE DEFAULT SYSDATE NOT NULL,
    iGROUP NUMBER(6),
    iSTEP NUMBER(6),
    iINDENT NUMBER(6),
    iIP VARCHAR2(30) NOT NULL
);
SELECT * FROM ITEMBOARD;