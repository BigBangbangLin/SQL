
-------------------第一部分：ORACLE高阶：PL/SQL基本语法&属性数据类型---------------------

#PART1:PLSQL简介
/*
PLSQL语言结合了结构化查询语言SQL和ORACLE自身过程控制为一体的强大的语言
不但支持更多的数据类型，拥有自身的变量声明，赋值语句，还有条件判断、循环等流程控制语句
和SQL语句无缝结合，可以创建存储过程、函数以及程序包

PLSQL语言是一种块结构的语言，将一组语句放在一个块中，一次性发送给服务器，
PLSQL引擎收到块中的内容，把其中的过程控制语句由PLSQL引擎自身执行，SQL语句交给服务器的SQL语句执行

PLSQL的优点：
1.支持SQL
2.支持面向对象编程
   在PLSQL中可以创建类型，可以对类型进行集成，可以在子程序中重载方法等等
3.更好的性能
   SQL是非过程语言，只能一条条执行，而PLSQL是把一个块统一进行编译后执行
   同时还可以把编译好的PLSQL块存储起来，以备重用，减少了应用程序和服务器之间的通信时间
4.可移植性
   使用PLSQL编写的应用程序，可以移植到任何操作平台上的ORACLE服务器，同时可以编写可移植程序库
   在不同的环境中重用
5.安全性
   可以通过存储过程对客户机和服务器之间的应用程序逻辑进行分隔，限制ORACLE数据库的访问，还可以
   授权和撤销其他用户访问的能力
   
   
 基本语法结构：
 DECLARE
     -- 声明变量 ①
  BEGIN
       -- 主要的程序执行过程 ②
  EXCEPTION
       --异常处理  ③
  END;
   
   

*/
  
 
--案例1：打印我们第一个 'HELLO WORLD'

    BEGIN  
       DBMS_OUTPUT.PUT_LINE('HELLO WORLD');   
    END ;

--案例2：使用变量 打印出  HELLO  GIRLS
    DECLARE
        V_STR  VARCHAR2(30);
    BEGIN 
      -- 初始化变量 
      V_STR  := 'HELLO  GIRLS';    -- 在BEGIN 中对变量赋值。
      DBMS_OUTPUT.PUT_LINE(V_STR);
    END ;

--案例3： 接收用户输入的信息，然后打印出来
    DECLARE
       V_STR  VARCHAR2(30) :='&随便输入点内容，就可以打印出来';   -- 定义变量的时候，通过用户输入，给变量赋值。
    BEGIN 
       DBMS_OUTPUT.PUT_LINE(V_STR);
    END ;
    
    
    
-- 案例4：对变量进行重新赋值，并打印出 HELLO WORLD
    DECLARE
       V_STR  VARCHAR2(30) :=&随便输入点内容，就可以打印出来;   -- 定义变量的时候，通过用户输入，给变量赋值。
    BEGIN 
      -- 对变量 V_STR 重新赋值
      V_STR  := 'HELLO WORLD' ;
       DBMS_OUTPUT.PUT_LINE(V_STR);
    END ;
    
    
--案例5： 通过查询的方式 
   --语法格式： SELECT 值   INTO  V_变量  
-- 输入部门编号，打印出该部门的最高工资
   DECLARE
     -- 声明所需的变量
     V_DEPTNO  NUMBER(2) :=&请输入部门编号;   -- 10 
     V_MAXSAL  NUMBER(7,2);
   BEGIN 
     -- 执行过程
        -- 通过 SELECT INTO 的方式给变量赋值
     SELECT  MAX(SAL)
     INTO  V_MAXSAL
     FROM EMP 
     WHERE DEPTNO = V_DEPTNO;   -- V_DEPTNO 相当于我们输入的部门号 10
        -- 打印变量的信息
   DBMS_OUTPUT.PUT_LINE('部门'||V_DEPTNO||'的最高工资是：'||V_MAXSAL);
   END ;
   
 --案例6：查询出工资最高的员工的 姓名 ，工资，部门名称
   DECLARE
   -- 声明变量
      V_ENAME  VARCHAR2(10);
      V_SAL    NUMBER(7,2);
      V_DNAME  VARCHAR2(10);
   BEGIN 
     SELECT ENAME ,SAL ,DNAME 
     INTO V_ENAME,V_SAL,V_DNAME
     FROM (
      SELECT  E.ENAME ,E.SAL ,D.DNAME ,MAX(E.SAL)OVER()  MAXSAL
      FROM EMP E ,DEPT D 
      WHERE E.DEPTNO = D.DEPTNO)
     WHERE SAL = MAXSAL;
   -- 打印 变量 信息
   DBMS_OUTPUT.PUT_LINE(V_ENAME||' '||V_SAL||'  '||V_DNAME);
   END ;
  
--案例7：  声明常量  常量声明之后，在程序中无法被修改
-- CONSTANT     DEFAULT
DECLARE
  PI CONSTANT NUMBER(5,2):=3.14;
  R            NUMBER(2) DEFAULT 3;
  AREA         NUMBER(8,4);
BEGIN
  AREA:=PI*R*R;
  DBMS_OUTPUT.PUT_LINE(AREA);
END;

