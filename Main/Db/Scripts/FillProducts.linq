<Query Kind="Statements">
  <Connection>
    <ID>bcff8a92-17b4-4200-859f-0471c10047f2</ID>
    <Server>.\SQLEXPRESS</Server>
    <Database>C:\USERS\NYAKA\DESKTOP\PROJECTS\MYTAILSPINSPYWORKS\MYTAILSPINSPYWORKS\APP_DATA\COMMERCE.MDF</Database>
    <LinkedDb>ecommerce</LinkedDb>
  </Connection>
</Query>

var oldProducts = (from p in Products select p).ToList();

var newProducts = new List<EcommerceTypes.Product>();

oldProducts.ForEach(
	p => newProducts.Add(
		new EcommerceTypes.Product()
		{
			ProductID = p.ProductID,
			CategoryID = p.CategoryID,
			ModelNumber = p.ModelNumber,
			ModelName = p.ModelName,
			ProductImage = p.ProductImage,
			UnitCost = p.UnitCost,
			Description = p.Description
		}
	)
);

Ecommerce.Products.InsertAllOnSubmit(newProducts);

SubmitChanges();