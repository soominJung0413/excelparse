drop table Salary_Type;
drop table Occupant;
drop table salary_Type_chain_Occupant;
drop table Monthly_Salary;


-- 급여종류
create table Salary_Type (
    S_no number primary Key,
    s_type VARCHAR2(255)
);
-- 더미데이터
insert into Salary_type values(
    (select nvl(max(s_no),0) +1 from salary_type) , '기본금'
);
insert into Salary_type values(
    (select nvl(max(s_no),0) +1 from salary_type) , '상여금'
);
insert into Salary_type values(
    (select nvl(max(s_no),0) +1 from salary_type) , '파견금'
);
insert into Salary_type values(
    (select nvl(max(s_no),0) +1 from salary_type) , '보조금'
);

-- 직종 
create table Occupant (
 O_no number primary key,
 O_type varchar2(255)
);
-- 더미 데이터
insert into occupant values (
    (select nvl(max(o_no),0) +1 from occupant) , '상담직'
);
insert into occupant values (
    (select nvl(max(o_no),0) +1 from occupant) , '재무직'
);
insert into occupant values (
    (select nvl(max(o_no),0) +1 from occupant) , '파견직'
);
insert into occupant values (
    (select nvl(max(o_no),0) +1 from occupant) , '기술직'
);

-- 중간 테이블
create table salary_Type_chain_Occupant (
 s_no number,
 o_no number,
 ms_no number,
 CONSTRAINT fk_Salary_Type foreign key(s_no)  REFERENCES Salary_Type(s_no),
 CONSTRAINT fk_Occupant foreign key(o_no) REFERENCES Occupant(o_no),
 CONSTRAINT fk_Monthly_Salary foreign key(ms_no) REFERENCES Monthly_Salary(ms_no),
 primary key (s_no,o_no,ms_no)
);
-- 더미데이터
insert into salary_Type_chain_Occupant values (
    1,2,1
);
insert into salary_Type_chain_Occupant values (
    4,2,2
);

-- 급여 직군 별 월급여
create table Monthly_Salary (
    ms_no number PRIMARY key,
    jan number(20,0) default 0,
    Feb number(20,0) default 0,
    Mar number(20,0) default 0,
    Apr number(20,0) default 0,
    May number(20,0) default 0,
    Jun number(20,0) default 0,
    Jul number(20,0) default 0,
    Aug number(20,0) default 0,
    Sep number(20,0) default 0,
    Oct number(20,0) default 0,
    Nov number(20,0) default 0,
    Dec number(20,0) default 0
);
-- 더미데이터
insert into Monthly_Salary values(
			1, 1000, 2000, 1700, 1500, 1300, 2100, 2200, 1000, 1900, 2300, 1200, 1000
		);
insert into Monthly_Salary values(
	2, 1000, 2000, 1700, 1500, 1300, 2100, 2200, 1000, 1900, 2300, 1200, 1000
);


-- 최종 확인 조인 데이터
select st.s_no, st.s_type,o.o_type,ms.* from salary_type st
        left outer join salary_type_chain_occupant sco
        on st.s_no = sco.s_no
        left outer join occupant o
        on sco.o_no = o.o_no
        left outer join monthly_salary ms
        on sco.ms_no = ms.ms_no;
        
commit;