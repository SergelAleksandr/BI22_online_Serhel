-- В первом и втором задании наверное нужно без DISTINCT, но для наглядности я написал с ним

SELECT DISTINCT
	StandardCost,
	CASE
		WHEN StandardCost = '0' OR StandardCost IS NULL THEN 'Not for sale'
		WHEN StandardCost < '100' THEN '$<100'
		WHEN StandardCost < '500' THEN '$<500'
		ELSE '$>500'
	END AS rate_cost
FROM Production.Product;

-------------------------------------------

SELECT DISTINCT 
	StandardCost,
	IIF(StandardCost = '0','Not for sale',
	IIF(StandardCost IS NULL, 'Not for sale',
	IIF(StandardCost > '0' AND StandardCost < '100', '<$100',
	IIF(StandardCost >= '100' AND StandardCost < '500', '<$500','>$500'))))
FROM Production.Product; -- Здесь легко для тех, кто хорошо шарит в эксель) Один в один функция IF

------------------------------------------------------

SELECT DISTINCT
	CASE
		WHEN MONTH(LastReceiptDate) IN (6, 7, 8) THEN 'Summer'
		WHEN MONTH(LastReceiptDate) IN (9, 10, 11) THEN 'Autumn'
		WHEN MONTH(LastReceiptDate) IN (12, 1, 2) THEN 'Winter'
		WHEN MONTH(LastReceiptDate) IN (3, 4, 5) THEN 'Spring'
		ELSE 'Unknown' -- Защита от дурака, мало ли там косяк в записи
	END AS name_of_season,
	CASE
		WHEN SUM(LastReceiptCost) < 2000 THEN 'Do not include'
		ELSE CAST(SUM(LastReceiptCost) AS VARCHAR) --Вот тут я помучался((( Все не понимал, почему ошибка и как ее исправить
	END AS sum_cost
	--, SUM(LastReceiptCost)
FROM Purchasing.ProductVendor
WHERE AverageLeadTime > 15
GROUP BY 
	CASE
		WHEN MONTH(LastReceiptDate) IN (6, 7, 8) THEN 'Summer'
		WHEN MONTH(LastReceiptDate) IN (9, 10, 11) THEN 'Autumn'
		WHEN MONTH(LastReceiptDate) IN (12, 1, 2) THEN 'Winter'
		WHEN MONTH(LastReceiptDate) IN (3, 4, 5) THEN 'Spring'
		ELSE 'Unknown'
	END -- Не знаю, правильно ли я сделал, но пришлось переписать весь кейс с селекта, потому что по-другому не получалось( Если есть другой путь, расскажи на лекции

------------------------------------------------------------------------------------------

SELECT 
	pv.BusinessEntityID,
	SUM(pv.LastReceiptCost) OVER (PARTITION BY pv.BusinessEntityID) AS sum_cost,
	pv.UnitMeasureCode,
	MAX(pv.LastReceiptCost) OVER (PARTITION BY pv.UnitMeasureCode) AS max_cost
	FROM Purchasing.ProductVendor AS pv
WHERE pv.AverageLeadTime = 15;