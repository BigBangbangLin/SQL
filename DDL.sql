-- 创建数据库的对象：表 视图  索引 序列 同义词  自定义函数 存储过程  包

-- 对象1：CREATE TABLE ---
/*
语法：
CREATE TABLE 表名
( COL DATATYPE，
 COL DATATYPE，
 COL DATATYPE，
 COL DATATYPE
 ....

)*/

--表6大约束
 /*
含义：一种限制，用于限制表中的数据，为了保证表中的数据的准确和可靠性
分类：六大约束
   1.0：NOT NULL ：非空，用于保证该字段的值不能为空。比如姓名 ，学号
   2.0：DEFAULT：默认，用于保证该字段的有默认值。比如姓名
   3.0：PRIMARY KEY：主键，用于保证该字段的值具有唯一性，并且非空。比如学号，员工编号等。
   4.0：UNIQUE：唯一，用于保证该字段的值具有唯一性，可以为空。比如座位号
   5.0：CHECK：检查约束
   6.0：FOREIGN KEY：外键，用于限制两个表的关系，用于保证该字段的值必须来自于主表的关系列的值，在从表
                     中添加外键约束，用于引用主表中某列的值

唯一键和主键的对比：
        保证唯一性   是否允许为空    一个表中可以有多个    是否允许组合
 主键      √             ✘           至多一个               可以，但是不推荐
唯一键     √             √           可以有多个             可以，但是不推荐 

	  
*/




DROP TABLE STU;-- 回滚的脚步
CREATE TABLE STU
( SID NUMBER PRIMARY KEY,
  SMONEY NUMBER(7,2) DEFAULT 100,
  SNAME VARCHAR2(50) NOT NULL,-- 可变的长度
  SLIKE VARCHAR2(50)  DEFAULT '挣钱' ,
  SSEX  CHAR(50) CHECK(SSEX='男' OR SSEX='女' ),-- 固定长度
  SDATE DATE NOT NULL,
  SEAT NUMBER UNIQUE,
  SCID NUMBER,
  STID NUMBER,
  CONSTRAINT FK_STU_COURSE FOREIGN  KEY (SCID) REFERENCES COURSE(CID),--外键约束
  CONSTRAINT FK_STU_COURSE FOREIGN  KEY (STID) REFERENCES TEACHER(TID)
);

COMMENT ON TABLE STU IS '学生表'; -- 给表加注释
COMMENT ON COLUMN STU.SMONEY IS '零花钱'; -- 给字段加注释
COMMENT ON COLUMN STU.SLIKE IS '爱好';
COMMENT ON COLUMN STU.SSEX IS '行别';
COMMENT ON COLUMN STU.SDATE IS '生日';


CREATE TABLE COURSE
( CID NUMBER PRIMARY KEY,
  CNAME VARCHAR2(50)
);

INSERT INTO COURSE VALUES (2001,'BI大数据');
COMMIT;
INSERT INTO COURSE VALUES (2002,'HADOO大数据');
COMMIT;




--插入数据
SELECT * FROM STU;
INSERT INTO STU
  (SID, SNAME, SLIKE, SEAT, SSEX, SMONEY, SDATE,SCID)
VALUES
  (2, 'ZHANGSAN', 'SWIMMING', 1001, '男', 500, DATE '2012-01-01',2002);
COMMIT;

INSERT INTO STU
  (SID, SEAT ,SDATE,SNAME,SSEX)
VALUES
  (3, 1003, DATE '2012-01-02','LISI','女');
COMMIT;

TRUNCATE TABLE STU;

-- 查询学生的姓名 爱好 学生课程ID 以及学生的课程名称
SELECT 
S1.SNAME,
S1.SLIKE,
S1.SCID,
C.CNAME 
FROM STU S1 JOIN COURSE C ON S1.SCID=C.CID;

