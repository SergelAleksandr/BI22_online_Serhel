SELECT * FROM Production.UnitMeasure;

---------------------------------------------------

SELECT UnitMeasureCode
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%';

-----------------------------------------

SELECT DISTINCT count(UnitMeasureCode)
FROM Production.UnitMeasure;

--------------------------------------------------

INSERT INTO Production.UnitMeasure
VALUES (
	'TT1', 'Test 1', '2020-09-09'),
	('TT2', 'Test 2', getdate()
	);

SELECT * INTO Production.UnitMeasureTest
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%';

----------------------------------------

SELECT * FROM Production.UnitMeasureTest;

--------------------------------------------

INSERT INTO Production.UnitMeasureTest
SELECT * FROM Production.UnitMeasure
WHERE UnitMeasureCode = 'CAN';

------------------------------------------------

UPDATE Production.UnitMeasureTest
SET UnitMeasureCode = 'TTT';

-----------------------------------------------------

DELETE
FROM Production.UnitMeasureTest;

---------------------------------------------------------

SELECT * 
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664);

-----------------------------------------------------------------

SELECT LineTotal,
	max(LineTotal) OVER (Partition BY SalesOrderID) AS max_linetotal,
	min(LineTotal) OVER (Partition BY SalesOrderID) AS min_linetotal,
	avg(LineTotal) OVER (Partition BY SalesOrderID) AS min_linetotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664);

------------------------------------------------------------------

SELECT * FROM Sales.vSalesPerson;

----------------------------------------------------------------

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS full_name,
	CONCAT(LEFT(UPPER(LastName), 3), 'login', ISNULL(TerritoryGroup, ' ')) AS Login,
	RANK() OVER (ORDER BY SalesYTD DESC) AS rank_saler,
	SalesYTD
	--, RANK() OVER (ORDER BY SalesLastYear DESC) AS rank_last_year_saler,
	--SalesLastYear 
FROM Sales.vSalesPerson;
--Не знаю, в решении задачи ты хочешь вывести все в одну таблицу или в отдельные

------------------------------------------------

--

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS full_name,
	CONCAT(LEFT(UPPER(LastName), 3), 'login', ISNULL(TerritoryGroup, ' ')) AS Login,
	RANK() OVER (ORDER BY SalesLastYear DESC) AS rank_last_year_saler,
	SalesLastYear 
FROM Sales.vSalesPerson;