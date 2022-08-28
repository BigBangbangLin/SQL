
-------------------��һ���֣�ORACLE�߽ף�PL/SQL�����﷨&������������---------------------

#PART1:PLSQL���
/*
PLSQL���Խ���˽ṹ����ѯ����SQL��ORACLE������̿���Ϊһ���ǿ�������
����֧�ָ�����������ͣ�ӵ������ı�����������ֵ��䣬���������жϡ�ѭ�������̿������
��SQL����޷��ϣ����Դ����洢���̡������Լ������

PLSQL������һ�ֿ�ṹ�����ԣ���һ��������һ�����У�һ���Է��͸���������
PLSQL�����յ����е����ݣ������еĹ��̿��������PLSQL��������ִ�У�SQL��佻����������SQL���ִ��

PLSQL���ŵ㣺
1.֧��SQL
2.֧�����������
   ��PLSQL�п��Դ������ͣ����Զ����ͽ��м��ɣ��������ӳ��������ط����ȵ�
3.���õ�����
   SQL�Ƿǹ������ԣ�ֻ��һ����ִ�У���PLSQL�ǰ�һ����ͳһ���б����ִ��
   ͬʱ�����԰ѱ���õ�PLSQL��洢�������Ա����ã�������Ӧ�ó���ͷ�����֮���ͨ��ʱ��
4.����ֲ��
   ʹ��PLSQL��д��Ӧ�ó��򣬿�����ֲ���κβ���ƽ̨�ϵ�ORACLE��������ͬʱ���Ա�д����ֲ�����
   �ڲ�ͬ�Ļ���������
5.��ȫ��
   ����ͨ���洢���̶Կͻ����ͷ�����֮���Ӧ�ó����߼����зָ�������ORACLE���ݿ�ķ��ʣ�������
   ��Ȩ�ͳ��������û����ʵ�����
   
   
 �����﷨�ṹ��
 DECLARE
     -- �������� ��
  BEGIN
       -- ��Ҫ�ĳ���ִ�й��� ��
  EXCEPTION
       --�쳣����  ��
  END;
   
   

*/
  
 
--����1����ӡ���ǵ�һ�� 'HELLO WORLD'

    BEGIN  
       DBMS_OUTPUT.PUT_LINE('HELLO WORLD');   
    END ;

--����2��ʹ�ñ��� ��ӡ��  HELLO  GIRLS
    DECLARE
        V_STR  VARCHAR2(30);
    BEGIN 
      -- ��ʼ������ 
      V_STR  := 'HELLO  GIRLS';    -- ��BEGIN �жԱ�����ֵ��
      DBMS_OUTPUT.PUT_LINE(V_STR);
    END ;

--����3�� �����û��������Ϣ��Ȼ���ӡ����
    DECLARE
       V_STR  VARCHAR2(30) :='&�����������ݣ��Ϳ��Դ�ӡ����';   -- ���������ʱ��ͨ���û����룬��������ֵ��
    BEGIN 
       DBMS_OUTPUT.PUT_LINE(V_STR);
    END ;
    
    
    
-- ����4���Ա����������¸�ֵ������ӡ�� HELLO WORLD
    DECLARE
       V_STR  VARCHAR2(30) :=&�����������ݣ��Ϳ��Դ�ӡ����;   -- ���������ʱ��ͨ���û����룬��������ֵ��
    BEGIN 
      -- �Ա��� V_STR ���¸�ֵ
      V_STR  := 'HELLO WORLD' ;
       DBMS_OUTPUT.PUT_LINE(V_STR);
    END ;
    
    
--����5�� ͨ����ѯ�ķ�ʽ 
   --�﷨��ʽ�� SELECT ֵ   INTO  V_����  
-- ���벿�ű�ţ���ӡ���ò��ŵ���߹���
   DECLARE
     -- ��������ı���
     V_DEPTNO  NUMBER(2) :=&�����벿�ű��;   -- 10 
     V_MAXSAL  NUMBER(7,2);
   BEGIN 
     -- ִ�й���
        -- ͨ�� SELECT INTO �ķ�ʽ��������ֵ
     SELECT  MAX(SAL)
     INTO  V_MAXSAL
     FROM EMP 
     WHERE DEPTNO = V_DEPTNO;   -- V_DEPTNO �൱����������Ĳ��ź� 10
        -- ��ӡ��������Ϣ
   DBMS_OUTPUT.PUT_LINE('����'||V_DEPTNO||'����߹����ǣ�'||V_MAXSAL);
   END ;
   
 --����6����ѯ��������ߵ�Ա���� ���� �����ʣ���������
   DECLARE
   -- ��������
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
   -- ��ӡ ���� ��Ϣ
   DBMS_OUTPUT.PUT_LINE(V_ENAME||' '||V_SAL||'  '||V_DNAME);
   END ;
  
