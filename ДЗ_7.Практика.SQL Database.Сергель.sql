DECLARE @myid uniqueidentifier = NEWID();	
SELECT CONVERT(CHAR(255), @myid) AS 'char';

DROP TABLE AdventureWorks2017.dbo.Patients;

CREATE TABLE AdventureWorks2017.dbo.Patients
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR (50),
	LastName VARCHAR (70) not NULL,
	SSN VARCHAR(10) UNIQUE,
	Email AS (CONCAT(UPPER(LEFT(FirstName, 1)), LOWER(LEFT(LastName, 3)), '@gmail.com')),
	Temp DEC(3,1) CHECK(Temp <= 45),
	CreatedDate DATE
	);

SELECT * FROM AdventureWorks2017.dbo.Patients;

INSERT INTO AdventureWorks2017.dbo.Patients (FirstName, LastName, SSN, Temp, CreatedDate)
VALUES ('John', 'Lester', '141', 36.6, '2024-06-21'),
	('Kevin', 'McAlister', '1841', 39.6, '2024-06-21'),
	('Emma', 'Stone', '471', 35.5, '2024-06-20')

	-----------------------------------------------------------

INSERT INTO AdventureWorks2017.dbo.Patients (FirstName, LastName, SSN, Temp, CreatedDate)
VALUES ('Bred', 'Pitt', '1fd41', 48, '2024-06-21');

INSERT INTO AdventureWorks2017.dbo.Patients (FirstName, LastName, SSN, Temp, CreatedDate)
VALUES ('Bred', 'Pitt', '1841', 42, '2024-06-21');

INSERT INTO AdventureWorks2017.dbo.Patients (FirstName, LastName, SSN, Temp, CreatedDate)
VALUES ('Bred', NULL, '1fd41', 42, '2024-06-21');

---------------------------------------------------------------

ALTER TABLE AdventureWorks2017.dbo.Patients
ADD TempType AS (
	CASE 
		WHEN Temp < 0 THEN '< 0°C'
		WHEN Temp > 0 THEN '> 0°C'
		ELSE '0°C'
	END
);

INSERT INTO AdventureWorks2017.dbo.Patients (FirstName, LastName, SSN, Temp, CreatedDate)
VALUES ('Bred', 'Pitt', '1fd41', -10, '2024-06-21');