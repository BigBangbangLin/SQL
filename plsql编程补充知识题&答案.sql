--1.0 ���ʵ��1-100ż���͵�ʵ��

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

-- 2.0 ��дһ������飬�ҳ� 100-200 ֮�����е�����
/*
  ������ֻ�ܱ�1���߱����������������ų�1    ѭ������
*/

DECLARE
  V_FLAG NUMBER;  -- ��¼�Ƿ������ı�ʶ��0�����������1��������
BEGIN
  FOR X IN 100..200 LOOP
    -- �ⲿѭ����1�� X = 100
    -- �ⲿѭ����2�� X = 101
    -- �ⲿѭ����3�� X = 102
    -- �ⲿѭ����4�� X = 103
    -- ���ұ�X����С�����ݵ��������
    FOR Y IN 2..(X - 1) LOOP   -- 2..102
      -- ��1 ��1 Y = 2
      -- ��2 ��1 Y = 2
      -- ��2 ��2 Y = 3
      ....
      -- ��2 ��99 Y = 100
      -- ��3 ��1 Y = 2
      -- ��4 ��1 Y = 2
      IF MOD(X,Y) = 0 THEN
        
        V_FLAG := 0;
        
        EXIT;
        
      ELSE 
        
        V_FLAG := 1;
        
      END IF;
      
    END LOOP;  

    -- ����������ʹ�ӡ�����ǾͲ���ӡ
    IF V_FLAG = 1 THEN
      DBMS_OUTPUT.PUT_LINE(X);
    END IF;
  END LOOP;
END;



-- 3.0 ��дһ������飬�������� N����ӡN �Ľ׳ˡ���1*2*3*...*N �Ľ����
DECLARE
  V_N NUMBER := &����������;
  V_RESULT NUMBER := 1;
BEGIN
  FOR X IN 1..V_N LOOP
    V_RESULT := V_RESULT * X;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE(V_RESULT);
END;


-- 4.0 ����һ�������������������֣����ؽϴ������ 
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



--5.0 ʹ��FORѭ������ӡ99�˷��ھ��� 
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







-- 6.0 ��̳���飬��TEST1��ID��ENAME���в���1000�����ݣ�ÿ100���ύһ�� 

-- ��ʽһ��
DECLARE
BEGIN
  FOR X IN 1 .. 10 LOOP
    FOR Y IN 1 .. 100 LOOP
      INSERT INTO TEST1 VALUES (TO_NUMBER(X || Y), '����' || X || Y);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('��'||X||'�γɹ�����100������');
    COMMIT;
  END LOOP;
END; 

SELECT * FROM TEST1;
TRUNCATE TABLE TEST1;

-- ��ʽ����
BEGIN
  FOR X IN 1 .. 1000 LOOP
    INSERT INTO TEST1 VALUES (X, '����'||X);
    IF MOD(X, 100) = 0 THEN  -- ��Ͱ
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('��' || X || '�γɹ�����100������');
    END IF;
  END LOOP;
END;




--6.0 ��дһ������飬��ӡ���в��ŵ�����
-- ��ʽһ�������α�
DECLARE
  CURSOR C_DEPT IS(
    SELECT  DEPTNO,DNAME FROM DEPT);
BEGIN
  FOR X IN C_DEPT LOOP
    DBMS_OUTPUT.PUT_LINE('���ű��:'||X.DEPTNO || ' ��������:' ||X.DNAME);
  END LOOP;
END;


-- ��ʽ������ʾ�α귽ʽ
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
     DBMS_OUTPUT.PUT_LINE('���ű��:' || V_DEPT.DEPTNO || ' ��������:' || V_DEPT.DNAME)   
   END LOOP; 
   CLOSE C_DEPT;
 END;

 
-- ��ʽ�����Զ��庯��
CREATE OR REPLACE FUNCTION FUN_DEPTNO_DNAME(P_DEPTNO IN NUMBER)
  RETURN VARCHAR2 IS
  V_DNAME VARCHAR2(20);
BEGIN
  SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = P_DEPTNO;
  RETURN V_DNAME;
  END;-- ���벿�ű�ţ����ز�������

DECLARE
  CURSOR C_DEPTNO IS(
    SELECT DISTINCT DEPTNO FROM DEPT);
BEGIN
  FOR X IN C_DEPTNO LOOP
    DBMS_OUTPUT.PUT_LINE('���ű��:'||X.DEPTNO || ' ��������:' || FUN_DEPTNO_DNAME(X.DEPTNO));
  END LOOP;
END;



--7.0 ��д�Զ��庯����ʵ�ִ�����ݺţ��ж����䣬�������С��30�����������ˣ����������    30-55֮�� �������ˣ�����������������

CREATE OR REPLACE FUNCTION CARDID (P_CARID  VARCHAR2)
RETURN  VARCHAR2
  IS

 V_CARID VARCHAR2(50):=P_CARID;
  V_FLAG  VARCHAR2(50);
BEGIN
  SELECT
         CASE
           WHEN T.NL <= 30 THEN
            '��Ӣ' 
             WHEN T.NL > 30 THEN
            '������'
         END AS FLAG   INTO V_FLAG
    FROM ��SELECT

         (MONTHS_BETWEEN(SYSDATE,
                         TO_DATE(SUBSTR(V_CARID, 7, 8),
                                 'YYYY-MM-DD')) / 12) NL

    FROM DUAL) T;
  -- DBMS_OUTPUT.PUT_LINE(V_FLAG);
  RETURN  V_FLAG;
END;




--8.0 ��д�Զ��庯����Ҫ������Ĳ�����֧���ַ����͵����ݣ�ʵ�ֶ����ڽ����жϣ�������ڵ���������15�ţ���ȡ�¸��µ�����£��������С�ڵ���15�ţ���ȡ���µ������
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

















 