--����7��  ��������  ��������֮���ڳ������޷����޸�
-- CONSTANT     DEFAULT
DECLARE
  PI CONSTANT NUMBER(5,2):=3.14;
  R            NUMBER(2) DEFAULT 3;
  AREA         NUMBER(8,4);
BEGIN
  AREA:=PI*R*R;
  DBMS_OUTPUT.PUT_LINE(AREA);
END;

--����8�������쳣�����֣�
��1.0 NO_DATA_FOUND
 DECLARE
   V_EMP EMP%ROWTYPE ;
 BEGIN
   SELECT ENAME ,SAL INTO V_EMP.ENAME,V_EMP.SAL FROM EMP  WHERE SAL >100000;
   DBMS_OUTPUT.PUT_LINE (V_EMP.ENAME||V_EMP.SAL);
   
   EXCEPTION
     WHEN NO_DATA_FOUND
       THEN  DBMS_OUTPUT.PUT_LINE ('û�ҵ����ݼ�'); 
  
 END ; 
 
��2.0 TOO_MANY_ROWS
 DECLARE
   V_EMP EMP%ROWTYPE ;
 BEGIN
   SELECT ENAME ,SAL INTO V_EMP.ENAME,V_EMP.SAL FROM EMP  ;
   DBMS_OUTPUT.PUT_LINE (V_EMP.ENAME||V_EMP.SAL);
   
   EXCEPTION
     WHEN TOO_MANY_ROWS
       THEN  DBMS_OUTPUT.PUT_LINE ('���ض�������'); 
  
 END ; 
 


-- �쳣����
-- ORACLE����Ԥ�����쳣��
/*�쳣����           �쳣��                   ����
DUP_VAL_ON_INDEX  ORA-00001        ��ͼ��Ψһ�����в����ظ�ֵ
INVALID_CURSOR    ORA-01001        ��ͼ���зǷ��α������
INVALID_NUMBER    ORA-01722        ��ͼ���ַ���ת��Ϊ����
NO_DATA_FOUND     ORA-01403        �����û�з����κμ�¼��
TOO_MANY_ROWS     ORA-01422        ����з��ض��� 1 ����¼��
ZERO_DIVIDE       ORA-01476        ��ͼ�� 0 ��Ϊ������
*/



#PART2:������������
/*
%TYPE:  �������ݿ���ĳ�е���������
%ROWTYPE�� �������ݿ��б��һ�У������ֶε��������ͣ�
*/

--����1�� ����Ա����ţ���ӡ��Ա������������н
DECLARE  
   V_EMPNO  EMP.EMPNO%TYPE;   -- ����%TYPE ,ָ���������������͡�
   V_ENAME  EMP.ENAME%TYPE;
   V_NSAL   EMP.SAL%TYPE;
BEGIN 
  V_EMPNO  :=&������Ա����� ;
  
  SELECT E.ENAME ,12*( E.SAL + NVL(E.COMM��0))
  INTO V_ENAME ,V_NSAL
  FROM EMP E
  WHERE E.EMPNO = V_EMPNO;
  
  DBMS_OUTPUT.PUT_LINE(V_ENAME|| '����н�ǣ� '||V_NSAL);
END ;

--����2��
DECLARE
  V_EMP  EMP%ROWTYPE;     --  ROWTYPE ��ʽ����������������͡�
BEGIN 
  V_EMP.EMPNO :=&������Ա����� ;
  
  SELECT E.ENAME ,12*( E.SAL + NVL(E.COMM��0))
  INTO V_EMP.ENAME ,V_EMP.SAL
  FROM EMP E
  WHERE E.EMPNO = V_EMP.EMPNO;
  
  DBMS_OUTPUT.PUT_LINE( V_EMP.ENAME || '����н�ǣ� '||V_EMP.SAL );
END ;
 

---------------------�ڶ����֣�ORACLE�߽ף���������&ѭ������&�α�-----------------------------
#PART1:��������
/*
  BEGIN 
   IF ���� 
     THEN ��� ;
   END IF ;
END ;




BEGIN 
   IF ���� 
     THEN ��� ;
   ELSE ���N ;
   END IF ;
END ;


BEGIN 
   IF ����1 
     THEN ���1 ;
   ELSIF ����2
     THEN ���2
   ELSE ���N ;
   END IF ;
END ;*/

