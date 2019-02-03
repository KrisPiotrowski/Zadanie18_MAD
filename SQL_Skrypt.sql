/********************************************************************************/
--Ten skrypt tworzy schemat oraz widoki potrzebne do wykonania projektu
/********************************************************************************/


USE [WideWorldImportersDW]
GO

IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vDimCity' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vDimCity
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vDimCustomer' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vDimCustomer
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vDimDate' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vDimDate
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vDimEmployee' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vDimEmployee
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vDimStockItem' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vDimStockItem
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vDimSupplier' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vDimSupplier
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vFactOrder' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vFactOrder
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vFactPurchase' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vFactPurchase
GO
IF EXISTS(SELECT * FROM sys.views WHERE NAME = 'vFactSale' AND SCHEMA_ID = SCHEMA_ID('OLAP'))
	DROP VIEW OLAP.vFactSale
GO
IF EXISTS(SELECT * FROM sys.schemas WHERE NAME = 'OLAP')
	DROP SCHEMA OLAP;
GO

CREATE SCHEMA [OLAP]
GO

create view [OLAP].[vDimCity] AS
SELECT [City Key]
      ,[WWI City ID]
      ,[City]
      ,[State Province]
      ,[Country]
      ,[Continent]
      ,[Sales Territory]
      ,[Region]
      ,[Subregion]
      ,[Location]
      ,[Latest Recorded Population]
      ,[Valid From]
      ,[Valid To]
      ,[Lineage Key]
  FROM [Dimension].[City]
GO

create view [OLAP].[vDimCustomer] AS

SELECT [Customer Key]
      ,[WWI Customer ID]
      ,[Customer]
      ,[Bill To Customer]
      ,[Category]
      ,[Buying Group]
      ,[Primary Contact]
      ,[Postal Code]
      ,[Valid From]
      ,[Valid To]
      ,[Lineage Key]
  FROM [Dimension].[Customer]
GO

create view [OLAP].[vDimDate] AS

SELECT [Date]
      ,[Day Number]
      ,[Day]
      ,[Month]
      ,[Short Month]
      ,[Calendar Month Number]
      ,[Calendar Month Label]
      ,[Calendar Year]
      ,[Calendar Year Label]
      ,[Fiscal Month Number]
      ,[Fiscal Month Label]
      ,[Fiscal Year]
      ,[Fiscal Year Label]
      ,[ISO Week Number]
	  ,[Date Key] = CAST(REPLACE(Date, '-', '') as int)
	  ,[Calendar Month Key] = CAST( CAST([Calendar Year] as varchar(4)) + RIGHT('0'+ CAST([Calendar Month Number] as varchar(2)),2) as int)
	  ,[Fiscal Month Key] = CAST( CAST([Fiscal Year] as varchar(4)) + RIGHT('0'+ CAST([Fiscal Month Number] as varchar(2)),2) as int)
  FROM [Dimension].[Date]
GO

create view [OLAP].[vDimEmployee] AS

SELECT [Employee Key]
      ,[WWI Employee ID]
      ,[Employee]
      ,[Preferred Name]
      ,[Is Salesperson]
      ,[Photo]
      ,[Valid From]
      ,[Valid To]
      ,[Lineage Key]
  FROM [Dimension].[Employee]
GO

create view [OLAP].[vDimStockItem] AS

SELECT [Stock Item Key]
      ,[WWI Stock Item ID]
      ,[Stock Item]
      ,[Color]
      ,[Selling Package]
      ,[Buying Package]
      ,[Brand]
      ,[Size]
      ,[Lead Time Days]
      ,[Quantity Per Outer]
      ,[Is Chiller Stock]
      ,[Barcode]
      ,[Tax Rate]
      ,[Unit Price]
      ,[Recommended Retail Price]
      ,[Typical Weight Per Unit]
      ,[Photo]
      ,[Valid From]
      ,[Valid To]
      ,[Lineage Key]
  FROM [Dimension].[Stock Item]
GO

create view [OLAP].[vDimSupplier] AS

SELECT [Supplier Key]
      ,[WWI Supplier ID]
      ,[Supplier]
      ,[Category]
      ,[Primary Contact]
      ,[Supplier Reference]
      ,[Payment Days]
      ,[Postal Code]
      ,[Valid From]
      ,[Valid To]
      ,[Lineage Key]
  FROM [Dimension].[Supplier]
GO

create view [OLAP].[vFactOrder] AS

SELECT [Order Key]
      ,[City Key]
      ,[Customer Key]
      ,[Stock Item Key]
      ,[Order Date Key]
      ,[Picked Date Key]
      ,[Salesperson Key]
      ,[Picker Key]
      ,[WWI Order ID]
      ,[WWI Backorder ID]
      ,[Description]
      ,[Package]
      ,[Quantity]
      ,[Unit Price]
      ,[Tax Rate]
      ,[Total Excluding Tax]
      ,[Tax Amount]
      ,[Total Including Tax]
      ,[Lineage Key]
  FROM [Fact].[Order]
GO

create view [OLAP].[vFactPurchase] AS

SELECT [Purchase Key]
      ,[Date Key]
      ,[Supplier Key]
      ,[Stock Item Key]
      ,[WWI Purchase Order ID]
      ,[Ordered Outers]
      ,[Ordered Quantity]
      ,[Received Outers]
      ,[Package]
      ,[Is Order Finalized]
      ,[Lineage Key]
  FROM [Fact].[Purchase]
GO

create view [OLAP].[vFactSale] AS

SELECT [Sale Key]
      ,[City Key]
      ,[Customer Key]
      ,[Bill To Customer Key]
      ,[Stock Item Key]
      ,[Invoice Date Key]
      ,[Delivery Date Key]
      ,[Salesperson Key]
      ,[WWI Invoice ID]
      ,[Description]
      ,[Package]
      ,[Quantity]
      ,[Unit Price]
      ,[Tax Rate]
      ,[Total Excluding Tax]
      ,[Tax Amount]
      ,[Profit]
      ,[Total Including Tax]
      ,[Total Dry Items]
      ,[Total Chiller Items]
      ,[Lineage Key]
  FROM [Fact].[Sale]
GO


