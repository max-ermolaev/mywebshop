/* This is an Upgrade script for sqlserver2008 for version 20110727205922 */
CREATE VIEW DetailedCartRecord AS
	SELECT TOP (100) PERCENT
		Product.ProductID,
		Product.ModelNumber,
		Product.ModelName,
		Product.UnitCost,
		CartRecord.Quantity,
		CartRecord.CartID
	FROM Product
	INNER JOIN CartRecord
	ON Product.ProductID = CartRecord.ProductID
	ORDER BY Product.ModelName, Product.ModelNumber