/*����1������Ա���Ĺ��ţ�����Ա���Ĳ��ţ���Ա����н���������Ϊ10 �����Ա����н30% ��20��н20%�����ಿ�Ų���н��
 ʹ��PLSQL����飬��ӡ��Ա���Ĳ��ţ�ԭ���ʣ���н��Ĺ��ʡ�*/
 DECLARE 
     V_EMPNO  NUMBER(4) :=&����Ա�����;
     V_DEPTNO NUMBER(2);
     V_SAL1   NUMBER(7,2);
     V_SAL2   NUMBER(7,2);
  BEGIN 
    SELECT DEPTNO ,SAL 
    INTO V_DEPTNO  ,V_SAL1
    FROM EMP WHERE  EMPNO = V_EMPNO;
    
     IF   V_DEPTNO  = 10 
       THEN V_SAL2 := V_SAL1  *1.3 ;
      /* DBMS_OUTPUT.PUT_LINE('Ա���Ĳ���:'||V_DEPTNO  ||',ԭ����:'|| V_SAL1 ||',��н��Ĺ���:'||V_SAL2 );*/
     ELSIF V_DEPTNO = 20 
       THEN V_SAL2 := V_SAL1 *1.2 ;
      /* DBMS_OUTPUT.PUT_LINE('Ա���Ĳ���:'||V_DEPTNO  ||',ԭ����:'|| V_SAL1 ||',��н��Ĺ���:'||V_SAL2 );*/
     ELSE 
       V_SAL2  :=   V_SAL1 ;
      /* DBMS_OUTPUT.PUT_LINE('Ա���Ĳ���:'||V_DEPTNO  ||',ԭ����:'|| V_SAL1 ||',��н��Ĺ���:'||V_SAL2 );*/
     END IF ;

   DBMS_OUTPUT.PUT_LINE('Ա���Ĳ���:'||V_DEPTNO  ||',ԭ����:'|| V_SAL1 ||',��н��Ĺ���:'||V_SAL2 );
  END ;
     
 --����2������һ��д�� ͨ�� CASE WHEN ���� DECODE() ʵ��
SELECT E.EMPNO ,E.SAL AS SAL1 ,DECODE(E.DEPTNO,10,E.SAL*1.3,20,E.SAL*1.2,E.SAL) SAL2,
      CASE E.DEPTNO WHEN 10 THEN  E.SAL*1.3
           WHEN 20 THEN E.SAL*1.2
           ELSE  E.SAL  END SAL3
FROM EMP E
WHERE E.EMPNO = V_EMPNO;

#PART2:ѭ������
/*--ѭ������
ֱ��ѭ�� 
    BEGIN
      LOOP  
       ѭ����  ;
       ��ֹѭ�������� ;
      END LOOP  ;
    END ;

WHILE ѭ�� 
    BEGIN 
      WHILE ���� LOOP
        

      END  LOOP;
    END ;


FOR ѭ��
  BEGIN 
    FOR X IN  1..10 LOOP

    END LOOP;
  END;*/
  
  
-- ִ��1+2+3+��+10��ֵ

--����1��ʹ��LOOPѭ��ʵ��
DECLARE 
   X  NUMBER(5) := 1 ;
   Y  NUMBER(5) := 0 ;
BEGIN 
/*  DBMS_OUTPUT.PUT_LINE(X||' '||Y);
  DBMS_OUTPUT.PUT_LINE('LOOPѭ����ʼ:');*/
  LOOP 
   Y := X + Y ;
   X := X +1 ; 
    -- ��ֹѭ�������� �� �� �� �� 2��д����
    IF X > 10 THEN    --��   -- ������˳�ѭ����д��
      EXIT;  -- �˳�ѭ��  
    END IF;
    -- EXIT WHEN  X > 10 ; -- ��   ��д  ���� �ٵ�Ч��һ���ġ�
    --DBMS_OUTPUT.PUT_LINE('  '||X||' '||Y);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('ѭ������');
  DBMS_OUTPUT.PUT_LINE('1~10���ۼӽ��Ϊ��'||Y);
END ;

--����2��ʹ��WHILEѭ��ʵ��
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

--����3��FOR ѭ��
DECLARE
  X    NUMBER(3) := 0;
  Y    NUMBER := 0;
BEGIN
  FOR X IN 1 .. 100 LOOP 
    Y := Y + X;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('RESULT IS :' || Y);
