CREATE TABLE DEPT ( DNO NUMBER, DNAME VARCHAR2(255), CONSTRAINT DEPT_DNO_PK PRIMARY KEY(DNO));

CREATE TABLE EMP ( 
    ENO NUMBER CONSTRAINT EMP_ENO_PK PRIMARY KEY,
    ENAME VARCHAR2(255),
    DNO NUMBER ,
    JNO NUMBER,
    OUTSOURSING NUMBER(1) DEFAULT 0,
    CONSTRAINT EMP_DEPT_DNO_FK FOREIGN KEY(DNO) REFERENCES DEPT(DNO),
    CONSTRAINT EMP_JOB_JNO_FK FOREIGN KEY(JNO) REFERENCES JOB(JNO)
    );
    
CREATE TABLE JOB(
    JNO NUMBER CONSTRAINT JOB_JNO_PK PRIMARY KEY,
    JNAME VARCHAR2(255)
);

CREATE TABLE EMP_CHAIN_SAL (
    ENO NUMBER,
    SNO NUMBER,
    CONSTRAINT EMP_SAL_PK PRIMARY KEY(ENO, SNO)
);

CREATE TABLE SAL (
    SNO NUMBER CONSTRAINT SAL_SNO_PK PRIMARY KEY,
    SNAME VARCHAR2(255)
);

CREATE TABLE PAY(
 PNO NUMBER CONSTRAINT PAY_PNO_PK PRIMARY KEY,
 PNAME VARCHAR2(255)
);

CREATE TABLE YEAR_IN_SAL (
    YNO NUMBER CONSTRAINT YEAR_IN_SAL_YNO_PK PRIMARY KEY,
    YEAR NUMBER(4) ,
     JAN NUMBER(2,0) DEFAULT 0,
    FEB NUMBER(2,0) DEFAULT 0,
    MAR NUMBER(2,0) DEFAULT 0,
    APR NUMBER(2,0) DEFAULT 0,
    MAY NUMBER(2,0) DEFAULT 0,
    JUN NUMBER(2,0) DEFAULT 0,
    JUL NUMBER(2,0) DEFAULT 0,
    AUG NUMBER(2,0) DEFAULT 0,
    SEP NUMBER(2,0) DEFAULT 0,
    OCT NUMBER(2,0) DEFAULT 0,
    NOV NUMBER(2,0) DEFAULT 0,
    DEC NUMBER(2,0) DEFAULT 0
);

CREATE TABLE JOB_CHAIN_SAL_YEAR_PAY (
    JNO NUMBER,
    SNO NUMBER,
    PNO NUMBER,
    YNO NUMBER,
    CONSTRAINT JOB_CHAIN_SAL_YEAR_PAY_PK PRIMARY KEY(JNO,SNO,PNO,YNO)
);

--- 테스트
-- 1.
insert into dept values (
 (select nvl(max(dno),0) +1 from dept) , '인사'
);
insert into dept values (
 (select nvl(max(dno),0) +1 from dept) , '행정'
);
insert into dept values (
 (select nvl(max(dno),0) +1 from dept) , '개발'
);
-- 2.
insert into job values(
 (select nvl(max(jno),0) +1 from job) , '인사과장'
);
insert into job values(
 (select nvl(max(jno),0) +1 from job) , '인사부장'
);
insert into job values(
 (select nvl(max(jno),0) +1 from job) , '개발선임'
);
insert into job values(
 (select nvl(max(jno),0) +1 from job) , '개발리더'
);

-- 3.
insert into emp values (
(select nvl(max(eno),0) +1 from emp) , '정수민' , 3, 3, 0
);

insert into emp values (
(select nvl(max(eno),0) +1 from emp) , '최범균' , 3, 4, 0
);