--案例8：增加异常处理部分：
●1.0 NO_DATA_FOUND
 DECLARE
   V_EMP EMP%ROWTYPE ;
 BEGIN
   SELECT ENAME ,SAL INTO V_EMP.ENAME,V_EMP.SAL FROM EMP  WHERE SAL >100000;
   DBMS_OUTPUT.PUT_LINE (V_EMP.ENAME||V_EMP.SAL);
   
   EXCEPTION
     WHEN NO_DATA_FOUND
       THEN  DBMS_OUTPUT.PUT_LINE ('没找到数据集'); 
  
 END ; 
 
●2.0 TOO_MANY_ROWS
 DECLARE
   V_EMP EMP%ROWTYPE ;
 BEGIN
   SELECT ENAME ,SAL INTO V_EMP.ENAME,V_EMP.SAL FROM EMP  ;
   DBMS_OUTPUT.PUT_LINE (V_EMP.ENAME||V_EMP.SAL);
   
   EXCEPTION
     WHEN TOO_MANY_ROWS
       THEN  DBMS_OUTPUT.PUT_LINE ('返回多条数据'); 
  
 END ; 
 


-- 异常处理：
-- ORACLE常见预定义异常：
/*异常名称           异常码                   描述
DUP_VAL_ON_INDEX  ORA-00001        试图向唯一索引列插入重复值
INVALID_CURSOR    ORA-01001        试图进行非法游标操作。
INVALID_NUMBER    ORA-01722        试图将字符串转换为数字
NO_DATA_FOUND     ORA-01403        语句中没有返回任何记录。
TOO_MANY_ROWS     ORA-01422        语句中返回多于 1 条记录。
ZERO_DIVIDE       ORA-01476        试图用 0 作为除数。
*/



#PART2:属性数据类型
/*
%TYPE:  引用数据库中某列的数据类型
%ROWTYPE： 引用数据库中表的一行（所有字段的数据类型）
*/

--案例1： 输入员工编号，打印出员工的姓名和年薪
DECLARE  
   V_EMPNO  EMP.EMPNO%TYPE;   -- 列名%TYPE ,指定变量的数据类型。
   V_ENAME  EMP.ENAME%TYPE;
   V_NSAL   EMP.SAL%TYPE;
BEGIN 
  V_EMPNO  :=&请输入员工编号 ;
  
  SELECT E.ENAME ,12*( E.SAL + NVL(E.COMM，0))
  INTO V_ENAME ,V_NSAL
  FROM EMP E
  WHERE E.EMPNO = V_EMPNO;
  
  DBMS_OUTPUT.PUT_LINE(V_ENAME|| '的年薪是： '||V_NSAL);
END ;

--案例2：
DECLARE
  V_EMP  EMP%ROWTYPE;     --  ROWTYPE 方式定义变量的数据类型。
BEGIN 
  V_EMP.EMPNO :=&请输入员工编号 ;
  
  SELECT E.ENAME ,12*( E.SAL + NVL(E.COMM，0))
  INTO V_EMP.ENAME ,V_EMP.SAL
  FROM EMP E
  WHERE E.EMPNO = V_EMP.EMPNO;
  
  DBMS_OUTPUT.PUT_LINE( V_EMP.ENAME || '的年薪是： '||V_EMP.SAL );
END ;
 

---------------------第二部分：ORACLE高阶：条件控制&循环控制&游标-----------------------------
#PART1:条件控制
/*
  BEGIN 
   IF 条件 
     THEN 结果 ;
   END IF ;
END ;




BEGIN 
   IF 条件 
     THEN 结果 ;
   ELSE 结果N ;
   END IF ;
END ;


BEGIN 
   IF 条件1 
     THEN 结果1 ;
   ELSIF 条件2
     THEN 结果2
   ELSE 结果N ;
   END IF ;
END ;*/

/*案例1：输入员工的工号，根据员工的部门，给员工加薪，如果部门为10 ，则给员工加薪30% ，20加薪20%，其余部门不加薪。
 使用PLSQL程序块，打印出员工的部门，原工资，加薪后的工资。*/
 DECLARE 
     V_EMPNO  NUMBER(4) :=&输入员工编号;
     V_DEPTNO NUMBER(2);
     V_SAL1   NUMBER(7,2);
     V_SAL2   NUMBER(7,2);
  BEGIN 
    SELECT DEPTNO ,SAL 
    INTO V_DEPTNO  ,V_SAL1
    FROM EMP WHERE  EMPNO = V_EMPNO;
    
     IF   V_DEPTNO  = 10 
       THEN V_SAL2 := V_SAL1  *1.3 ;
      /* DBMS_OUTPUT.PUT_LINE('员工的部门:'||V_DEPTNO  ||',原工资:'|| V_SAL1 ||',加薪后的工资:'||V_SAL2 );*/
     ELSIF V_DEPTNO = 20 
       THEN V_SAL2 := V_SAL1 *1.2 ;
      /* DBMS_OUTPUT.PUT_LINE('员工的部门:'||V_DEPTNO  ||',原工资:'|| V_SAL1 ||',加薪后的工资:'||V_SAL2 );*/
     ELSE 
       V_SAL2  :=   V_SAL1 ;
      /* DBMS_OUTPUT.PUT_LINE('员工的部门:'||V_DEPTNO  ||',原工资:'|| V_SAL1 ||',加薪后的工资:'||V_SAL2 );*/
     END IF ;

   DBMS_OUTPUT.PUT_LINE('员工的部门:'||V_DEPTNO  ||',原工资:'|| V_SAL1 ||',加薪后的工资:'||V_SAL2 );
  END ;
     
 --案例2：另外一种写法 通过 CASE WHEN 或者 DECODE() 实现
