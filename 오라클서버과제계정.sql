-- 1번
SELECT
       DEPARTMENT_NAME "학과 명"
     , CATEGORY 계열
  FROM TB_DEPARTMENT;   

-- 2번
SELECT 
       DEPARTMENT_NAME || '의 정원은'
     , CAPACITY || '명 입니다'
  FROM TB_DEPARTMENT;   

-- 3번
-- 조건 : 국어국문학과에 다니는 여학생 + 휴학중
SELECT
       STUDENT_NAME
  FROM TB_STUDENT
 WHERE SUBSTR(STUDENT_SSN, 8, 1) = '2'
   AND ABSENCE_YN = 'Y'
   AND DEPARTMENT_NO = '001';

-- 4번
SELECT
       STUDENT_NAME
  FROM TB_STUDENT
 WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119'); 

-- 5번
SELECT
       DEPARTMENT_NAME
     , CATEGORY
  FROM TB_DEPARTMENT
 WHERE CAPACITY BETWEEN 20 AND 30; 

-- 6번
SELECT
       PROFESSOR_NAME
  FROM TB_PROFESSOR
 WHERE DEPARTMENT_NO IS NULL; 

-- 7번
SELECT
       STUDENT_NAME
  FROM TB_STUDENT
 WHERE DEPARTMENT_NO IS NULL;
 
-- 8번 
SELECT
       CLASS_NO
  FROM TB_CLASS
  WHERE PREATTENDING_CLASS_NO IS NOT NULL;
  
-- 9번
SELECT
       DISTINCT(CATEGORY)
  FROM TB_DEPARTMENT;    

-- 10번
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , STUDENT_SSN
  FROM TB_STUDENT
 WHERE ENTRANCE_DATE = '02/03/01'
   AND STUDENT_ADDRESS LIKE '%전주%'
   AND ABSENCE_YN = 'N';

-- 함수 1번
SELECT
       STUDENT_NO 학번
     , STUDENT_NAME 이름
     , TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
  FROM TB_STUDENT
 WHERE DEPARTMENT_NO = 002 
 ORDER BY ENTRANCE_DATE ASC;
 
-- 함수 2번
SELECT
       PROFESSOR_NAME
     , PROFESSOR_SSN
  FROM TB_PROFESSOR
 WHERE NOT PROFESSOR_NAME LIKE '___'
 ORDER BY PROFESSOR_SSN ASC;          
           
-- 함수 3번
SELECT
       PROFESSOR_NAME 교수이름
     , ((SUBSTR(SYSDATE, 1, 2) + 2000) - (SUBSTR(PROFESSOR_SSN,1,2)+ 1900))-1 AS 나이
  FROM TB_PROFESSOR
 WHERE SUBSTR(PROFESSOR_SSN,8, 1) = '1'
 ORDER BY 나이 ASC;
 
-- 함수 4번 
SELECT
       SUBSTR(PROFESSOR_NAME, 2) 이름
  FROM TB_PROFESSOR;
 
    
       
 -- 함수 5번
 -- 82 , 00 재수 아님
 -- 입학년도 - 생년  =  18 (재수 아님)
SELECT
       STUDENT_NO
     , STUDENT_NAME
  FROM TB_STUDENT   
 WHERE TO_CHAR(TO_DATE(ENTRANCE_DATE, 1, 2), 'RRRR')  - TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR'), 'RRRR');        
           
-- (SUBSTR(ENTRANCE_DATE, 1, 2)+ 2000) - (SUBSTR(STUDENT_SSN, 1, 2)+ 1900) <> 18; 
-- 위 식의 값은 내 생각에 2000년 생 이후 재수생은 구했으나. 1900년 대 학생들의 재수생 정보는 구하지 못함.
           
           
-- 함수 6번
-- 2020 년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'DAY') FROM DUAL;
           
           
-- 함수 7번
-- TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')  은 각각 몇 년 몇 
-- 월 몇 일을 의미할까? 
-- 또 TO_DATE('99/10/11','RR/MM/DD'), 
-- TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까?
-- 1번 2099년 2번 2049년
-- 3번 1999년 4번 1999년
           
-- 함수 8번
SELECT
       STUDENT_NO
     , STUDENT_NAME
  FROM TB_STUDENT
 WHERE STUDENT_NO NOT LIKE 'A%';
 
           
-- 함수 9번
SELECT
       ROUND(AVG(POINT), 1) 평점
  FROM TB_GRADE
 WHERE STUDENT_NO = 'A517178';
 
-- 함수 10번
SELECT
       DEPARTMENT_NO 학과번호
     , CAPACITY "학생수(명)"
  FROM TB_DEPARTMENT;   
       
-- 함수 11번
SELECT
       COUNT(*)
  FROM TB_STUDENT
 WHERE COACH_PROFESSOR_NO IS NULL; 

