SELECT NAME FROM SYS.DATABASES;

SELECT * FROM SYS.TABLES;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'EMP';

USE demo_db;
GO

CREATE TABLE EMP(EID INT PRIMARY KEY, ENAME VARCHAR(100) NOT NULL, SAL INT NOT NULL);

INSERT INTO EMP VALUES(100, 'TARUN', 10000)
INSERT INTO EMP VALUES(200, 'VARUN', 10000)
INSERT INTO EMP VALUES(300, 'ARUN', 10000)
INSERT INTO EMP VALUES(400, 'LAXMAN', 10000)
INSERT INTO EMP VALUES(500, 'VISHNU', 10000)
INSERT INTO EMP VALUES(600, 'ARJUN', 10000)

SELECT * FROM EMP;

UPDATE EMP SET SAL = 20000 WHERE EID = 200;
UPDATE EMP SET SAL = 30000 WHERE EID = 300;
UPDATE EMP SET SAL = 40000 WHERE EID = 400;
UPDATE EMP SET SAL = 50000 WHERE EID = 500;
UPDATE EMP SET SAL = 60000 WHERE EID = 600;

SELECT * FROM EMP;

DELETE FROM EMP WHERE EID = 600;

EXEC sp_rename 'EMP.SAL', 'SALARY', 'COLUMN';
EXEC sp_rename 'EMP.SALARY', 'SAL', 'COLUMN';

ALTER TABLE EMP ADD EMAIL VARCHAR(100);

ALTER TABLE EMP DROP COLUMN EMAIL;

ALTER TABLE EMP ALTER COLUMN ENAME VARCHAR(200);

EXEC sp_rename 'EMPLOYEES' , 'EMP';

TRUNCATE TABLE EMP;

SELECT * FROM EMP;

DROP TABLE EMP;

