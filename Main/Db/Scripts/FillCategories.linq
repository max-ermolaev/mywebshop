<Query Kind="Statements">
  <Connection>
    <ID>e0a12910-1658-4fd5-8be8-1caf21b5b88c</ID>
    <Server>.\SQLEXPRESS</Server>
    <Database>C:\USERS\NYAKA\DESKTOP\PROJECTS\MYTAILSPINSPYWORKS\MYTAILSPINSPYWORKS\APP_DATA\COMMERCE.MDF</Database>
    <LinkedDb>ecommerce</LinkedDb>
  </Connection>
</Query>

var oldCategories = (from c in Categories select c).ToList();

var newCategories = new List<EcommerceTypes.Category>();

oldCategories.ForEach(
	c => newCategories.Add(
		new EcommerceTypes.Category()
		{
			CategoryID = c.CategoryID,
			CategoryName = c.CategoryName
		}
	)
);

Ecommerce.Categories.InsertAllOnSubmit(newCategories);

SubmitChanges();