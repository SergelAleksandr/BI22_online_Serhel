SELECT Concat (FirstName, ' ', LastName) AS FIO
FROM Person.Person AS pers
JOIN Person.PersonPhone AS phone 
ON pers.BusinessEntityID = phone.BusinessEntityID
WHERE phone.PhoneNumber IN (
SELECT PhoneNumber
FROM Person.PersonPhone
GROUP BY PhoneNumber
HAVING count(PhoneNumber) > 1);

--------------------------------------------------------------


SELECT prod.Name
FROM Production.Product AS prod
JOIN Purchasing.ProductVendor AS ven
ON prod.ProductID = ven.ProductID
WHERE StandardPrice IN (
SELECT StandardPrice
FROM Purchasing.ProductVendor
WHERE BusinessEntityID IN (
SELECT BusinessEntityID, Name, AccountNumber
FROM Purchasing.Vendor
WHERE Name LIKE '%A%' OR AccountNumber LIKE 'A%')
GROUP BY StandardPrice
HAVING avg(StandardPrice) > 10);

-------------------------------------------------------------


SELECT DISTINCT Name
FROM Purchasing.Vendor AS ven
LEFT JOIN Purchasing.ProductVendor AS prod
ON ven.BusinessEntityID = prod.BusinessEntityID
WHERE LastReceiptCost IS NULL;

---------------------------------------------------------------


SELECT emp_name
FROM Employees AS emp
LEFT JOIN Departments AS dep
ON emp.dep_id = dep.dep_id;

-------------------------------------------------------------


SELECT dep_name, count(emp_name)
FROM Departments AS dep
LEFT JOIN Employees AS emp
ON dep.dep_id = emp.dep_id
GROUP BY dep_name;

------------------------------------------------------------


SELECT concat(replace(lower(emp_name), ' ', '_'), '@gmail.com')
FROM Employees;

--------------------------------------------------------


SELECT ISNULL(dep_name, 'N.D.') AS dep_name_null, sum(revenue) AS sum_rev
FROM Departments AS dep
LEFT JOIN Employees AS emp
ON dep.dep_id = emp.dep_id
JOIN Revenue AS rev
ON emp.emp_id = rev.emp_id;

----------------------------------------------------------

SELECT *
FROM Purchasing.ProductVendor
WHERE DATEDIFF(yy, CURRENT_TIMESTAMP, LastReceiptDate) <= 10;

-----------------------------------------------------------

SELECT *
FROM Purchasing.ProductVendor
WHERE month(LastReceiptDate) = month(CURRENT_TIMESTAMP);

-----------------------------------------------------------

SELECT datename(dw, LastReceiptDate) AS dw_name
, count(*) AS count_row
FROM Purchasing.ProductVendor
GROUP BY datename(dw, LastReceiptDate)
ORDER BY datename(dw, LastReceiptDate)


-----------------------------------------------------------------------

SELECT 
    DAY(LastReceiptDate) AS Day,
    MONTH(LastReceiptDate) AS Month,
    YEAR(LastReceiptDate) AS Year,
    (SELECT COUNT(*) FROM Purchasing.ProductVendor AS count_ev_day 
	WHERE DAY(count_ev_day.LastReceiptDate) = DAY(pv.LastReceiptDate)) AS events_per_day,
    (SELECT COUNT(*) FROM Purchasing.ProductVendor AS count_ev_mon
	WHERE MONTH(count_ev_mon.LastReceiptDate) = MONTH(pv.LastReceiptDate)) AS events_per_month,
    (SELECT COUNT(*) FROM Purchasing.ProductVendor AS count_ev_year
	WHERE YEAR(count_ev_year.LastReceiptDate) = YEAR(pv.LastReceiptDate)) AS events_per_year
FROM 
    Purchasing.ProductVendor AS pv
GROUP BY 
    DAY(LastReceiptDate), MONTH(LastReceiptDate), YEAR(LastReceiptDate);

