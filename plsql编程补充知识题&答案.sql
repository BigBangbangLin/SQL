--1.0 编程实现1-100偶数和的实现

DECLARE
  V_SUM NUMBER := 0;
BEGIN
  FOR I IN 1 .. 100
  LOOP
    IF (I MOD 2 = 0)
    THEN
      --DBMS_OUTPUT.PUT_LINE(I);
      V_SUM := V_SUM + I;
    END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(V_SUM);
END;

-- 2.0 编写一个程序块，找出 100-200 之间所有的质数
/*
  质数：只能被1或者本身整除的整数，排除1    循环遍历
*/

DECLARE
  V_FLAG NUMBER;  -- 记录是否被整除的标识，0代表非质数，1代表质数
BEGIN
  FOR X IN 100..200 LOOP
    -- 外部循环第1次 X = 100
    -- 外部循环第2次 X = 101
    -- 外部循环第3次 X = 102
    -- 外部循环第4次 X = 103
    -- 查找比X本身小的数据的整除情况
    FOR Y IN 2..(X - 1) LOOP   -- 2..102
      -- 外1 内1 Y = 2
      -- 外2 内1 Y = 2
      -- 外2 内2 Y = 3
      ....
      -- 外2 内99 Y = 100
      -- 外3 内1 Y = 2
      -- 外4 内1 Y = 2
      IF MOD(X,Y) = 0 THEN
        
        V_FLAG := 0;
        
        EXIT;
        
      ELSE 
        
        V_FLAG := 1;
        
      END IF;
      
    END LOOP;  

    -- 如果是质数就打印，不是就不打印
    IF V_FLAG = 1 THEN
      DBMS_OUTPUT.PUT_LINE(X);
    END IF;
  END LOOP;
END;



-- 3.0 编写一个程序块，输入数字 N，打印N 的阶乘【即1*2*3*...*N 的结果】
DECLARE
  V_N NUMBER := &请输入数字;
  V_RESULT NUMBER := 1;
BEGIN
  FOR X IN 1..V_N LOOP
    V_RESULT := V_RESULT * X;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE(V_RESULT);
END;


-- 4.0 创建一个函数，传入两个数字，返回较大的数字 
CREATE OR REPLACE FUNCTION FUNC_4(P_NUM_1 NUMBER,P_NUM_2 NUMBER)
RETURN NUMBER
IS
  
BEGIN
  IF P_NUM_1 > P_NUM_2 THEN
    RETURN P_NUM_1;
  ELSE
    RETURN P_NUM_2;
  END IF;
END;



--5.0 使用FOR循环，打印99乘法口诀表 
DECLARE 
  X  NUMBER ;
  Y  NUMBER ;