SELECT E.EMPNO ,E.SAL AS SAL1 ,DECODE(E.DEPTNO,10,E.SAL*1.3,20,E.SAL*1.2,E.SAL) SAL2,
      CASE E.DEPTNO WHEN 10 THEN  E.SAL*1.3
           WHEN 20 THEN E.SAL*1.2
           ELSE  E.SAL  END SAL3
FROM EMP E
WHERE E.EMPNO = V_EMPNO;

#PART2:循环控制
/*--循环控制
直接循环 
    BEGIN
      LOOP  
       循环体  ;
       终止循环的条件 ;
      END LOOP  ;
    END ;

WHILE 循环 
    BEGIN 
      WHILE 条件 LOOP
        

      END  LOOP;
    END ;


FOR 循环
  BEGIN 
    FOR X IN  1..10 LOOP

    END LOOP;
  END;*/
  
  
-- 执行1+2+3+…+10的值

--案例1：使用LOOP循环实现
DECLARE 
   X  NUMBER(5) := 1 ;
   Y  NUMBER(5) := 0 ;
BEGIN 
/*  DBMS_OUTPUT.PUT_LINE(X||' '||Y);
  DBMS_OUTPUT.PUT_LINE('LOOP循环开始:');*/
  LOOP 
   Y := X + Y ;
   X := X +1 ; 
    -- 终止循环的条件 有 ① 和 ② 2种写法。
    IF X > 10 THEN    --①   -- 常规的退出循环的写法
      EXIT;  -- 退出循环  
    END IF;
    -- EXIT WHEN  X > 10 ; -- ②   简写  ，跟 ①的效果一样的。
    --DBMS_OUTPUT.PUT_LINE('  '||X||' '||Y);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('循环结束');
  DBMS_OUTPUT.PUT_LINE('1~10的累加结果为：'||Y);
END ;

--案例2：使用WHILE循环实现
DECLARE
   X   NUMBER(5) := 0;
   Y   NUMBER(5) := 0;
BEGIN
  WHILE X < 100 LOOP
    X   := X + 1;
    Y := X + Y;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('RESULT IS :' || Y);
END;

--案例3：FOR 循环
DECLARE
  X    NUMBER(3) := 0;
  Y    NUMBER := 0;
BEGIN
  FOR X IN 1 .. 100 LOOP 
    Y := Y + X;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('RESULT IS :' || Y);
END;


-- 案例4：打印乘法口诀表
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


#PART3：游标
/*
游标跟踪结果集中的位置，并允许对结果集逐行执行多个操作
换句话说，游标从概念上讲，是指基于数据库的表返回的结果集
由于他指示结果集中的当前位置，就像计算机屏幕上的光标指示当前位置一样
【游标】由此得名

【游标】的作用
1.指定结果集中特定的行的位置
2.基于当前的结果集位置检索一行或者连续的行
3.在结果集的当前位置修改行中的数据
*/

-- 【1】   【（1，2，3）】
-- 【（1，2，3），（1，2，3），（1，2，3）（）（）（）】

-- 语法结构
DECLARE
  CURSOR 游标名[参数 数据类型] IS (SELECT 语句);  -- 声明游标
BEGIN
  -- 显式游标
  OPEN 游标名[实际参数];   -- 打开游标
  FETCH 游标 INTO 变量名; -- 提取数据
    -- 代码块;
  CLOSE 游标名;            -- 关闭游标
END;


-- 查询EMP表  显示   员工号为：XXX，姓名是：XXX，职位是：XXXX
DECLARE
  CURSOR C_EMP IS (SELECT EMPNO,ENAME,JOB FROM EMP);  -- 声明游标
  V_EMPNO EMP.EMPNO%TYPE;
  V_ENAME EMP.ENAME%TYPE;
  V_JOB   EMP.JOB%TYPE;
BEGIN
  -- 显式游标
  OPEN C_EMP;  -- 打开游标
  LOOP 
    FETCH C_EMP INTO V_EMPNO,V_ENAME,V_JOB;   -- 提取数据
    EXIT WHEN C_EMP%NOTFOUND;  -- 当游标循环结束后退出循环
    DBMS_OUTPUT.PUT_LINE('员工号为：'||V_EMPNO||'，姓名是：'||V_ENAME||'，职位是：'||V_JOB);    
  END LOOP;
  CLOSE C_EMP;      -- 关闭游标
END;



-- 隐式游标
DECLARE
  CURSOR 游标名[参数 数据类型] IS (SELECT 语句);  -- 声明游标
BEGIN
  FOR X IN 游标名 LOOP
    -- 代码块
  END LOOP;
END;


-- 查询EMP表  显示   员工号为：XXX，姓名是：XXX，职位是：XXXX
DECLARE
  CURSOR C_EMP IS (SELECT EMPNO,ENAME,JOB FROM EMP);  -- 声明游标
