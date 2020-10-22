create table dept (
    dno number constraint dept_dno_pk PRIMARY key,
    dname varchar2(255)
);

create sequence seq_dept;

insert into dept values (
    seq_dept.nextval, '개발'
);

create table salary(
 sno number constraint salary_sno_pk PRIMARY key,
 sname varchar2(255)
);

create sequence seq_salary;

insert into salary values (
    seq_salary.nextval, '기본급'
);
insert into salary values (
    seq_salary.nextval, '상여금'
);
insert into salary values (
    seq_salary.nextval, '경조사금'
);
create sequence seq_payment;
create table payment (
    pno number constraint payment_pno_pk PRIMARY key,
    pname varchar2(255)
);
insert into payment values (
    seq_payment.nextval, 150000 -- 상담직 기본급
);
insert into payment values (
    seq_payment.nextval, 200000 -- 상담 선임 기본급
);
insert into payment values (
    seq_payment.nextval, 120000 -- 개발직 기본급
);
insert into payment values (
    seq_payment.nextval, 170000 -- 개발 선임 기본급
);
insert into payment values (
    seq_payment.nextval, 10000 -- 상담직 상여
);
insert into payment values (
    seq_payment.nextval, 30000 -- 개발직 상여
);

drop table JOB_TO_SAL_TO_PAY cascade constraint;
create table job_to_sal_to_pay (
    sno number ,
    jno number ,
    pno number,
    eno number,
    CONSTRAINT jtstp_sno foreign key(sno) REFERENCES salary(sno),
    CONSTRAINT jtstp_jno foreign key(jno) REFERENCES job(jno),
    CONSTRAINT jtstp_pno foreign key(pno) REFERENCES payment(pno),
    CONSTRAINT jtstp_eno foreign key(eno) REFERENCES emp(eno),
    constraint job_to_sal_to_pay_pk primary key(sno, jno, pno, eno);
);

alter table job_to_sal_to_pay add constraint job_to_sal_to_pay_pk primary key(sno, jno, pno, eno);

commit;
create sequence seq_job;
create table job (
    jno number constraint job_jno_pk PRIMARY key,
    jname varchar2(255)
);

insert into job values (
    seq_job.nextval, '개발 신입'
);
insert into job values (
    seq_job.nextval, '개발 선임'
);
insert into job values (
    seq_job.nextval, '상담 신입'
);
insert into job values (
    seq_job.nextval, '상담 선임'
);

drop table emp cascade constraint;
create sequence seq_emp;
create table emp (
    eno number constraint emp_eno_pk PRIMARY key,
    ename varchar2(255),
    dno number,
    constraint emp_dept_fk foreign key(dno) REFERENCES dept(dno)
);
insert into emp values (
    seq_emp.nextval,
    '정상담',
    1
);
insert into emp values (
    seq_emp.nextval,
    '김상담',
    1
);
insert into emp values (
    seq_emp.nextval,
    '정개발',
    2
);
insert into emp values (
    seq_emp.nextval,
    '김개발',
    2
);

commit;
truncate table job_to_sal_to_pay;
insert into job_to_sal_to_pay values (
  1,4,6,4 -- 김개발(개발 선임)의 기본금
);
insert into job_to_sal_to_pay values (
  2,4,4,4 -- 김개발(개발 선임)의 상여금
);
insert into job_to_sal_to_pay values (
  1,5,5,3 -- 김상담(상담 선임)의 기본금
);
insert into job_to_sal_to_pay values (
  2,5,4,3 -- 김상담(상담 선임)의 상여금
);
insert into job_to_sal_to_pay values (
  1,1,2,1 -- 정개발(개발직)의 기본금
);
insert into job_to_sal_to_pay values (
  1,2,1,2 -- 정상담(상담직)의 기본금
);
insert into job_to_sal_to_pay values (
  2,1,4,1 --정개발(개발직)의 상여금
);
insert into job_to_sal_to_pay values (
  2,2,3,2 --정상담(상담직)의 상여금
);