END;


-- ����4����ӡ�˷��ھ���
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


#PART3���α�
/*
�α���ٽ�����е�λ�ã�������Խ��������ִ�ж������
���仰˵���α�Ӹ����Ͻ�����ָ�������ݿ�ı��صĽ����
������ָʾ������еĵ�ǰλ�ã�����������Ļ�ϵĹ��ָʾ��ǰλ��һ��
���α꡿�ɴ˵���

���α꡿������
1.ָ����������ض����е�λ��
2.���ڵ�ǰ�Ľ����λ�ü���һ�л�����������
3.�ڽ�����ĵ�ǰλ���޸����е�����
*/

-- ��1��   ����1��2��3����
-- ����1��2��3������1��2��3������1��2��3����������������

-- �﷨�ṹ
DECLARE
  CURSOR �α���[���� ��������] IS (SELECT ���);  -- �����α�
BEGIN
  -- ��ʽ�α�
  OPEN �α���[ʵ�ʲ���];   -- ���α�
  FETCH �α� INTO ������; -- ��ȡ����
    -- �����;
  CLOSE �α���;            -- �ر��α�
END;


-- ��ѯEMP��  ��ʾ   Ա����Ϊ��XXX�������ǣ�XXX��ְλ�ǣ�XXXX
DECLARE
  CURSOR C_EMP IS (SELECT EMPNO,ENAME,JOB FROM EMP);  -- �����α�
  V_EMPNO EMP.EMPNO%TYPE;
  V_ENAME EMP.ENAME%TYPE;
  V_JOB   EMP.JOB%TYPE;
BEGIN
  -- ��ʽ�α�
  OPEN C_EMP;  -- ���α�
  LOOP 
    FETCH C_EMP INTO V_EMPNO,V_ENAME,V_JOB;   -- ��ȡ����
    EXIT WHEN C_EMP%NOTFOUND;  -- ���α�ѭ���������˳�ѭ��
    DBMS_OUTPUT.PUT_LINE('Ա����Ϊ��'||V_EMPNO||'�������ǣ�'||V_ENAME||'��ְλ�ǣ�'||V_JOB);    
  END LOOP;
  CLOSE C_EMP;      -- �ر��α�
END;



-- ��ʽ�α�
DECLARE
  CURSOR �α���[���� ��������] IS (SELECT ���);  -- �����α�
BEGIN
  FOR X IN �α��� LOOP
    -- �����
  END LOOP;
END;


-- ��ѯEMP��  ��ʾ   Ա����Ϊ��XXX�������ǣ�XXX��ְλ�ǣ�XXXX
DECLARE
  CURSOR C_EMP IS (SELECT EMPNO,ENAME,JOB FROM EMP);  -- �����α�
BEGIN
  -- ��ʽ�α�
  FOR X IN C_EMP LOOP 
    DBMS_OUTPUT.PUT_LINE('Ա����Ϊ��'||X.EMPNO||'�������ǣ�'||X.ENAME||'��ְλ�ǣ�'||X.JOB);    
  END LOOP;
END;


---�����α�
DECLARE
  CURSOR C_EMP( V_EMPNO NUMBER) IS (SELECT EMPNO,ENAME,JOB FROM EMP WHERE EMPNO=V_EMPNO);  -- �����α�
BEGIN
  -- ��ʽ�α�
  FOR X IN C_EMP(7369) LOOP 
    DBMS_OUTPUT.PUT_LINE('Ա����Ϊ��'||X.EMPNO||'�������ǣ�'||X.ENAME||'��ְλ�ǣ�'||X.JOB);    
  END LOOP;
END;





-- �α���ŵ��ȱ��
/*
�ŵ�----------------
������;�������ѯ�Ľ���������Ժ�ʹ��
1.�α�Ľ������SELECT��������������������Ҫ�ظ�ʹ��һ����¼����ô����һ���α���ظ�ʹ�ö�Σ�
���ظ���ѯ���ݿ�Ҫ��ö�
2.�󲿷ֳ�������������ԣ����ܶ�ʹ���α�������SQL���ݿ��е����ݣ��ڳ�����Ƕ���α���ڳ�����Ƕ��SQL�����ͬ

ȱ��------------------
1.��Ϊ�������󣬶�������ϵͳ���ܵĲ�ֹ����һ��ҵ���������Ƕ���Ҫ��������ʹ���αꡣ
   �α�ʹ�õ�ʱ�򣬻���м��������ܻ�Ӱ������ҵ����������У��������������ʱ��Ч��Ҳ�ܵ�
2.�ڴ�Ҳ��һ�����ƣ��α��൱�ڰѴ�������д���ڴ��У�������ݹ����������ڴ治�㣬
   ����ֻ��������С��ʱ�򣬲�ʹ���α�
*/