BEGIN
  -- 隐式游标
  FOR X IN C_EMP LOOP 
    DBMS_OUTPUT.PUT_LINE('员工号为：'||X.EMPNO||'，姓名是：'||X.ENAME||'，职位是：'||X.JOB);    
  END LOOP;
END;


---带参游标
DECLARE
  CURSOR C_EMP( V_EMPNO NUMBER) IS (SELECT EMPNO,ENAME,JOB FROM EMP WHERE EMPNO=V_EMPNO);  -- 声明游标
BEGIN
  -- 隐式游标
  FOR X IN C_EMP(7369) LOOP 
    DBMS_OUTPUT.PUT_LINE('员工号为：'||X.EMPNO||'，姓名是：'||X.ENAME||'，职位是：'||X.JOB);    
  END LOOP;
END;





-- 游标的优点和缺点
/*
优点----------------
常见用途：保存查询的结果，方便以后使用
1.游标的结果集由SELECT语句产生，如果处理过程需要重复使用一个记录，那么创建一个游标而重复使用多次，
比重复查询数据库要快得多
2.大部分程序数据设计语言，都能都使用游标来检索SQL数据库中的数据，在程序中嵌入游标和在程序中嵌入SQL语句相同

缺点------------------
1.因为数据量大，而且整个系统上跑的不止我们一个业务，所以我们都会要求尽量避免使用游标。
   游标使用的时候，会对行加锁，可能会影响其他业务的正常进行，而且数据量大的时候，效率也很低
2.内存也是一个限制，游标相当于把磁盘数据写入内存中，如果数据过大，则会造成内存不足，
   所以只有数据量小的时候，才使用游标
*/


--------------------------第三部分：ORACLE高阶：存储过程&存储函数-----------------------------------
#PART1:基本语法
-- 创建存储过程和自定义函数的语法：
CREATE OR REPLACE PROCEDURE SP_过程名(参数1 [IN|OUT|IN OUT] 数据类型，参数2 [IN|OUT|IN OUT] 数据类型……)
IS   /*|AS*/
BEGIN  
  执行体
END ;

CREATE OR REPLACE FUNCTION FUN_函数名(参数1 数据类型，参数2，[IN|OUT|IN OUT] 数据类型……)
RETURN 返回的数据类型,不写长度
IS   /*|AS*/
BEGIN  
   执行体
   RETURN  结果； --里面必须要有一个RETURN子句
END ; 

-- 过程和函数的参数类型 [IN|OUT|IN OUT]
/*    IN 类型为 输入参数,默认参数，可以不写。【不能重新赋值】
   OUT 类型为 输出参数。【可以被重新赋值，但是不会接受输入的参数】
   IN OUT 类型为输入输出参数，既可以接受传入的值，也可以作为输出参数输出结果。【可以被重新赋值】 */

1.0  存储过程：
------------------------------------------  IN  参数 ----------------------------------------------          
/*定义一个存储过程  使用 in 参数类型实现， 
接收员工的 编号，打印出员工的姓名*/
-- 创建存储过程
CREATE OR REPLACE PROCEDURE SP_EMP(P_EMPNO IN NUMBER)
IS
 
   V_NAME  VARCHAR2(8);
BEGIN
   SELECT ENAME
   INTO V_NAME
   FROM  EMP E
   WHERE E.EMPNO =  P_EMPNO;

   DBMS_OUTPUT.PUT_LINE(V_NAME);
END ;

-- 调用存储过程
BEGIN 
  SP_EMP(7369);
END ;
   




------------------------------------------ OUT 参数 ---------------------------------------------
  类型为 输出参数。【可以被重新赋值，但是不会接收任何 传入/输入的值】
     并且，一旦定义了 OUT 类型的参数，调用过程时，必须传入一个 变量，不传会报错。
CREATE OR REPLACE PROCEDURE SP_HELLOWORLD (P_STR  OUT VARCHAR2)
IS 
BEGIN 
  P_STR := '不听不听，除非买包';
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
  DBMS_OUTPUT.PUT_LINE('HELLO '||P_STR);
END ;

DECLARE
  V_STR  VARCHAR2(30) := '包太贵，买口红吧' ;
BEGIN 
  SP_HELLOWORLD(V_STR);
END ;

----------------------------------------- IN  OUT 参数 ----------------------------------------
  IN OUT 类型的参数，既可以接收传入的值 ，又可以把该参数作为 输出的对象
-- 比如 接收员工的姓名，打印出该员工的 岗位

CREATE OR REPLACE PROCEDURE  SP_ENAME_JOB(P_NAME_JOB   IN  OUT  VARCHAR2)
IS 
   -- 这里不需要单独定义输出的变量。因为可以对 输入输出参数重新赋值。
BEGIN 
  SELECT JOB 
  INTO  P_NAME_JOB   -- 对 out 类型的参数进行重新赋值，并最后打印出来
  FROM EMP 
  WHERE ENAME = P_NAME_JOB;   -- 使用参数接收的姓名作为条件
  
  DBMS_OUTPUT.PUT_LINE(P_NAME_JOB);
END ;

DECLARE
  V_ENAME  VARCHAR2(10) :='SCOTT';
BEGIN 
  SP_ENAME_JOB(V_ENAME);