-- 数据库的四大基本操作：增删改查 （CRUD）
-- 改：
SELECT * FROM EMP2 E;
UPDATE EMP2 SET DEPTNO=10 --- 不限定修改数据
COMMIT;
UPDATE EMP2 SET DEPTNO=20 WHERE JOB='文员'; --- 限定修改
COMMIT;

UPDATE EMP2 SET SAL=5000,COMM=10000 WHERE JOB='经理' --- 限定修改多列 ;
COMMIT;

-- 删
--TRUNCATE 和  DELETE 的区别  （很重要，面试会问的）（背诵全文，并默写）
/*DDL           DML
不需要提交    需要提交
不能回滚      可以回滚
只能删除全表  也可以删除部分
效率比较高    效率比较低*/

-- DELETE 数据更新 【插入、更新、删除】 记日志 
-- 日志文件变大
-- TRUNCATE 删除数据的同时，删除了日志文件
-- 危害 数据永远无法找回 */
SELECT * FROM EMP2 E;

DELETE FROM EMP2;
ROLLBACK;

DELETE FROM EMP2 WHERE JOB='文员';
COMMIT;

TRUNCATE  TABLE EMP2;


/*
BEGIN
   FOR X  IN 1..1000000
   LOOP
   INSERT INTO TEST1 (TID,TNAME) VALUES (X,'WF'||X);
   END LOOP;
   COMMIT;
END;
SELECT * FROM TEST1;
*/

TRUNCATE TABLE TEST1;

/*1.0  建一下三张表：
学生表：STUDENT  
字段：学生编号：SID 姓名：SNAME  性别：GENDER 爱好：CLASS_ID  课程编号:CID 老师编号：TID 
 
老师表：TEACHER
字段： 老师编号：TID  老师姓名：TNAME

课程表：COURSE
课程ID：CID  课程名称：CNAME




要求：
1.0 每张表的字段名和表名都要求添加注释
2.0 学生表中：
SID要求是主键；
姓名设置成非空；
性别要求进行检测约束：男，女；
爱好默认：学习；
3.0 课程表&老师表
CID和TID要求是主键
4.0 绑定两张表的主键和外键的关系，
用对应的编号作为关联关系；
5.0 插入数据验证
*/


--- ORACLE对象2：CREATE VIEW ------
/*
-- 视图是什么：
视图可以理解为数据库中一张虚拟的表。

它是建立在已有表的基础上, 赖以建立的这些表称为基表。

通过一张或者多张基表进行关联查询后组成一个虚拟的逻辑表。

-- 作用：
查询视图，本质上是对表进行关联查询。

-- 语法：
CREATE [OR REPLACE] VIEW VIEW_NAME
AS SUBQUERY


-- 业务人员--
--作用：1.0 方便业务人员看数据 2.0 权限的管理

SELECT * FROM STU_COR_V E

*/
-- 案例1：创建视图
DROP VIEW STU_COR_V;
CREATE OR REPLACE VIEW STU_COR_V
AS
SELECT 
S1.SNAME,
S1.SMONEY,
S1.SLIKE,
C.CNAME,
S1.SSEX
FROM STU S1,
     COURSE C
 WHERE S1.SCID=C.CID;
 
-- 案例2：创建视图
CREATE OR REPLACE VIEW STU_COR_V
AS
SELECT 
S1.SNAME AS 姓名,
S1.SMONEY AS 零花钱,
S1.SLIKE  AS  爱好,
C.CNAME AS 课程名字,
S1.SSEX AS 性别
FROM STU S1,-- 基表
     COURSE C
 WHERE S1.SCID=C.CID;




-- 总结：视图不保存查询的结果集 只保存SQL的逻辑，查询结果随基表的数据变动而变动


SELECT * FROM STU_COR_V E WHERE 性别='男'

-- 工作的需求：新建视图 给视图新增字段