drop table year_in_salary;
create table year_in_salary (
    yisno number constraint year_in_salary_yisno_pk PRIMARY key,
    eno number,
    sno number,
    YEAR NUMBER(4) ,
     JAN NUMBER(20) DEFAULT 0,
    FEB NUMBER(20) DEFAULT 0,
    MAR NUMBER(20) DEFAULT 0,
    APR NUMBER(20) DEFAULT 0,
    MAY NUMBER(20) DEFAULT 0,
    JUN NUMBER(20) DEFAULT 0,
    JUL NUMBER(20) DEFAULT 0,
    AUG NUMBER(20) DEFAULT 0,
    SEP NUMBER(20) DEFAULT 0,
    OCT NUMBER(20) DEFAULT 0,
    NOV NUMBER(20) DEFAULT 0,
    DEC NUMBER(20) DEFAULT 0,
    constraint year_in_salary_eno_fk FOREIGN key(eno) REFERENCES emp(eno),
    constraint year_in_salary_sno_fk FOREIGN key(sno) REFERENCES salary(sno)
);
--조인 문제 없음
select * from dept d
    natural join emp e;

    
    drop sequence seq_syi_salary;
    create sequence seq_syi_salary;
insert into year_in_salary values (
    seq_syi_salary.nextval,
    2, --정상담의
    1, -- 기본급
    2020, -- 2020년
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000
);
insert into year_in_salary values (
    seq_syi_salary.nextval,
    2, --정상담의
    2, -- 기본급
    2020, -- 2020년
    10000,
    10000,
    10000,
    10000,
    10000,
    10000,
    10000,
    10000,
    10000,
    10000,
    10000,
    10000
);
insert into year_in_salary values (
    seq_syi_salary.nextval,
    3, --김상담의
    1, -- 기본급
    2020, -- 2020년
    200000,
    200000,
    200000,
    200000,
    200000,
    200000,
    200000,
    200000,
    200000,
    200000,
    200000,
    200000
);
insert into year_in_salary values (
    seq_syi_salary.nextval,
    3, --김상담의
    2, -- 상여급
    2020, -- 2020년
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000
);
insert into year_in_salary values (-- 정개발 기본급
    seq_syi_salary.nextval,
    1, 
    1, 
    2020, -- 2020년
    120000,
    120000,
    120000,
    120000,
    120000,
    120000,
    120000,
    120000,
    120000,
    120000,
    120000,
    120000
);
insert into year_in_salary values (-- 정개발 상여금
    seq_syi_salary.nextval,
    1, 
    2, 
    2020, -- 2020년
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000,
    150000
);
insert into year_in_salary values (-- 김개발 기본급
    seq_syi_salary.nextval,
    4,
    1, -- 기본급
    2020, -- 2020년
    170000,
    170000,
    170000,
    170000,
    170000,
    170000,
    170000,
    170000,
    170000,
    170000,
    170000,
    170000
);
insert into year_in_salary values (-- 김개발 상여금
    seq_syi_salary.nextval,
    4, 
    2, 
    2020, -- 2020년
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000,
    30000
);
create index idn_year_in_salary_sno on year_in_salary(sno);
create index idn_year_in_salary_eno on year_in_salary(eno);