END ;

    /*对比 IN 类型的参数*/
CREATE OR REPLACE PROCEDURE  SP_JOB(P_NAME  VARCHAR2)
IS 
   V_JOB  VARCHAR2(10);
BEGIN 
  SELECT JOB
  INTO V_JOB
  FROM EMP 
  WHERE ENAME = P_NAME;
  DBMS_OUTPUT.PUT_LINE(V_JOB);
END ;

BEGIN 
  SP_JOB('SCOTT');
END ;


--- 2.0  自定义函数：
/*定义一个自定义函数  使用 in 参数类型实现， 
接收员工的 编号，返回员工的社保缴纳日期，显示为字符格式 （YYYY-MM）*/
CREATE OR REPLACE FUNCTION FUN_EMP(P_EMPNO IN NUMBER)
RETURN   VARCHAR2
IS 
  V_JD  VARCHAR2(8);
BEGIN  
  SELECT TO_CHAR( ROUND(E.hiredate,'MM')  ,'YYYY-MM') 
  INTO V_JD
  FROM EMP E
  WHERE E.empno = P_EMPNO;
  
  RETURN V_JD;
END ;
-- 调用自定义函数
SELECT E.* ,FUN_EMP(E.empno) 社保缴纳年月
FROM EMP E;

#总结：
 --- 存储过程和自定义函数的区别：
   /*  1 功能不同，存储过程主要用于数据同步，而自定义函数主要用于做计算。
    2 调用方式不同，存储过程一般使用 BEGIN END 调用，而自定义函数是放在 SELECT 语句后面调用的
    3 返回值不同， 存储过程不需要返回结果，而自定义函数必须返回一个计算结果。
    4 定义时不同，存储过程不需要指明返回值的数据类型，自定义函数必须指定返回值的数据类型。 */




#PART2:存储过程之数据同步：

/*1.0 增量抽取
  只需抽取新增的或修改的数据。此方法性能好，但容易遗漏。
  目标表中有，但是源表中没有的话，更新不了。
  以时间戳取增量，对源表删除的数据无能为力。
  
  通过源表更新目标表的时候，通常是先判断 源表中的数据在目标表中是否存在（通过主键判断）
       如果存在，那么就用源表的数据，更新目标表的数据。
       如果不存在，那么就直接从源表中插入数据到目标表。*/
 
 
 -------------------------------------  使用游标进行增量数据同步。       
CREATE OR REPLACE PROCEDURE SP_EMP_BACK2 IS
  CURSOR C_EMP IS
    SELECT * FROM EMP;

  V_EMP  C_EMP%ROWTYPE;
  V_CT   NUMBER(5);
  V_MARK NUMBER(5);
BEGIN
  --初始化变量
  V_MARK := SEQ_TEST2.NEXTVAL;

  FOR V_EMP IN C_EMP LOOP
    SELECT COUNT(1) INTO V_CT FROM EMP_BACK1 WHERE EMPNO = V_EMP.EMPNO; -- 比较字段，通过主键 EMPNO 判断员工信息是否存在于目标表
    -- 判断源表中的数据在目标表中存在，存在则用源表中的数据更新目标表
    IF V_CT = 1 THEN
      UPDATE EMP_BACK1 M
         SET --  这里更新的时候，不能更新 比较字段。
             M.ENAME = V_EMP.ENAME,
             M.JOB       = V_EMP.JOB,
             M.MGR       = V_EMP.MGR,
             M.HIREDATE  = V_EMP.HIREDATE,
             M.SAL       = V_EMP.SAL,
             M.COMM      = V_EMP.COMM,
             M.DEPTNO    = V_EMP.DEPTNO,
             M.DATA_DATE = SYSDATE,
             M.MARK      = V_MARK
       WHERE EMPNO = V_EMP.EMPNO;
    
      -- 判断源表中的数据，在目标表中不存在，那么就插入数据
    ELSIF V_CT = 0 THEN
      INSERT INTO EMP_BACK1
        (EMPNO,
         ENAME,
         JOB,
         MGR,
         HIREDATE,
         SAL,
         COMM,
         DEPTNO,
         DATA_DATE,
         MARK)
      VALUES
        (V_EMP.EMPNO,
         V_EMP.ENAME,
         V_EMP.JOB,
         V_EMP.MGR,
         V_EMP.HIREDATE,
         V_EMP.SAL,
         V_EMP.COMM,
         V_EMP.DEPTNO,
         SYSDATE,
         V_MARK);
    END IF;
  END LOOP;
  COMMIT;
END;
-------------- 调用存储过程
BEGIN
  SP_EMP_BACK2;
END ;
--- 检查目标表中的数据，是否按照增量同步的逻辑，存在则更新，不存在，则插入。
SELECT * FROM EMP_BACK1 ;


--------------------------------------- 使用 MERGE INTO 的方式实现增量同步
CREATE OR REPLACE PROCEDURE SP_EMP_BACK3 IS
  V_MARK NUMBER(5);
