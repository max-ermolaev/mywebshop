/* This is an Upgrade script for sqlserver2008 for version 20110727164018 */
CREATE TABLE [Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CategoryID] [int] NOT NULL REFERENCES Category(CategoryID),
	[ModelNumber] [nvarchar](50) NULL,
	[ModelName] [nvarchar](50) NULL,
	[ProductImage] [nvarchar](50) NULL,
	[UnitCost] [money] NOT NULL,
	[Description] [nvarchar](3800) NULL
)