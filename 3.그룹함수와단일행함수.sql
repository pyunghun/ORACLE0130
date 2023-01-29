-- 그룹함수와 단일행함수
-- 단일행 함수(SINGLE ROW FUNCTION): N개의 값을 넣어 N개의 결과를 리턴

-- 그룹 함수(GROUP FUNCTION) : N개의 값을 넣어 1개의 결과를 리턴

-- 그룹 함수 : SUM, AVG, MAX, MIN, COUNT 
-- SUM(숫자) : 합계를 구해서 리턴
SELECT
       SUM(SALARY)
  FROM EMPLOYEE;     
-- AVG(숫자) : 평균을 구해서 리턴
SELECT
       AVG(SALARY)
  FROM EMPLOYEE;     
-- MIN(숫자, 문자, 날짜) : 가장 작은 값을 반환
SELECT
       MIN(EMAIL)
     , MIN(HIRE_DATE)
     , MIN(SALARY)
  FROM EMPLOYEE;   

-- MAX(숫자, 문자, 날짜) : 가장 큰 값을 반환
SELECT
       MAX(EMAIL)
     , MAX(HIRE_DATE)
     , MAX(SALARY)
  FROM EMPLOYEE;

-- 이 값은 값이 들어있는 열의 값만 구한 것이다
-- 즉 NULL(보너스를 받지 않는 사람의 값은 배제한 것)
SELECT
       AVG(BONUS)보너스를받는사람의평균
  FROM EMPLOYEE;     
-- 따라서 정확한 평균을 구하려면 NULL 값을 NVL 함수를 이용하여
-- 0으로 처리한 후 전체의 평균을 구해야 한다.
SELECT
       AVG(NVL(BONUS,0))전체의평균
  FROM EMPLOYEE; 

-- COUNT(* | 컬럼명)
-- COUNT(*) : 모든 행의 수 리턴
-- COUNT(컬럼명) : NULL을 제외한 실제 값이 기록된 행의 수 리턴  
SELECT  
       COUNT(*)
     , COUNT(DEPT_CODE)
     , COUNT(DISTINCT DEPT_CODE)
  FROM EMPLOYEE;   

-- 단일행 함수
-- 문자 관련 함수
-- : LENGTH, LENGTHB, SUBSTR, UPPER, LOWER, INSTR...
SELECT
       LENGTH('오라클')
     , LENGTHB('오라클')
  FROM DUAL;   

SELECT
       LENGTH(EMAIL)
     , LENGTHB(EMAIL)
  FROM EMPLOYEE;     

-- INSTR('문자열' | 컬럼명, '문자열', 찾을 위치의 시작값, [빈도]) 
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 5)FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1, 2)FROM DUAL;

-- EMAIL에서 @의 위치가 어디에 있는지 조회
SELECT
       EMAIL
     , INSTR(EMAIL,'@',-1) 위치
  FROM EMPLOYEE;   

SELECT  
       EMP_NAME
  FROM EMPLOYEE
 WHERE INSTR(EMP_NAME,'하') > 0; 
 
-- 이메일의 @의 앞의 값을 조회
SELECT
       EMAIL
     , EMP_NAME
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
  FROM EMPLOYEE;
  
-- LPAD, RPAD : 주어진 문자열에 임의의 문자열을 덧붙여 길이 N의 문자열을 반환
SELECT
       LPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;    
  
SELECT  
       RPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;     

SELECT
       LPAD(EMAIL, 10)
  FROM EMPLOYEE;     