BEGIN
  V_MARK := SEQ_TEST2.NEXTVAL;

  MERGE INTO EMP_BACK1 M     -- 使用 MERGE INTO 更新目标表  EMP_BACK1
  USING (SELECT * FROM EMP) E  -- 使用 （） 内的查询结果
  ON (M.EMPNO = E.EMPNO)    -- 通过 ON 后面的条件比较
  -- 判断源表中数据在目标表中存在，则更新
  WHEN MATCHED THEN            -- 当 ON 后面的条件比较 匹配上数据，THEN 更新
    UPDATE
       SET -- 比较字段 EMPNO  不能更新
           M.ENAME     = E.ENAME,
           M.JOB       = E.JOB,
           M.MGR       = E.MGR,
           M.HIREDATE  = E.HIREDATE,
           M.SAL       = E.SAL,
           M.COMM      = E.COMM,
           M.DEPTNO    = E.DEPTNO,
           M.DATA_DATE = SYSDATE,
           M.MARK      = V_MARK      -- 这里不加分号 ，分号表示程序执行到这里结束

    -- 判断源表中的数据在目标表不存在，则插入
  WHEN NOT MATCHED THEN         -- 当 ON 后面的条件比较 匹配不到数据，THEN 插入
    INSERT 
      (M.EMPNO,
       M.ENAME,
       M.JOB,
       M.MGR,
       M.HIREDATE,
       M.SAL,
       M.COMM,
       M.DEPTNO,
       M.DATA_DATE,
       M.MARK)
    VALUES
      (E.EMPNO,
       E.ENAME,
       E.JOB,
       E.MGR,
       E.HIREDATE,
       E.SAL,
       E.COMM,
       E.DEPTNO,
       SYSDATE,
       V_MARK);
  COMMIT;
END;

--- 调用存储过程 
BEGIN 
  SP_EMP_BACK3;
END ;

--- 验证结果是否正确
SELECT * FROM EMP_BACK1  ;



/*2.0 全量抽取
   将目标表的数据全部删除，再将源系统的数据全部插入目标表。
 注意：此方法保证了数据的质量，但是对于数据量大的表而言，性能太差。*/
 
-- 备份表 、 备份表结构
CREATE TABLE EMP_BACK AS (SELECT * FROM EMP ); 

CREATE TABLE EMP_BACK1 AS (SELECT * FROM EMP  WHERE 1 = 2 ); 

-- 在目标表中增加检查字段，方便我们判断数据是否真的更新了。
ALTER TABLE EMP_BACK1 ADD DATA_DATE  DATE;   
ALTER TABLE EMP_BACK1 ADD MARK  NUMBER(10);

-- 在目标表中增加主键，确保数据的唯一性
ALTER TABLE EMP_BACK1 ADD CONSTRAINT PK_EMP_BACK1 PRIMARY KEY(EMPNO);


-- TRUNCATE TABLE EMP_BACK1 清空目标表中数据 

CREATE OR REPLACE PROCEDURE SP_EMP_BACK1
IS 
   V_MARK  NUMBER(10);
BEGIN 
  -- 初始化变量
  V_MARK  :=  SEQ_TEST2.NEXTVAL;
  -- 使用动态SQL 清空目标表，让存储过程支持重跑
  /*EXECUTE IMMEDIATE 'TRUNCATE TABLE EMP_BACK1 ' ;*/   -- ①  删除效率比较高，但是必须使用动态SQL执行
  
  DELETE FROM EMP_BACK1 WHERE 1 = 1;                   -- ②  直接使用DELETE 语句删除，记得加条件。
  
  INSERT INTO EMP_BACK1(EMPNO,
                        ENAME,
                        JOB,
                        MGR,
                        HIREDATE,
                        SAL,
                        COMM,
                        DEPTNO,
                        DATA_DATE,
                        MARK)
                     SELECT 
                     EMPNO,
                     ENAME,
                     JOB,
                     MGR,
                     HIREDATE,
                     SAL,
                     COMM,
                     DEPTNO,
                     SYSDATE,
                     V_MARK
                     FROM EMP_BACK  ; 
   COMMIT;                                
END ;


BEGIN 
  SP_EMP_BACK1;
END ;

SELECT * FROM EMP_BACK1;

#PART3:自定义函数
-- 函数
-- 语法

CREATE [OR REPLACE] FUNCTION 函数名
(
   参数1 [模式] 数据类型,
   参数2 [模式] 数据类型
)
RETURN 返回值的数据类型
IS/AS
声明变量;
BEGIN
  代码块;
END [函数名];

/*
语法说明：
1. OR REPLACE : 创建或替换     不加 ：-- 如果已经存在，就报错
2. 模式：   IN/OUT/ IN OUT
         IN : 传入参数 只读模式，只能被引用，不能被重新赋值 不能被修改
         OUT :传出参数 只写模式，不能被引用，只能被赋值，赋值后可以引用
         IN OUT:传入传出参数
3.函数必须要有一个返回值，而且只能有一个，必须要先声明返回值的类型，代码块中也要有 一个RETURN语句
*/

-- 创建一个函数，传入两个数字，返回较大数字
CREATE OR REPLACE FUNCTION F_NUM(A IN NUMBER , B IN NUMBER)   -- 不用写数据类型的长度
RETURN NUMBER
AS
-- 声明变量;  这里的长度还是要的
BEGIN
  IF A>B THEN
    RETURN A;
  ELSE
    RETURN B;
  END IF;
END;