-- 物化视图：
--模板：
--创建：
CREATE MATERIALIZED VIEW [VIEW_NAME] 
REFRESH [FAST|COMPLETE|FORCE] 
[ 
ON [COMMIT|DEMAND] | 
START WITH (START_TIME) NEXT (NEXT_TIME) 
] 
AS 
SELECT 语句;

--实例：
CREATE MATERIALIZED VIEW MV_TEST_MATERIALIZED_VIEW
REFRESH FORCE ON DEMAND
START WITH TO_DATE('10-06-2019 02:25:00', 'DD-MM-YYYY HH24:MI:SS') NEXT TO_DATE(CONCAT(TO_CHAR(SYSDATE+1,'DD-MM-YYYY'),'02:25:00'),'DD-MM-YYYY HH24:MI:SS') 
AS
SELECT * FROM TABLE;

/* 
on demand:在用户需要刷新的时候刷新，这里就要求用户自己动手去刷新数据了（也可以使用job定时刷新）
on commit:当主表中有数据提交的时候，立即刷新MV中的数据；
start ……：从指定的时间开始，每隔一段时间（由next指定）就刷新一次；
 */





---空间换时间--


-- 3.0 索引：
/*

索引的概念：索引是用于加速数据存储的数据对象，类似如书中的目录。
作用：合理的使用索引可以大大降低I/O次数，从而提高数据的访问性能
分类：普通索引，唯一索引，组合索引，位图索引，反向索引，基于函数的索引
语法：
◇普通索引
CREATE INDEX INDEX_NAME ON TABLE_NAME(COLUMN_NAME)
◇唯一索引:
CREATE UNIQUE INDEX INDEX_NAME ON TABLE_NAME(COLUMN_NAME)
◇组合索引:
CREATE INDEX INDEX_NAME ON TABLE_NAME (COLUMN_NAME1，COLUMN_NAME2);
◇位图索引:
CREATE BITMAP INDEX INDEX_NAME ON TABLE_NAME (COLUMN_NAME);
◇反向键索引：保证数据的分步的均匀性
1001  1002  1003  1004  A  B  C
1001  2001  3001  4001
CREATE INDEX INDEX_NAME ON TABLE_NAME (COLUMN_NAME) REVERSE;
◇基于函数的索引：
CREATE INDEX INDEX_NAME ON TABLE_NAME (函数（COLUMN_NAME)）;
-- 案例：
CREATE INDEX EMP_ENAME_SUBSTR ON EMP ( SUBSTR(ENAME,1,2) );
CREATE INDEX EMP_ENAME_SUBSTR ON EMP ( UPPER(ENAME) );



--查询表的索引

SELECT * FROM ALL_INDEXES WHERE TABLE_NAME = ‘表名称’;
--查询表的索引列

SELECT* FROM ALL_IND_COLUMNS WHERE TABLE_NAME = ‘表名称’;





--删除语法：

DROP   INDEX   INDEX_NAME  ;


-- 造数100万条 ：性能测试
DROP TABLE TEST1;
CREATE TABLE TEST1
(TID  NUMBER,
 TNAME VARCHAR2(200)

  );
  
  
  
BEGIN
   FOR X  IN 1..2000000
   LOOP
   INSERT INTO TEST1 (TID,TNAME) VALUES (X,'WF'||X);
   END LOOP;
   COMMIT;
END;

SELECT * FROM TEST1;

CREATE INDEX IND_WF ON TEST1(TID) ;
SELECT * FROM TEST1 WHERE TID=999999;
SELECT * FROM TEST1 WHERE TNAME='WF999999';

DROP INDEX IND_WF;
CREATE UNIQUE INDEX IND_WF ON TEST1(TID);
SELECT * FROM ALL_INDEXES WHERE TABLE_NAME = 'TEST1';
*/

SELECT * FROM TEST1 WHERE TID=1990000;
SELECT * FROM TEST1 WHERE TNAME='WF1990000';

DROP INDEX  IND_T1;
CREATE UNIQUE INDEX IND_T1 ON TEST1(TID) ;