BEGIN 
  FOR  X IN 1..9 LOOP
    FOR Y IN 1..X LOOP
      DBMS_OUTPUT.PUT(X||'*'||Y||'='||X*Y||' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE();
  END LOOP ;
END ;

DECLARE 
  X  NUMBER ;
  Y  NUMBER ;
BEGIN 
  FOR  X IN 1..9 LOOP
    FOR Y IN X..9 LOOP
      DBMS_OUTPUT.PUT(X||'*'||Y||'='||X*Y||' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE();
  END LOOP ;
END ;







-- 6.0 编程程序块，往TEST1（ID，ENAME）中插入1000条数据，每100条提交一次 

-- 方式一：
DECLARE
BEGIN
  FOR X IN 1 .. 10 LOOP
    FOR Y IN 1 .. 100 LOOP
      INSERT INTO TEST1 VALUES (TO_NUMBER(X || Y), '名字' || X || Y);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('第'||X||'次成功插入100条数据');
    COMMIT;
  END LOOP;
END; 

SELECT * FROM TEST1;
TRUNCATE TABLE TEST1;

-- 方式二：
BEGIN
  FOR X IN 1 .. 1000 LOOP
    INSERT INTO TEST1 VALUES (X, '张三'||X);
    IF MOD(X, 100) = 0 THEN  -- 分桶
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('第' || X || '次成功插入100条数据');
    END IF;
  END LOOP;
END;




--6.0 编写一个程序块，打印所有部门的名称
-- 方式一：隐氏游标
DECLARE
  CURSOR C_DEPT IS(
    SELECT  DEPTNO,DNAME FROM DEPT);
BEGIN
  FOR X IN C_DEPT LOOP
    DBMS_OUTPUT.PUT_LINE('部门编号:'||X.DEPTNO || ' 部门名称:' ||X.DNAME);
  END LOOP;
END;


-- 方式二：显示游标方式
 DECLARE
   CURSOR C_DEPT IS(
     SELECT DEPTNO, DNAME FROM DEPT);
   V_DEPT C_DEPT%ROWTYPE;
 
 BEGIN
   OPEN C_DEPT;
   LOOP
     FETCH C_DEPT
       INTO V_DEPT.DEPTNO, V_DEPT.DNAME;
     EXIT WHEN C_DEPT%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE('部门编号:' || V_DEPT.DEPTNO || ' 部门名称:' || V_DEPT.DNAME)   
   END LOOP; 
   CLOSE C_DEPT;
 END;

 
-- 方式三：自定义函数
CREATE OR REPLACE FUNCTION FUN_DEPTNO_DNAME(P_DEPTNO IN NUMBER)
  RETURN VARCHAR2 IS
  V_DNAME VARCHAR2(20);
BEGIN
  SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = P_DEPTNO;
  RETURN V_DNAME;
  END;-- 输入部门编号，返回部门名称

DECLARE
  CURSOR C_DEPTNO IS(
    SELECT DISTINCT DEPTNO FROM DEPT);
BEGIN
  FOR X IN C_DEPTNO LOOP
    DBMS_OUTPUT.PUT_LINE('部门编号:'||X.DEPTNO || ' 部门名称:' || FUN_DEPTNO_DNAME(X.DEPTNO));
  END LOOP;
END;



--7.0 编写自定义函数，实现传入身份号，判断年龄，如果年龄小于30，返回青年人，如果年龄在    30-55之间 是中年人，其他年龄是老年人

CREATE OR REPLACE FUNCTION CARDID (P_CARID  VARCHAR2)
RETURN  VARCHAR2
  IS

 V_CARID VARCHAR2(50):=P_CARID;
  V_FLAG  VARCHAR2(50);
BEGIN
  SELECT
         CASE
           WHEN T.NL <= 30 THEN
            '精英' 
             WHEN T.NL > 30 THEN
            '老年人'
         END AS FLAG   INTO V_FLAG
    FROM （SELECT

         (MONTHS_BETWEEN(SYSDATE,
                         TO_DATE(SUBSTR(V_CARID, 7, 8),
                                 'YYYY-MM-DD')) / 12) NL

    FROM DUAL) T;
  -- DBMS_OUTPUT.PUT_LINE(V_FLAG);
  RETURN  V_FLAG;
END;




--8.0 编写自定义函数，要求输入的参数能支持字符类型的数据，实现对日期进行判断，如果日期的天数大于15号，就取下个月的年和月，如果日期小于等于15号，就取当月的年和月
CREATE OR REPLACE FUNCTION F_RETURN_TIME(P_DATE VARCHAR2)
RETURN VARCHAR2
IS
 V_DATE DATE:= TO_DATE(P_DATE,'yyyymmdd');
 V_DAY VARCHAR2(10);
 V_YM VARCHAR2(10);
BEGIN
   V_DAY:= TO_CHAR(V_DATE,'dd');
   IF V_DAY > 15 THEN 
     V_YM:= TO_CHAR(ADD_MONTHS(V_DATE,1),'yyyymm');
     RETURN V_YM;
   ELSE 
     V_YM:= TO_CHAR(V_DATE,'yyyymm');
     RETURN V_YM;
   END IF;
END;

















 
