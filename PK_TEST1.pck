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
/
CREATE OR REPLACE PACKAGE BODY PK_TEST1

IS
  ------------------------------- 声明，日志存储过程需要的变量 ------------------------------- 
  V_SPNAME  VARCHAR2(30); -- 存储过程名称
  V_SP_MARK NUMBER(10); -- 记录日志的批次
  V_SDATE   DATE; -- 开始时间
  V_FDATE   DATE; -- 完成时间                   
  V_STATUS  VARCHAR2(10); -- 数据同步状态
  V_DESC    VARCHAR2(50); -- 描述

  PROCEDURE SP_TEST1

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
    
   ------------------------------- 初始化 日志存储过程需要变量      ------------------------------- 
    V_SPNAME  := 'SP_TEST1';
    V_SP_MARK := seq_test1.NEXTVAL; -- 记录过程日志的批次
    V_SDATE   := SYSDATE;
    V_STATUS  := '开始';
    V_DESC    := '一，循环打印员工的姓名 ,工资';
    -- 记录开始日志
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE,
                     V_STATUS,
                     V_DESC);
  
  
  
    FOR V_CEMP IN C_EMP LOOP
      DBMS_OUTPUT.PUT_LINE(V_CEMP.ENAME || ' ' || V_CEMP.SAL || ' ' ||
                           V_CEMP.M || ' ' ||
                           TO_CHAR(V_CEMP.HIREDATE, 'YYYY-MM-DD') || ' ' ||
                           V_CEMP.NSAL);
    END LOOP;
    
       -------------------------------  记录结束的日志   ------------------------------- 
    
    V_STATUS := '完成';
    V_FDATE  := SYSDATE;
    V_DESC   := '打印完成';
  
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE, -- 完成时间 = 同步完成的当前时间
                     V_STATUS, -- 完成
                     V_DESC -- 已同步更新
                     );
    
    
    
  END SP_TEST1;      -- 第一个存储过程

  PROCEDURE SP_TEST2(P_SAL IN NUMBER)
   
    IS
    CURSOR C_SALES IS
      SELECT ENAME, SAL FROM EMP WHERE SAL >= P_SAL;
    V_CS C_SALES%ROWTYPE;
  BEGIN
     ------------------------------- 初始化 日志存储过程需要变量      ------------------------------- 
    V_SPNAME  := 'SP_TEST2';
    V_SP_MARK := seq_test1.NEXTVAL; -- 记录过程日志的批次
    V_SDATE   := SYSDATE;
    V_STATUS  := '开始';
    V_DESC    := '重新处理客户名称等数据';
    -- 记录开始日志
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE,
                     V_STATUS,
                     V_DESC);
  
 
  
    FOR V_CS IN C_SALES LOOP
      DBMS_OUTPUT.PUT_LINE(V_CS.ENAME || ' ' || V_CS.SAL);
    END LOOP;
    
          -------------------------------  记录结束的日志   ------------------------------- 
    
    V_STATUS := '完成';
    V_FDATE  := SYSDATE;
    V_DESC   := '打印完成';
  
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE, -- 完成时间 = 同步完成的当前时间
                     V_STATUS, -- 完成
                     V_DESC -- 已同步更新
                     );
    
    exception  
       when no_data_found
         then 
    V_STATUS := '未完成';
    V_FDATE  := SYSDATE;
    V_DESC   := '没有符合条件的数据';
  
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE, -- 完成时间 = 同步完成的当前时间
                     V_STATUS, -- 完成
                     V_DESC -- 已同步更新
                     );
        
    
    
    
    
  END SP_TEST2;   -- 第二个存储过程

END PK_TEST1;
/
