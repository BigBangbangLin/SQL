CREATE OR REPLACE PACKAGE PK_TEST1
/*******************************************************************
* ����  PK_TEST1
* �������� :
* ��Ȩ����  : �������Ȩ��XXX��˾���У���ֹ�κ�δ��Ȩ�Ĵ�����ʹ��
* ����:
* ģ��:
* ����:
* �������:
* �������:
* ��ע:
* ----------------------------------------------------------------
* �޸���ʷ
* ���    ����    �޸���    �޸�ʱ��
* 1
* 2
**************************************************************** */
IS

       PROCEDURE SP_TEST1;
       /*******************************************************************
* ����  SP_TEST1
* �������� :
* ��Ȩ����  : �������Ȩ��XXX��˾���У���ֹ�κ�δ��Ȩ�Ĵ�����ʹ��
* ����:
* ģ��:
* ����:
* �������:
* �������:
* ��ע:
* ----------------------------------------------------------------
* �޸���ʷ
* ���    ����    �޸���    �޸�ʱ��
* 1
* 2
**************************************************************** */

       PROCEDURE SP_TEST2(P_SAL IN NUMBER);
/*******************************************************************
* ����  SP_TEST2
* �������� :
* ��Ȩ����  : �������Ȩ��XXX��˾���У���ֹ�κ�δ��Ȩ�Ĵ�����ʹ��
* ����:
* ģ��:
* ����:
* �������:
* �������:
* ��ע:
* ----------------------------------------------------------------
* �޸���ʷ
* ���    ����    �޸���    �޸�ʱ��
* 1
* 2
**************************************************************** */

END ;
/
CREATE OR REPLACE PACKAGE BODY PK_TEST1

IS
  ------------------------------- ��������־�洢������Ҫ�ı��� ------------------------------- 
  V_SPNAME  VARCHAR2(30); -- �洢��������
  V_SP_MARK NUMBER(10); -- ��¼��־������
  V_SDATE   DATE; -- ��ʼʱ��
  V_FDATE   DATE; -- ���ʱ��                   
  V_STATUS  VARCHAR2(10); -- ����ͬ��״̬
  V_DESC    VARCHAR2(50); -- ����

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
    
   ------------------------------- ��ʼ�� ��־�洢������Ҫ����      ------------------------------- 
    V_SPNAME  := 'SP_TEST1';
    V_SP_MARK := seq_test1.NEXTVAL; -- ��¼������־������
    V_SDATE   := SYSDATE;
    V_STATUS  := '��ʼ';
    V_DESC    := 'һ��ѭ����ӡԱ�������� ,����';
    -- ��¼��ʼ��־
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
    
       -------------------------------  ��¼��������־   ------------------------------- 
    
    V_STATUS := '���';
    V_FDATE  := SYSDATE;
    V_DESC   := '��ӡ���';
  
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE, -- ���ʱ�� = ͬ����ɵĵ�ǰʱ��
                     V_STATUS, -- ���
                     V_DESC -- ��ͬ������
                     );
    
    
    
  END SP_TEST1;      -- ��һ���洢����

  PROCEDURE SP_TEST2(P_SAL IN NUMBER)
   
    IS
    CURSOR C_SALES IS
      SELECT ENAME, SAL FROM EMP WHERE SAL >= P_SAL;
    V_CS C_SALES%ROWTYPE;
  BEGIN
     ------------------------------- ��ʼ�� ��־�洢������Ҫ����      ------------------------------- 
    V_SPNAME  := 'SP_TEST2';
    V_SP_MARK := seq_test1.NEXTVAL; -- ��¼������־������
    V_SDATE   := SYSDATE;
    V_STATUS  := '��ʼ';
    V_DESC    := '���´���ͻ����Ƶ�����';
    -- ��¼��ʼ��־
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE,
                     V_STATUS,
                     V_DESC);
  
 
  
    FOR V_CS IN C_SALES LOOP
      DBMS_OUTPUT.PUT_LINE(V_CS.ENAME || ' ' || V_CS.SAL);
    END LOOP;
    
          -------------------------------  ��¼��������־   ------------------------------- 
    
    V_STATUS := '���';
    V_FDATE  := SYSDATE;
    V_DESC   := '��ӡ���';
  
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE, -- ���ʱ�� = ͬ����ɵĵ�ǰʱ��
                     V_STATUS, -- ���
                     V_DESC -- ��ͬ������
                     );
    
    exception  
       when no_data_found
         then 
    V_STATUS := 'δ���';
    V_FDATE  := SYSDATE;
    V_DESC   := 'û�з�������������';
  
    WF_PK_SP_LOG.WF_SP_LOG(V_SPNAME,
                     V_SP_MARK,
                     V_SDATE,
                     V_FDATE, -- ���ʱ�� = ͬ����ɵĵ�ǰʱ��
                     V_STATUS, -- ���
                     V_DESC -- ��ͬ������
                     );
        
    
    
    
    
  END SP_TEST2;   -- �ڶ����洢����

END PK_TEST1;
/