--------------------------�������֣�ORACLE�߽ף��洢����&�洢����-----------------------------------
#PART1:�����﷨
-- �����洢���̺��Զ��庯�����﷨��
CREATE OR REPLACE PROCEDURE SP_������(����1 [IN|OUT|IN OUT] �������ͣ�����2 [IN|OUT|IN OUT] �������͡���)
IS   /*|AS*/
BEGIN  
  ִ����
END ;

CREATE OR REPLACE FUNCTION FUN_������(����1 �������ͣ�����2��[IN|OUT|IN OUT] �������͡���)
RETURN ���ص���������,��д����
IS   /*|AS*/
BEGIN  
   ִ����
   RETURN  ����� --�������Ҫ��һ��RETURN�Ӿ�
END ; 

-- ���̺ͺ����Ĳ������� [IN|OUT|IN OUT]
/*    IN ����Ϊ �������,Ĭ�ϲ��������Բ�д�����������¸�ֵ��
   OUT ����Ϊ ��������������Ա����¸�ֵ�����ǲ����������Ĳ�����
   IN OUT ����Ϊ��������������ȿ��Խ��ܴ����ֵ��Ҳ������Ϊ��������������������Ա����¸�ֵ�� */

1.0  �洢���̣�
------------------------------------------  IN  ���� ----------------------------------------------          
/*����һ���洢����  ʹ�� in ��������ʵ�֣� 
����Ա���� ��ţ���ӡ��Ա��������*/
-- �����洢����
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

-- ���ô洢����
BEGIN 
  SP_EMP(7369);
END ;
   




------------------------------------------ OUT ���� ---------------------------------------------
  ����Ϊ ��������������Ա����¸�ֵ�����ǲ�������κ� ����/�����ֵ��
     ���ң�һ�������� OUT ���͵Ĳ��������ù���ʱ�����봫��һ�� �����������ᱨ��
CREATE OR REPLACE PROCEDURE SP_HELLOWORLD (P_STR  OUT VARCHAR2)
IS 
BEGIN 
  P_STR := '�����������������';
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
  DBMS_OUTPUT.PUT_LINE('HELLO '||P_STR);
END ;

DECLARE
  V_STR  VARCHAR2(30) := '��̫����ں��' ;
BEGIN 
  SP_HELLOWORLD(V_STR);
END ;

----------------------------------------- IN  OUT ���� ----------------------------------------
  IN OUT ���͵Ĳ������ȿ��Խ��մ����ֵ ���ֿ��԰Ѹò�����Ϊ ����Ķ���
-- ���� ����Ա������������ӡ����Ա���� ��λ

CREATE OR REPLACE PROCEDURE  SP_ENAME_JOB(P_NAME_JOB   IN  OUT  VARCHAR2)
IS 
   -- ���ﲻ��Ҫ������������ı�������Ϊ���Զ� ��������������¸�ֵ��
BEGIN 
  SELECT JOB 
  INTO  P_NAME_JOB   -- �� out ���͵Ĳ����������¸�ֵ��������ӡ����
  FROM EMP 
  WHERE ENAME = P_NAME_JOB;   -- ʹ�ò������յ�������Ϊ����
  
  DBMS_OUTPUT.PUT_LINE(P_NAME_JOB);
END ;

DECLARE
  V_ENAME  VARCHAR2(10) :='SCOTT';
BEGIN 
  SP_ENAME_JOB(V_ENAME);
END ;

    /*�Ա� IN ���͵Ĳ���*/
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


--- 2.0  �Զ��庯����
/*����һ���Զ��庯��  ʹ�� in ��������ʵ�֣� 
����Ա���� ��ţ�����Ա�����籣�������ڣ���ʾΪ�ַ���ʽ ��YYYY-MM��*/
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
-- �����Զ��庯��
SELECT E.* ,FUN_EMP(E.empno) �籣��������
FROM EMP E;

#�ܽ᣺
 --- �洢���̺��Զ��庯��������
   /*  1 ���ܲ�ͬ���洢������Ҫ��������ͬ�������Զ��庯����Ҫ���������㡣
    2 ���÷�ʽ��ͬ���洢����һ��ʹ�� BEGIN END ���ã����Զ��庯���Ƿ��� SELECT ��������õ�
    3 ����ֵ��ͬ�� �洢���̲���Ҫ���ؽ�������Զ��庯�����뷵��һ����������
    4 ����ʱ��ͬ���洢���̲���Ҫָ������ֵ���������ͣ��Զ��庯������ָ������ֵ���������͡� */