-- 함수 12번 
SELECT
       SUBSTR(TERM_NO,1 ,4) 년도       
     , ROUND(AVG(POINT),  1) "년도 별 평점"
  FROM TB_GRADE
 WHERE STUDENT_NO = 'A112113'
 GROUP BY SUBSTR(TERM_NO,1 ,4);

---------------------------------------------------------------
-- 함수 13번 !!
SELECT
       DEPARTMENT_NO 학과코드명
     , COUNT(ABSENCE_YN) 
  FROM TB_STUDENT
 WHERE ABSENCE_YN = 'Y'
 GROUP BY DEPARTMENT_NO
 ORDER BY DEPARTMENT_NO ASC;

-- 함수 14번 !!
SELECT
       STUDENT_NAME 동명이인
     , COUNT(STUDENT_NAME)
  FROM TB_STUDENT  
 GROUP BY STUDENT_NAME;

-- 함수 15번  
SELECT
       SUBSTR(TERM_NO,1 ,4) 년도
     , SUBSTR(TERM_NO,5, 2) 학기
     , ROUND(AVG(POINT),  1) 평점
  FROM TB_GRADE
 WHERE STUDENT_NO = 'A112113'
 GROUP BY ROLLUP(SUBSTR(TERM_NO,1 ,4), SUBSTR(TERM_NO,5, 2));
------------------------------------------------------------------------
-- OPTION 1
SELECT
       STUDENT_NAME "학생 이름"
     , STUDENT_ADDRESS 주소지
  FROM TB_STUDENT
 ORDER BY STUDENT_NAME ASC;

-- OPTION 2
SELECT
       STUDENT_NAME 이름
     , STUDENT_SSN 나이
  FROM TB_STUDENT
 WHERE ABSENCE_YN = 'Y'
 ORDER BY 나이 DESC;

-- OPTION 3
SELECT
       STUDENT_NAME 학생이름
     , STUDENT_NO 학번
     , STUDENT_ADDRESS "거주지 주소"
  FROM TB_STUDENT
 WHERE STUDENT_NO NOT LIKE 'A%' 
   AND STUDENT_ADDRESS LIKE '경기도%'
    OR STUDENT_ADDRESS LIKE '강원도%'
 ORDER BY 학생이름 ASC;  

-- OPTION 4
SELECT
       P.PROFESSOR_NAME
     , P.PROFESSOR_SSN  
  FROM TB_PROFESSOR P 
  JOIN TB_DEPARTMENT D ON(D.DEPARTMENT_NO = P.DEPARTMENT_NO)
 WHERE D.DEPARTMENT_NO = '005' ;
  
-- OPTION 5
SELECT
       STUDENT_NO
     , POINT
  FROM TB_GRADE
 WHERE CLASS_NO = 'C3118100'
   AND SUBSTR(TERM_NO, 4, 3) = '402' 
 ORDER BY POINT DESC, STUDENT_NO ASC;

-- OPTION 6
SELECT
       S.STUDENT_NO
     , S.STUDENT_NAME
     , D.DEPARTMENT_NAME
  FROM TB_STUDENT S
  JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
 ORDER BY STUDENT_NAME ASC; 

-- OPTION 7
SELECT  
       C.CLASS_NAME
     , D.DEPARTMENT_NAME
  FROM TB_CLASS C
  JOIN TB_DEPARTMENT D ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO);
  
-- OPTION 8  
SELECT
       C.CLASS_NAME
     , P.PROFESSOR_NAME
  FROM TB_CLASS C
  JOIN TB_PROFESSOR P ON (C.DEPARTMENT_NO = P.DEPARTMENT_NO);
  
-- OPTION 9
SELECT
       C.CLASS_NAME
     , P.PROFESSOR_NAME
  FROM TB_PROFESSOR P
  JOIN TB_CLASS C ON (C.DEPARTMENT_NO = P.DEPARTMENT_NO)
  JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
 WHERE CATEGORY = '인문사회'; 
  
-- OPTION 10
SELECT
       S.STUDENT_NO
     , S.STUDENT_NAME
     , ROUND(AVG(POINT), 1)
  FROM TB_STUDENT S
  JOIN TB_GRADE G ON (G.STUDENT_NO = S.STUDENT_NO)
  JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
 WHERE DEPARTMENT_NAME = '음악학과' 
 GROUP BY S.STUDENT_NO, S.STUDENT_NAME;
 
-- OPTION 11
SELECT
       D.DEPARTMENT_NAME
     , S.STUDENT_NAME
     , P.PROFESSOR_NAME
  FROM TB_STUDENT S
  JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
  JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
 WHERE STUDENT_NO = 'A313047';
  
  
  
  
  
  