-- 写一个函数，传入三个数字，返回最大的那个数字

CREATE OR REPLACE FUNCTION F_NUM1(A IN NUMBER , B IN NUMBER ,C IN NUMBER)   
RETURN NUMBER
AS
-- 声明变量;  这里的长度还是要的
BEGIN
  IF A>B THEN
    RETURN F_NUM(A,C);
  ELSE
    RETURN F_NUM(B,C);
  END IF;
END;


SELECT F_NUM(100,622) FROM DUAL;
SELECT F_NUM1(100,622,999) FROM DUAL;


-- 创建一个函数，传入一个身份证号码，返回性别 男  女


-- 删除函数
DROP FUNCTION 函数名;
/*
-- 函数和存储过程的区别
1.返回值：函数必须有一个返回值，存储过程可以有，也可以没有
2.使用场景：函数在SQL中调用，存储过程在PLSQL中调用
3.限制条件：函数限制比较多，不能使用临时表
4.功能：存储过程实现的功能【逻辑】更加复杂一些，函数针对性比较强，功能比较单一
5.返回类型：存储过程可以返回参数，函数只能返回值
6.编译：存储过程创建的时候，进行编译，函数调用一次就编译一次*/



#PART4:动态 SQL
/* 在 PL/SQL 程序开发中，可以使用 DML 语句和事务控制语句，但是还有很多
语句（比如 DDL 语句）不能直接在 PL/SQL 中执行，这些语句可以使用动态 SQL 来实
现。
PL/SQL 块先编译后再执行，动态 SQL 语句在编译时不能确定，只有在程序
执行时把 SQL 语句作为字符串的形式由动态 SQL 命令来执行。在编译阶段 SQL 语句作为
字符串存在，程序不会对字符串中的内容进行编译，在运行阶段再对字符串中的 SQL 语句
进行编译和执行。
动态 SQL 语法结构：
EXECUTE IMMEDIATE 动态语句字符串
[INTO 变量列表]
[USING 参数列表];
如果动态语句是 SELECT 语句，可以把查询的结果保存到 INTO 后面的变量
中。如果动态语句中存在参数，使用 USING 为语句中的参数传值。
动态 SQL 中的参数格式是：[:参数名]，参数在运行时需要使用 USING 传
值。 */
--例如：动态语句是 DDL 语句
BEGIN
EXECUTE IMMEDIATE 'CREATE TABLE YYY AS SELECT * FROM EMP';
END;
--例如：动态语句中是 SELECT 语句
DECLARE
V_EMPNO EMP.EMPNO%TYPE;
V_SAL EMP.SAL%TYPE;
BEGIN
EXECUTE IMMEDIATE 'SELECT EMPNO,SAL FROM EMP WHERE DEPTNO = :1 AND JOB = :2'
INTO V_EMPNO,V_SAL
USING 20,'MANAGER';
DBMS_OUTPUT.PUT_LINE(V_EMPNO || '-' || V_SAL);
END; 







----------------------第四部分：ORACLE高阶：包：包头&包体----------------------------	
#PART1:包  [包头 & 包体]
-- 创建包头
CREATE OR REPLACE PACKAGE PK_包名
IS   /*|AS*/
 
 PROCEDURE SP_过程名1[(参数类型)];
 PROCEDURE SP_过程名2[(参数类型)];
  ...
END PK_包名;


-- 创建包体
CREATE OR REPLACE PACKAGE  BODY  PK_包名
IS   /*|AS*/
     
    SP_过程名1[(参数类型)]
     IS 
     BEGIN  
        .... 
    END 过程名1 ;
      
      
    SP_过程名2[(参数类型)]
     IS 
     BEGIN  
        ....
    END 过程名1 ;
  ...
END PK_包名;

-- 案例：创建包头
--创建包头

CREATE OR REPLACE PACKAGE PK_TEST1
/*******************************************************************
* 包名  PK_TEST1
* 建立日期 :
* 版权声明  : 本代码版权归XXX公司所有，禁止任何未授权的传播和使用
* 作者:
* 模块:
* 描述:
* 输入参数:
* 输出参数:
* 备注:
* ----------------------------------------------------------------
* 修改历史
* 序号    日期    修改人    修改时间
* 1
* 2
**************************************************************** */
IS

       PROCEDURE SP_TEST1;
       /*******************************************************************
* 包名  SP_TEST1
* 建立日期 :
* 版权声明  : 本代码版权归XXX公司所有，禁止任何未授权的传播和使用
* 作者:
* 模块:
* 描述:
* 输入参数:
* 输出参数:
* 备注:
* ----------------------------------------------------------------
* 修改历史
* 序号    日期    修改人    修改时间
* 1
* 2
**************************************************************** */
       
       PROCEDURE SP_TEST2(P_SAL IN NUMBER);
/*******************************************************************
* 包名  SP_TEST2
* 建立日期 :
* 版权声明  : 本代码版权归XXX公司所有，禁止任何未授权的传播和使用
* 作者:
* 模块:
* 描述:
* 输入参数:
* 输出参数:
* 备注:
* ----------------------------------------------------------------
* 修改历史
* 序号    日期    修改人    修改时间
* 1
* 2
**************************************************************** */
 
END ;