-- ORACLE系统视图：ORACLE的数据字典
SELECT * FROM ALL_INDEXES WHERE TABLE_NAME = 'TEST1';
INSERT INTO TEST1 (TNAME) VALUES ('WF1');
SELECT * FROM TEST1 E WHERE TID IS NULL;

--- ORACLE对象4：CREATE SEQUENCE ------
/*

--定义：
    序列: SEQUENCE 是ORACLE提供的用于产生一系列唯一数字的数据库对象。
    
--作用：    
  由于ORACLE中没有设置自增列的方法，所以我们在ORACLE数据库中主要用序列来实现主键自增的功能。
-- 语法：
CREATE SEQUENCE SEQUENCE //创建序列名称
[INCREMENT BY N] //递增的序列值是 N 如果 N 是正数就递增,如果是负数就递减 默认是 1
[START WITH N] //开始的值,递增默认是 MINVALUE 递减是 MAXVALUE
[{MAXVALUE N | NOMAXVALUE}] //最大值  
[{MINVALUE N | NOMINVALUE}] //最小值
[{CYCLE | NOCYCLE}] //循环/不循环
[{CACHE N | NOCACHE}];//分配并存入到内存中

*/


-- 案例：创建序列：
DROP SEQUENCE SEQ_TEST1;
CREATE SEQUENCE SEQ_TEST1
MINVALUE 1
MAXVALUE 999999999999999999999999999
START WITH 1
INCREMENT BY 2;

TRUNCATE  TABLE TEST1;
SELECT * FROM TEST1 E

INSERT INTO TEST1 VALUES (SEQ_TEST1.NEXTVAL,'AA');
COMMIT;

CREATE  SEQUENCE SEQ_TEST1;
SELECT SEQ_TEST1.NEXTVAL  FROM DUAL;
SELECT SEQ_TEST1.CURRVAL  FROM DUAL;
SELECT * FROM TEST1;
INSERT INTO TEST1 VALUES (SEQ_TEST2.NEXTVAL,'张三'，20);




--- ORACLE对象5：CREATE SYNONYM ------
-- 2.0 同义词
-- 语法：
CREATE [PUBLIC] SYNONYM 同义词名称 FOR [USERNAME.]OBJECTNAME；

CREATE SYNONYM TABLE1 FOR USER1.TABLE1; 

--删除同义词：

DROP PUBLIC SYNONYM TABLE_NAME;

-- 查看所有同义词：
SELECT * FROM DBA_SYNONYMS T WHERE T.SYNONYM_NAME='TEST1';
GRANT SELECT ON TEST1 TO SCOTT;

/*DROP SYNONYM TEST1 ;
CREATE PUBLIC SYNONYM TEST1 FOR WF.TEST1; 

GRANT DBA TO SCOTT;


DROP USER WF2;
CREATE USER WF2 IDENTIFIED BY 123456;

SELECT * FROM TEST1*/

GRANT DBA  TO WF; 

SELECT * FROM SCOTT.TEST1;


CREATE PUBLIC SYNONYM TEST1 FOR  SCOTT.TEST1;

SELECT * FROM TEST1 E


--- ORACLE对象6：CREATE DB_LINK【了解】 ------

CREATE PUBLIC DATABASE LINK  DB_121_ORCL     -- 创建 DBLINK的名称
CONNECT TO  SCOTT IDENTIFIED BY  "123456"    -- 这里的密码如果是纯数字的，必须加双引号
USING '192.168.0.121:1521/ORCL';    -- 通过DBLINK连接的目标数据库的地址。

CREATE PUBLIC DATABASE LINK  DB_113_ORCL     -- 创建 DBLINK的名称
CONNECT TO  SCOTT IDENTIFIED BY  "123456"    -- 这里的密码如果是纯数字的，必须加双引号
USING '192.168.0.113:1521/ORCL';