-- LTRIM / RTRIM : 주어진 컬럼이나 문자열 왼쪽/ 오른쪽에서ㅏ
--                 지정한 문자를 제거한 나머지를 반환하는 함수
SELECT '     GREEDY' FROM DUAL;
SELECT LTRIM('     GREEDY', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
-- 123만 제거하는 것이 아닌 1,2,3을 제거한다.
-- 언제까지? 자르지 못하는 수가 나올때까지
SELECT LTRIM('123123213456', '123') FROM DUAL;

SELECT 'GREEDY   ' FROM DUAL;
SELECT RTRIM('GREEDY   ', ' ') FROM DUAL;

-- 앞에의 띄어쓰기는 쉽게 볼 수 있다. 하지만 뒤에 쓰인 띄어쓰기는
-- 공백인지 띄어쓰기를 한 것인지 판단하기 어렵기 때문에 주의
SELECT
       EMP_ID
     , EMP_NAME
  FROM EMPLOYEE
 WHERE EMP_NAME = RTRIM('선동일 ', ' '); 

-- TRIM : 주어진 컬럼이나 문자열의 앞/뒤에 지정한 문자를 제거
SELECT TRIM(' GREEDY ') FROM DUAL;
-- TRIM 의 기본값은 ' '(공백) 이다.
SELECT TRIM('Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
-- 앞뒤 모두 제거
SELECT TRIM(BOTH '3' FROM '333GREEDY333') FROM DUAL;

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치로부터 지정한 갯수의 문자열 잘라서 리턴
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

-- 여직원의 이름, 주민번호 조회
-- EMPLOYEE 테이블에서 주민번호 8번째 자리가 2 또는 4인 사람의 이름과 주민번호를
-- 조회하세요
SELECT
       EMP_NAME
     , EMP_NO
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1) IN('2','4'); 

-- EMPLOYEE 테이블에서 직원의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생원, 생일로 한다.
SELECT
       EMP_NAME 사원명
     , SUBSTR(EMP_NO, 1, 2) 생년
     , SUBSTR(EMP_NO, 3, 2) 생월
     , SUBSTR(EMP_NO, 5, 2) 생일
  FROM EMPLOYEE;
  
-- EMPLOYEE 테이블에서 직원들의
-- 직원명, 입사년도, 입사월, 입사일을 분리조회

SELECT
       EMP_NAME
     , SUBSTR(HIRE_DATE,1,2)입사년도
     , SUBSTR(HIRE_DATE,4,2)입사월
     , SUBSTR(HIRE_DATE,7,2)입사일
  FROM EMPLOYEE;   


-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 급여 조회
-- WHERE 절은 단일행 함수만 사용이 가능하다
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (SELECT AVG(SALARY)
                      FROM EMPLOYEE
                    );
                    
                        
-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고, '-' 다음 값은 '*'로 바꿔 출력
SELECT
       EMP_NAME
     , RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') 주민번호
  FROM EMPLOYEE;   

-- LOWER, UPPER, INITCAP
SELECT INITCAP('welcome to my world') FROM DUAL;

-- CONCAT
SELECT CONCAT('가나다라','ABCD') FROM DUAL;

-- REPLACE : 컬럼 혹은 문자열을 입력받아 변경하고자 하는 문자열을 
-- 변경하려고 하는 문자열로 바꾼 후 리턴
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동')FROM DUAL;

-- 숫자 처리 함수 : ABS, MOD, ROUND, FLOOR, TRUNC, CELL...
-- ABS(숫자 | 컬럼명) : 절대값을 반환하는 함수
SELECT
       ABS(-10)
     , ABS(10)
  FROM DUAL;   

-- MOD(숫자, 숫자) : 두 수를 나누어서 나머지를 구하는 함수
-- 첫 번째 인자는 나누어지는 수, 두 번째 인자는 나눌 수 있는 수
SELECT
       MOD(10, 5)
     , MOD(10, 3)
  FROM DUAL;
  
-- 사번이 짝수인 직원의 사번, 이름, 급여, 부서코드 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_CODE
  FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2) = 0; 

-- ROUND (숫자, [위치]) : 반올림해서 리턴해주는 함수
SELECT ROUND(123.456) FROM DUAL;

-- FLOOR(숫자) : 내림처리를 한 정수를 반환하는 함수
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(숫자, [위치]) : 내림처리(절삭) 함수
SELECT TRUNC(123.456, 1) FROM DUAL;

-- CEIL(숫자) : 올림처리 함수
SELECT CEIL(123.456) FROM DUAL;

SELECT
       ROUND(123.456)
     , FLOOR(123.456)
     , TRUNC(123.456)
     , CEIL(123.456)
  FROM DUAL;   

-- 날짜 처리 함수 : SYSDATE, MONTHS_BETWEEN
-- , ADD_MONTH, NEXT_DAY, LAST_DAY, EXTRACT

-- SYSDATE : 지금 현재의 날짜를 반환해주는 함수
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN(날짜 , 날짜)
-- 두 날짜의 개월 수 차이를 숫자로 리턴하는 함수
-- 오늘과 입사일 날짜의 개월 수 차이를 나타냄
SELECT
       EMP_NAME
     , HIRE_DATE
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
  FROM EMPLOYEE;   

SELECT
       SYSDATE +1
     , SYSDATE -1
     , SYSDATE - HIRE_DATE
  FROM EMPLOYEE;   

-- ADD_MONTHS( 날짜, 숫자)
-- 날짜에 숫자만큼 개월 수를 더해서 리턴
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;     

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 6개월이 되는 날짜 조회
SELECT
       EMP_NAME
     , HIRE_DATE
     , ADD_MONTHS(HIRE_DATE, 6)
  FROM EMPLOYEE;   

-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
SELECT
       *
  FROM EMPLOYEE
--  WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;
  WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
  
-- NEXT_DAY(기준 날짜, 요일)
-- : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금') FROM DUAL;

-- LAST_DAY(날짜) : 해당 월의 마지막 날짜를 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회하세요\
SELECT
       EMP_NAME
     , HIRE_DATE
     ,(LAST_DAY(HIRE_DATE) - HIRE_DATE) + 1 입사원근무일수
  FROM EMPLOYEE; 

-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 일만 추출
SELECT
       EXTRACT(YEAR FROM SYSDATE) 년도
     , EXTRACT(MONTH FROM SYSDATE) 월
     , EXTRACT(DAY FROM SYSDATE) 일
   FROM DUAL;