--创建包体
CREATE OR REPLACE PACKAGE BODY PK_TEST1 
/*******************************************************************
* 包名  PK_TEST1
* 建立日期 :
* 版权声明  : 本代码版权归XXX公司所有，禁止任何未授权的传播和使用
* 作者:
* 模块:
* 描述:
* 输入参数:
* 输出参数:
* 备注:
* ----------------------------------------------------------------
* 修改历史
* 序号    日期    修改人    修改时间
* 1
* 2
**************************************************************** */
IS

  PROCEDURE SP_TEST1 
/*******************************************************************
* 包名  SP_TEST1
* 建立日期 :
* 版权声明  : 本代码版权归XXX公司所有，禁止任何未授权的传播和使用
* 作者:
* 模块:
* 描述:
* 输入参数:
* 输出参数:
* 备注:
* ----------------------------------------------------------------
* 修改历史
* 序号    日期    修改人    修改时间
* 1
* 2
**************************************************************** */   
    
    IS
    CURSOR C_EMP IS
      SELECT E.ENAME,
             E.HIREDATE,
             E.SAL,
             TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIREDATE)) M,
             CASE
               WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIREDATE)) >= 60 THEN
                E.SAL + 3000
               ELSE
                E.SAL
             END AS NSAL
        FROM EMP E;
  
    V_CEMP C_EMP%ROWTYPE;
  BEGIN
    FOR V_CEMP IN C_EMP LOOP
      DBMS_OUTPUT.PUT_LINE(V_CEMP.ENAME || ' ' || V_CEMP.SAL || ' ' ||
                           V_CEMP.M || ' ' ||
                           TO_CHAR(V_CEMP.HIREDATE, 'YYYY-MM-DD') || ' ' ||
                           V_CEMP.NSAL);
    END LOOP;
  END SP_TEST1;      -- 第一个存储过程

  PROCEDURE SP_TEST2(P_SAL IN NUMBER) 
/*******************************************************************
* 包名  SP_TEST2
* 建立日期 :
* 版权声明  : 本代码版权归XXX公司所有，禁止任何未授权的传播和使用
* 作者:
* 模块:
* 描述:
* 输入参数: P_SAL
* 输出参数:
* 备注:
* ----------------------------------------------------------------
* 修改历史
* 序号    日期    修改人    修改时间
* 1
* 2
**************************************************************** */   
    IS
    CURSOR C_SALES IS
      SELECT ENAME, SAL FROM EMP WHERE SAL >= P_SAL;
    V_CS C_SALES%ROWTYPE;
  BEGIN
    FOR V_CS IN C_SALES LOOP
      DBMS_OUTPUT.PUT_LINE(V_CS.ENAME || ' ' || V_CS.SAL);
    END LOOP;
  END SP_TEST2;   -- 第二个存储过程

END PK_TEST1;


#PART2:创建日志
#PART1:创建日志包
/*-- 日志 
什么时候用日志？ 
1 当程序出错，我们需要定位问题的时候，使用日志，看日志中报错的信息。
2 当开发完成一个需求以后，开发做UT（单元）测试的时候，
 不但要看代码的逻辑和实现的功能是否正常，还需要确保日志能正确记录。*/
     
---  1.0 创建记录日志的表结构
CREATE TABLE WF_TEST_LOG( 
LOG_ID   VARCHAR2(32),
SP_NAME  VARCHAR2(30),
SP_MARK  NUMBER(10),
S_DATE   DATE,
F_DATE   DATE,
SP_STATUS    VARCHAR2(10),
SP_DESC  VARCHAR2(50)
);


-- 2.0 创建日志包的包头

CREATE OR REPLACE PACKAGE WF_PK_SP_LOG

IS 
PROCEDURE WF_SP_LOG( 
                            P_SPNAME  IN VARCHAR2 ,
                            P_SPMARK  IN NUMBER,
                            P_SDATE   IN DATE,
                            P_FDATE   IN OUT DATE,
                            P_SPSTATUS  IN  VARCHAR2,
                            P_SP_DESC   IN  OUT VARCHAR2
                            );
END WF_PK_SP_LOG;

-- 3.0 创建包体
CREATE OR REPLACE PACKAGE BODY WF_PK_SP_LOG
IS 
PROCEDURE WF_SP_LOG( 
                            P_SPNAME  IN VARCHAR2 ,
                            P_SPMARK  IN NUMBER,
                            P_SDATE   IN DATE,
                            P_FDATE   IN OUT DATE,
                            P_SPSTATUS  IN  VARCHAR2,
                            P_SP_DESC   IN  OUT VARCHAR2
                            )
 IS 
BEGIN 
  INSERT INTO WF_TEST_LOG VALUES(
                       SYS_GUID(),
                       P_SPNAME,
                       P_SPMARK,
                       P_SDATE,
                       P_FDATE,
                       P_SPSTATUS,
                       P_SP_DESC
                       );
   COMMIT;
END WF_SP_LOG;
END WF_PK_SP_LOG;

select * from WF_TEST_LOG e;

DECLARE
V_FDATE  DATE:=SYSDATE;
V_SP_DESC VARCHAR2(20):='测试日志记录';

BEGIN
  PK_TEST1.SP_TEST1();
  PK_TEST1.SP_TEST2(3000.00);
END;