#PART2:�洢����֮����ͬ����

/*1.0 ������ȡ
  ֻ���ȡ�����Ļ��޸ĵ����ݡ��˷������ܺã���������©��
  Ŀ������У�����Դ����û�еĻ������²��ˡ�
  ��ʱ���ȡ��������Դ��ɾ������������Ϊ����
  
  ͨ��Դ�����Ŀ����ʱ��ͨ�������ж� Դ���е�������Ŀ������Ƿ���ڣ�ͨ�������жϣ�
       ������ڣ���ô����Դ������ݣ�����Ŀ�������ݡ�
       ��������ڣ���ô��ֱ�Ӵ�Դ���в������ݵ�Ŀ���*/
 
 
 -------------------------------------  ʹ���α������������ͬ����       
CREATE OR REPLACE PROCEDURE SP_EMP_BACK2 IS
  CURSOR C_EMP IS
    SELECT * FROM EMP;

  V_EMP  C_EMP%ROWTYPE;
  V_CT   NUMBER(5);
  V_MARK NUMBER(5);
BEGIN
  --��ʼ������
  V_MARK := SEQ_TEST2.NEXTVAL;

  FOR V_EMP IN C_EMP LOOP
    SELECT COUNT(1) INTO V_CT FROM EMP_BACK1 WHERE EMPNO = V_EMP.EMPNO; -- �Ƚ��ֶΣ�ͨ������ EMPNO �ж�Ա����Ϣ�Ƿ������Ŀ���
    -- �ж�Դ���е�������Ŀ����д��ڣ���������Դ���е����ݸ���Ŀ���
    IF V_CT = 1 THEN
      UPDATE EMP_BACK1 M
         SET --  ������µ�ʱ�򣬲��ܸ��� �Ƚ��ֶΡ�
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
    
      -- �ж�Դ���е����ݣ���Ŀ����в����ڣ���ô�Ͳ�������
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
-------------- ���ô洢����
BEGIN
  SP_EMP_BACK2;
END ;
--- ���Ŀ����е����ݣ��Ƿ�������ͬ�����߼�����������£������ڣ�����롣
SELECT * FROM EMP_BACK1 ;


--------------------------------------- ʹ�� MERGE INTO �ķ�ʽʵ������ͬ��
CREATE OR REPLACE PROCEDURE SP_EMP_BACK3 IS
  V_MARK NUMBER(5);
BEGIN
  V_MARK := SEQ_TEST2.NEXTVAL;

  MERGE INTO EMP_BACK1 M     -- ʹ�� MERGE INTO ����Ŀ���  EMP_BACK1
  USING (SELECT * FROM EMP) E  -- ʹ�� ���� �ڵĲ�ѯ���
  ON (M.EMPNO = E.EMPNO)    -- ͨ�� ON ����������Ƚ�
  -- �ж�Դ����������Ŀ����д��ڣ������
  WHEN MATCHED THEN            -- �� ON ����������Ƚ� ƥ�������ݣ�THEN ����
    UPDATE
       SET -- �Ƚ��ֶ� EMPNO  ���ܸ���
           M.ENAME     = E.ENAME,
           M.JOB       = E.JOB,
           M.MGR       = E.MGR,
           M.HIREDATE  = E.HIREDATE,
           M.SAL       = E.SAL,
           M.COMM      = E.COMM,
           M.DEPTNO    = E.DEPTNO,
           M.DATA_DATE = SYSDATE,
           M.MARK      = V_MARK      -- ���ﲻ�ӷֺ� ���ֺű�ʾ����ִ�е��������

    -- �ж�Դ���е�������Ŀ������ڣ������
  WHEN NOT MATCHED THEN         -- �� ON ����������Ƚ� ƥ�䲻�����ݣ�THEN ����
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

--- ���ô洢���� 
BEGIN 
  SP_EMP_BACK3;
END ;

--- ��֤����Ƿ���ȷ
SELECT * FROM EMP_BACK1  ;



/*2.0 ȫ����ȡ
   ��Ŀ��������ȫ��ɾ�����ٽ�Դϵͳ������ȫ������Ŀ���
 ע�⣺�˷�����֤�����ݵ����������Ƕ�����������ı���ԣ�����̫�*/
 
