SELECT min(Weight) AS min_weigth, max(Size) AS max_size
FROM Production.Product;

SELECT ProductSubcategoryID, min(Weight) AS min_weigth, max(Size) AS max_size
FROM Production.Product
GROUP BY ProductSubcategoryID;

SELECT ProductSubcategoryID, min(Weight) AS min_weigth, max(Size) AS max_size
FROM Production.Product
WHERE Color IS not NULL
GROUP BY ProductSubcategoryID;

SELECT ProductSubcategoryID
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING min(Weight) >50;

SELECT ProductSubcategoryID
FROM Production.Product
WHERE Color = 'Black'
GROUP BY ProductSubcategoryID
HAVING min(Weight) >50;

SELECT TaxType
FROM Sales.SalesTaxRate
GROUP BY TaxType
HAVING min(TaxRate) <7;
