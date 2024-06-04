SELECT BusinessEntityID, LoginID
FROM HumanResources.Employee
WHERE Gender = 'F' AND BirthDate < '1969-01-29';

SELECT DISTINCT PersonType
FROM Person.Person
WHERE LastName LIKE 'M%' OR LastName LIKE 'N%' AND MiddleName IS not NULL;

SELECT * FROM Sales.SpecialOffer
WHERE StartDate BETWEEN '2013-01-01' AND '2014-01-01'
ORDER BY DiscountPct DESC;

SELECT ProductID, Name
FROM Production.Product
WHERE ProductNumber LIKE '_B%[0-9]'
ORDER BY ProductID DESC

SELECT ProductID, Name
FROM Production.Product
WHERE Color IN ('Red', 'Silver', 'Black') AND Size IS not NULL;

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
WHERE SickLeaveHours <= 15 OR VacationHours < 20 AND JobTitle not LIKE '%Vice President%' AND JobTitle not LIKE '%Manager%';

--Вывести имя и фамилию из Person.Person, у которых фамилия начинается на 'R', при этом упорядочив результат по возрастанию имени и убыванию фамилии 