
-- 직군에 따른 급여에 따른 연도별 추이
SELECT S.*, J.*, SIY.* FROM SALARY_JOB_SALARYDETAIL SJS
    LEFT OUTER JOIN SALARY S
    ON S.S_NO = SJS.S_NO
    LEFT OUTER JOIN JOB J
    ON J.J_NO = SJS.J_NO
    LEFT OUTER JOIN SALARY_IN_YEAR SIY
    ON SIY.SIY_NO = SJS.SIY_NO;