-- ���ݱ� �� ���ݱ�ṹ
CREATE TABLE EMP_BACK AS (SELECT * FROM EMP ); 

CREATE TABLE EMP_BACK1 AS (SELECT * FROM EMP  WHERE 1 = 2 ); 

-- ��Ŀ��������Ӽ���ֶΣ����������ж������Ƿ���ĸ����ˡ�
ALTER TABLE EMP_BACK1 ADD DATA_DATE  DATE;   
ALTER TABLE EMP_BACK1 ADD MARK  NUMBER(10);

-- ��Ŀ���������������ȷ�����ݵ�Ψһ��
ALTER TABLE EMP_BACK1 ADD CONSTRAINT PK_EMP_BACK1 PRIMARY KEY(EMPNO);


-- TRUNCATE TABLE EMP_BACK1 ���Ŀ��������� 

CREATE OR REPLACE PROCEDURE SP_EMP_BACK1
IS 
   V_MARK  NUMBER(10);
BEGIN 
  -- ��ʼ������
  V_MARK  :=  SEQ_TEST2.NEXTVAL;
  -- ʹ�ö�̬SQL ���Ŀ����ô洢����֧������
  /*EXECUTE IMMEDIATE 'TRUNCATE TABLE EMP_BACK1 ' ;*/   -- ��  ɾ��Ч�ʱȽϸߣ����Ǳ���ʹ�ö�̬SQLִ��
  
  DELETE FROM EMP_BACK1 WHERE 1 = 1;                   -- ��  ֱ��ʹ��DELETE ���ɾ�����ǵü�������
  
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

#PART3:�Զ��庯��
-- ����
-- �﷨

CREATE [OR REPLACE] FUNCTION ������
(
   ����1 [ģʽ] ��������,
   ����2 [ģʽ] ��������
)
RETURN ����ֵ����������
IS/AS
��������;
BEGIN
  �����;
END [������];

/*
�﷨˵����
1. OR REPLACE : �������滻     ���� ��-- ����Ѿ����ڣ��ͱ���
2. ģʽ��   IN/OUT/ IN OUT
         IN : ������� ֻ��ģʽ��ֻ�ܱ����ã����ܱ����¸�ֵ ���ܱ��޸�
         OUT :�������� ֻдģʽ�����ܱ����ã�ֻ�ܱ���ֵ����ֵ���������
         IN OUT:���봫������
3.��������Ҫ��һ������ֵ������ֻ����һ��������Ҫ����������ֵ�����ͣ��������ҲҪ�� һ��RETURN���
*/

-- ����һ�������������������֣����ؽϴ�����
CREATE OR REPLACE FUNCTION F_NUM(A IN NUMBER , B IN NUMBER)   -- ����д�������͵ĳ���
RETURN NUMBER
AS
-- ��������;  ����ĳ��Ȼ���Ҫ��
BEGIN
  IF A>B THEN
    RETURN A;
  ELSE
    RETURN B;
  END IF;
END;

-- дһ�������������������֣����������Ǹ�����

CREATE OR REPLACE FUNCTION F_NUM1(A IN NUMBER , B IN NUMBER ,C IN NUMBER)   
RETURN NUMBER
AS
-- ��������;  ����ĳ��Ȼ���Ҫ��
BEGIN
  IF A>B THEN
    RETURN F_NUM(A,C);
  ELSE
    RETURN F_NUM(B,C);
  END IF;
END;


SELECT F_NUM(100,622) FROM DUAL;
SELECT F_NUM1(100,622,999) FROM DUAL;


-- ����һ������������һ�����֤���룬�����Ա� ��  Ů


-- ɾ������
DROP FUNCTION ������;
/*
-- �����ʹ洢���̵�����
1.����ֵ������������һ������ֵ���洢���̿����У�Ҳ����û��
2.ʹ�ó�����������SQL�е��ã��洢������PLSQL�е���
3.�����������������ƱȽ϶࣬����ʹ����ʱ��
4.���ܣ��洢����ʵ�ֵĹ��ܡ��߼������Ӹ���һЩ����������ԱȽ�ǿ�����ܱȽϵ�һ
5.�������ͣ��洢���̿��Է��ز���������ֻ�ܷ���ֵ
6.���룺�洢���̴�����ʱ�򣬽��б��룬��������һ�ξͱ���һ��*/