-- EMPLOYEE 테이블에서 사원이름, 입사년도, 입사월, 입사일 조회
SELECT  
       EMP_NAME
     , EXTRACT(YEAR FROM HIRE_DATE) 입사년도
     , EXTRACT(MONTH FROM HIRE_DATE) 입사월
     , EXTRACT(DAY FROM HIRE_DATE) 입사일
  FROM EMPLOYEE   
 ORDER  BY EMP_NAME;
-- ORDER BY 1; 의 의미는 1번 컬럼의 별칭을 의미한다.( 입사년도 )

SELECT SYSDATE FROM DUAL;

-- 형변환 함수
-- TO_CHAR (날짜, [포멧]) : 날짜형 데이터를 문자형 데이터로 변경
-- TO_CHAR (숫자, [포멧]) : 숫자형 데이터를 문자형 데이터로 변경

SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL;
-- 모자라는 부분을 포멧 0을 넣어서 리턴
SELECT TO_CHAR(1234, '00000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

-- 직원 테이블에서 사원명, 급여 조회
-- 급여는 '\9,000,000' 형식으로 표시하세요
SELECT
       EMP_NAME
     , TO_CHAR(SALARY, 'L9,999,999')
  FROM EMPLOYEE;
  
-- 날짜형 데이터를 문자형 데이터로 변경하는 방법
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM  DUAL;  
SELECT TO_CHAR(SYSDATE, 'MON, DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q')||'분기' FROM DUAL;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS') 상세입사일
     , TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 입사한글
  FROM EMPLOYEE;   

-- 년도 포멧
SELECT
       TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'RRRR')
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RR')
     , TO_CHAR(SYSDATE, 'YEAR')
  FROM DUAL;   

-- YY와 RR의 차이점
-- RR은 두 자리 년도를 4자리로 바꿀 때
-- 바뀔 년도가 50년 미만인 경우 2000년대를 적용
-- 50년 이상이면 1900년대를 적용한다,
SELECT
       TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY-MM-DD')
     , TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD')
  FROM DUAL;   

-- 월 포멧
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
  FROM DUAL;   

-- 일 포멧
SELECT
       TO_CHAR(SYSDATE, '"1년 기준" DDD "일 째"')
     , TO_CHAR(SYSDATE, '"달 기준" DD "일 째"')
     , TO_CHAR(SYSDATE, '"주 기준" D "일 째"')
  FROM DUAL;   

-- 분기와 요일
SELECT
       TO_CHAR(SYSDATE, 'Q"분기"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;

-- 직원테이블에서 이름, 입사일 조회
-- 입사일에 포멧 적용하여 조회
-- 0000년 0월 00일
SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'RRRR"년" MON DD"일" "("DY")"')
  FROM EMPLOYEE;   

-- TO_DATE : 문자 혹은 숫자형 데이터를 날짜형 데이터로 반환하여 리턴
SELECT
       TO_DATE('20101010', 'RRRRMMDD')
  FROM DUAL;     
 
SELECT
       TO_CHAR(TO_DATE('20101010', 'RRRRMMDD'), 'RRRR, MON')
  FROM DUAL;    

SELECT
       TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
  FROM DUAL;     

-- 직원 테이블에서 2000년도 이후에 입사한 사원의
-- 사번, 이름, 입사일을 조회하세요
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
-- WHERE HIRE_DATE >= '20000101';
 WHERE HIRE_DATE >= TO_DATE('20000101', 'RRRRMMDD');
 
-- TO_NUMBER(문자, [포멧]) : 문자데이터를 숫자로 리턴
SELECT
       TO_NUMBER('12345679')
  FROM DUAL;   

SELECT '123' + '456' FROM DUAL;  
SELECT '123' + '456A' FROM DUAL;

-- 아래 구문은 , 라는 문자열이 포함되어 있기 때문에 숫자 연산이 되지 않는다
-- 따라서 문자를 숫자로 포멧을 한 후 사용하게 된다
SELECT '1,000,000' + '500,000' FROM DUAL;

SELECT
       TO_NUMBER('1,000,000', '999,999,999') + TO_NUMBER('500,000', '999,999,999')
  FROM DUAL;     

-- 직원 테이블에서 사원번호가 201인 사원의 
-- 이름, 주민번호 앞자리, 주민번호 뒷자리, 주민번호 앞자리와 뒷자리의 합을 조회
-- 단, 자동 형변환 사용 않고 조회
SELECT
       EMP_NAME
     , SUBSTR(EMP_NO, 1, 6) 앞자리
     , SUBSTR(EMP_NO, 8, 14) 뒷자리
     , TO_NUMBER(SUBSTR(EMP_NO, 1, 6)) + TO_NUMBER(SUBSTR(EMP_NO, 8)) 합
--     , SUBSTR(EMP_NO, 1, 6) + SUBSTR(EMP_NO, 8, 14) -- 자동형변환 사용
  FROM EMPLOYEE
 WHERE EMP_ID = '201'; 

-- 6번 볼 차례