select dname, ename, jname, sname, pname, year, jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec 
    from  emp e 
    inner join dept d
    on e.dno = d.dno
    inner join job_to_sal_to_pay jsp
    on e.eno = jsp.eno
    inner join job j 
    on j.jno = jsp.jno
    inner join salary s
    on s.sno = jsp.sno
    inner join payment p
    on p.pno = jsp.pno
    inner join year_in_salary yis
    on e.eno = yis.eno and s.sno = yis.sno
    order by d.dno;
    
    select dname, sname, jname, year, 
    sum(jan) as "1월 총계" , sum(feb) as "2월 총계", sum(mar) as "3월 총계", sum(apr) as "4월 총계", sum(may) as "5월총계", sum(jun) as "6월 총계", sum(jul) as "7월 총계", sum(aug) as "8월 총계", sum(sep) as "9월 총계", sum(oct) as "10월 총계", sum(nov) as "11월 총계", sum(dec) as "12월 총계" 
    from  emp e 
    inner join dept d
    on e.dno = d.dno
    inner join job_to_sal_to_pay jsp
    on e.eno = jsp.eno
    inner join job j 
    on j.jno = jsp.jno
    inner join salary s
    on s.sno = jsp.sno
    inner join payment p
    on p.pno = jsp.pno
    inner join year_in_salary yis
    on e.eno = yis.eno and s.sno = yis.sno
    group by d.dno,dname,sname,jname, year
    order by d.dno;
    
    drop table cost cascade constraint;
    create sequence seq_cost;
    create table cost (
        cno number constraint cost_cno_pk primary key,
        cname varchar2(255)
    );
    
    drop table cost_details cascade constraint;
    create sequence seq_cost_details;
    create table cost_details(
        cdno number constraint cost_details_cdno_pk primary key,
        cdname varchar2(255),
        cno number,
        unitprice number,
        constraint cost_details_cost_cno_fk foreign key(cno) references cost(cno)
    );
    
    create table cost_to_details_to_pay_job (
     eno number,
     cdno number,
     pno number,
     jno number,
     constraint cost_to_details_to_pay_pk primary key(eno,cdno,pno),
     constraint ctdtp_eno_fk foreign key(eno) references emp(eno),
     constraint ctdtp_cdno_fk foreign key(cdno) references cost_details(cdno),
     constraint ctdtp_pno_fk foreign key(pno) references payment(pno),
     constraint ctdtp_jno_fk foreign key(jno) references job(jno)
    );
    
    create sequence seq_year_in_cost;
    create table year_in_cost (
        yicno number constraint year_in_cost_yicno_pk primary key,
        eno number,
        cdno number,
        YEAR NUMBER(4) ,
         JAN NUMBER(20) DEFAULT 0,
        FEB NUMBER(20) DEFAULT 0,
        MAR NUMBER(20) DEFAULT 0,
        APR NUMBER(20) DEFAULT 0,
        MAY NUMBER(20) DEFAULT 0,
        JUN NUMBER(20) DEFAULT 0,
        JUL NUMBER(20) DEFAULT 0,
        AUG NUMBER(20) DEFAULT 0,
        SEP NUMBER(20) DEFAULT 0,
        OCT NUMBER(20) DEFAULT 0,
        NOV NUMBER(20) DEFAULT 0,
        DEC NUMBER(20) DEFAULT 0,
        constraint year_in_cost_eno_fk FOREIGN key(eno) REFERENCES emp(eno),
        constraint year_in_cost_cdno_fk FOREIGN key(cdno) REFERENCES cost_details(cdno)
    );
    create index idn_year_in_cost_sno on year_in_cost(eno);
    create index idn_year_in_cost_cdno on year_in_cost(cdno);
    
-- 더미데이터 확인
insert into cost values (
    seq_cost.nextval,
    '퇴직급여'
);
insert into cost values (
    seq_cost.nextval,
    '교육훈련비'
);    