#PART4:��̬ SQL
/* �� PL/SQL ���򿪷��У�����ʹ�� DML �������������䣬���ǻ��кܶ�
��䣨���� DDL ��䣩����ֱ���� PL/SQL ��ִ�У���Щ������ʹ�ö�̬ SQL ��ʵ
�֡�
PL/SQL ���ȱ������ִ�У���̬ SQL ����ڱ���ʱ����ȷ����ֻ���ڳ���
ִ��ʱ�� SQL �����Ϊ�ַ�������ʽ�ɶ�̬ SQL ������ִ�С��ڱ���׶� SQL �����Ϊ
�ַ������ڣ����򲻻���ַ����е����ݽ��б��룬�����н׶��ٶ��ַ����е� SQL ���
���б����ִ�С�
��̬ SQL �﷨�ṹ��
EXECUTE IMMEDIATE ��̬����ַ���
[INTO �����б�]
[USING �����б�];
�����̬����� SELECT ��䣬���԰Ѳ�ѯ�Ľ�����浽 INTO ����ı���
�С������̬����д��ڲ�����ʹ�� USING Ϊ����еĲ�����ֵ��
��̬ SQL �еĲ�����ʽ�ǣ�[:������]������������ʱ��Ҫʹ�� USING ��
ֵ�� */
--���磺��̬����� DDL ���
BEGIN
EXECUTE IMMEDIATE 'CREATE TABLE YYY AS SELECT * FROM EMP';
END;
--���磺��̬������� SELECT ���
DECLARE
V_EMPNO EMP.EMPNO%TYPE;
V_SAL EMP.SAL%TYPE;
BEGIN
EXECUTE IMMEDIATE 'SELECT EMPNO,SAL FROM EMP WHERE DEPTNO = :1 AND JOB = :2'
INTO V_EMPNO,V_SAL
USING 20,'MANAGER';
DBMS_OUTPUT.PUT_LINE(V_EMPNO || '-' || V_SAL);
END; 







----------------------���Ĳ��֣�ORACLE�߽ף�������ͷ&����----------------------------	
#PART1:��  [��ͷ & ����]
-- ������ͷ
CREATE OR REPLACE PACKAGE PK_����
IS   /*|AS*/
 
 PROCEDURE SP_������1[(��������)];
 PROCEDURE SP_������2[(��������)];
  ...
END PK_����;


-- ��������
CREATE OR REPLACE PACKAGE  BODY  PK_����
IS   /*|AS*/
     
    SP_������1[(��������)]
     IS 
     BEGIN  
        .... 
    END ������1 ;
      
      
    SP_������2[(��������)]
     IS 
     BEGIN  
        ....
    END ������1 ;
  ...
END PK_����;

-- ������������ͷ
--������ͷ

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

--��������
CREATE OR REPLACE PACKAGE BODY PK_TEST1 
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

  PROCEDURE SP_TEST1 
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
  END SP_TEST1;      -- ��һ���洢����

  PROCEDURE SP_TEST2(P_SAL IN NUMBER) 
/*******************************************************************
* ����  SP_TEST2
* �������� :
* ��Ȩ����  : �������Ȩ��XXX��˾���У���ֹ�κ�δ��Ȩ�Ĵ�����ʹ��
* ����:
* ģ��:
* ����:
* �������: P_SAL
* �������:
* ��ע:
* ----------------------------------------------------------------
* �޸���ʷ
* ���    ����    �޸���    �޸�ʱ��
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
  END SP_TEST2;   -- �ڶ����洢����

END PK_TEST1;


#PART2:������־
#PART1:������־��
/*-- ��־ 
ʲôʱ������־�� 
1 ���������������Ҫ��λ�����ʱ��ʹ����־������־�б������Ϣ��
2 ���������һ�������Ժ󣬿�����UT����Ԫ�����Ե�ʱ��
 ����Ҫ��������߼���ʵ�ֵĹ����Ƿ�����������Ҫȷ����־����ȷ��¼��*/
     
---  1.0 ������¼��־�ı�ṹ
CREATE TABLE WF_TEST_LOG( 
LOG_ID   VARCHAR2(32),
SP_NAME  VARCHAR2(30),
SP_MARK  NUMBER(10),
S_DATE   DATE,
F_DATE   DATE,
SP_STATUS    VARCHAR2(10),
SP_DESC  VARCHAR2(50)
);


-- 2.0 ������־���İ�ͷ

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

-- 3.0 ��������
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
V_SP_DESC VARCHAR2(20):='������־��¼';

BEGIN
  PK_TEST1.SP_TEST1();
  PK_TEST1.SP_TEST2(3000.00);
END;