insert into cost_details values (
    seq_cost_details.nextval,
    '퇴직충당금',
    1 -- 퇴직급여 항목
    ,8.33
);
insert into cost_details values (
    seq_cost_details.nextval,
    '채용비',
    2 -- 교육훈련비
    ,null
);
insert into cost_details values (
    seq_cost_details.nextval,
    '교육생 교육비',
    2 -- 교육훈련비
    ,null
);
insert into cost_details values (
    seq_cost_details.nextval,
    '외부교육/세미나',
    2 -- 교육훈련비
    ,null
);
insert into cost_details values (
    seq_cost_details.nextval,
    '우수사원 해외연수',
    2 -- 교육훈련비
    ,4000
);
desc cost_to_details_to_pay;
--더미데이터
insert into payment values (
    SEQ_PAYMENT.nextval, 15000 -- 정상담의 퇴직충당금
);
insert into payment values (
    SEQ_PAYMENT.nextval, 10000 -- 정상담의 채용비
);
insert into payment values (
    SEQ_PAYMENT.nextval, 12000 -- 정개발의 채용비
);
insert into payment values (
    SEQ_PAYMENT.nextval, 20000 -- 정개발의 교육생 교육비
);
insert into payment values (
    SEQ_PAYMENT.nextval, 100000 -- 김상담의 외부교육/세미나비
);
insert into payment values (
    SEQ_PAYMENT.nextval, 150000 -- 김개발의 우수사원해외연수
);
select * from cost_details;
insert into cost_to_details_to_pay_job values (-- 직원번호, 비용 세부 번호, 지불번호 
    2,2,9,2  -- 정상담의 퇴직충당금 15000
);
insert into cost_to_details_to_pay_job values (-- 직원번호, 비용 세부 번호, 지불번호 
    2,3,10,2 -- 정상담의 채용비 10000
);
insert into cost_to_details_to_pay_job values (-- 직원번호, 비용 세부 번호, 지불번호 
    1,3,11,1 -- 정개발의 채용비 12000
);
insert into cost_to_details_to_pay_job values (-- 직원번호, 비용 세부 번호, 지불번호 
    1,4,12,1 -- 정개발의 교육생 교육비 20000
);
insert into cost_to_details_to_pay_job values (-- 직원번호, 비용 세부 번호, 지불번호 
    3,5,13,5 --김상담의 외부교육/세미나비 100000
);
insert into cost_to_details_to_pay_job values (-- 직원번호, 비용 세부 번호, 지불번호 
    4,6,14,4 --김개발의 우수사원해외연수 
);

-- 조인테스트
select * from cost c 
    inner join cost_Details cd
    on c.cno = cd.cno;
select * from emp e
    inner join cost_to_details_to_pay cdp
    on e.eno = cdp.eno;
select * from emp e
    inner join cost_to_details_to_pay cdp
    on e.eno = cdp.eno
    inner join cost_details cd
    on cd.cdno = cdp.cdno;
insert into year_in_cost values (
    seq_year_in_cost.nextval, 1, 3, 2020 , 15000,15000,15000,15000,15000,15000,15000,15000,15000,15000,15000,15000
);
insert into year_in_cost values (
    seq_year_in_cost.nextval, 1, 4, 2020 , 20000,20000,20000,20000,20000,20000,20000,20000,20000,20000,20000,20000
);
insert into year_in_cost values (
    seq_year_in_cost.nextval, 2, 2, 2020 , 15000,15000,15000,15000,15000,15000,15000,15000,15000,15000,15000,15000
);
insert into year_in_cost values (
    seq_year_in_cost.nextval, 2, 3, 2020 , 10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000
);
insert into year_in_cost values (
    seq_year_in_cost.nextval, 3, 5, 2020 , 100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000
);
insert into year_in_cost values (
    seq_year_in_cost.nextval, 4, 6, 2020 , 150000,150000,150000,150000,150000,150000,150000,150000,150000,150000,150000,150000
);
select dname, cname, cdname, jname, ename,
    sum(jan) as "1월 총계" , sum(feb) as "2월 총계", sum(mar) as "3월 총계", sum(apr) as "4월 총계", sum(may) as "5월총계", sum(jun) as "6월 총계", sum(jul) as "7월 총계", sum(aug) as "8월 총계", sum(sep) as "9월 총계", sum(oct) as "10월 총계", sum(nov) as "11월 총계", sum(dec) as "12월 총계" 
    from emp e
    inner join dept d
    on d.dno = e.dno
    inner join cost_to_details_to_pay_job cdpj
    on e.eno = cdpj.eno
    inner join job j
    on j.jno = cdpj.jno
    inner join cost_details cd
    on cd.cdno = cdpj.cdno
    inner join cost c
    on c.cno = cd.cno
    inner join year_in_cost yic
    on e.eno = yic.eno and cd.cdno = yic.cdno
    group by d.dname, c.cname, cd.cdname, j.jname, e.ename
    order by cd.cdname;s