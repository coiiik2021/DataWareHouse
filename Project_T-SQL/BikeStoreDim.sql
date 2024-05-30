/****** Object:  Database BikeStoreDW    Script Date: 5/19/2024 3:44:59 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
--DROP DATABASE BikeStoreDW

CREATE DATABASE BikeStoreDW
GO
ALTER DATABASE BikeStoreDW
SET RECOVERY SIMPLE
GO

USE BikeStoreDW

GO
CREATE SCHEMA BSW
GO


/* Create table dbo.FactSales */
CREATE TABLE dbo.FactSales (
   [productKey]  int  DEFAULT 0 NOT NULL
,  [staffKey]  int  DEFAULT 0 NOT NULL
,  [customerKey]  int  DEFAULT 0 NOT NULL
,  [datekey]  int  DEFAULT 0 NOT NULL
,  [locationKey]  int  DEFAULT 0 NOT NULL
,  [quantity]  float   NULL
,  [list_price]  float   NULL
,  [discount]  float   NULL
,  [total_price]  float   NULL
) ON [PRIMARY]
;


/* Create table dbo.DimLocation */
CREATE TABLE dbo.DimLocation (
   [locationKey]  int IDENTITY  NOT NULL,
   [state] nvarchar(255),
   [city] nvarchar(255),
   [street] nvarchar(255),
   [zip_code] float 
, CONSTRAINT [PK_dbo.DimLocation] PRIMARY KEY CLUSTERED 
( [locationKey] )
) ON [PRIMARY]
;

/* Create table dbo.FactOrder */
CREATE TABLE dbo.FactOrder (
   [locationKey]  int  DEFAULT 0 NOT NULL
,  [dateKey]  int  DEFAULT 0 NOT NULL
,  [storeKey]  int  DEFAULT 0 NOT NULL
,  [order_status]  float   NULL
,  [total_price]  float   NULL
,  [total_quantity]  float   NULL
,  [dlivery_time]  datetime   NULL
) ON [PRIMARY]
;



/* Create table dbo.DimStores */
CREATE TABLE dbo.DimStores (
   [storeKey]  int IDENTITY  NOT NULL
,  [store_id]  float   NOT NULL
,  [store_name]  nvarchar(255)   NULL
,  [phone]  nvarchar(255)   NULL
,  [email]  nvarchar(255)   NULL
, CONSTRAINT [PK_dbo.DimStores] PRIMARY KEY CLUSTERED 
( [storeKey])
) ON [PRIMARY]
;



/* Create table dbo.DimStaffs */
CREATE TABLE dbo.DimStaffs (
   [staffKey]  int IDENTITY  NOT NULL
,  [staff_ID]  float   NOT NULL
,  [last_name]  nvarchar(255)   NOT NULL
,  [first_name]  nvarchar(255)   NOT NULL
,  [email]  nvarchar(255)   NULL
,  [phone]  nvarchar(255)   NULL
,  [active]  float   NULL
,  [manager_id]  float   NULL
, CONSTRAINT [PK_dbo.DimStaffs] PRIMARY KEY CLUSTERED 
( [staffKey] )
) ON [PRIMARY]
;

;
/* Create table dbo.DimProducts */
CREATE TABLE dbo.DimProducts (
   [productKey]  int IDENTITY  NOT NULL
,  [productID]  float   NOT NULL
,  [product_name]  nvarchar(255)   NULL
,  [model_year]  float   NULL
,  [list_price]  float   NULL
,  [brand_name]  nvarchar(255)   NULL
,  [category_name]  nvarchar(255)   NULL
, CONSTRAINT [PK_dbo.DimProducts] PRIMARY KEY CLUSTERED 
( [productKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimCustomers */
CREATE TABLE dbo.DimCustomers (
   [customerKey]  int IDENTITY  NOT NULL
,  [customer_ID]  float   NOT NULL
,  [first_name]  nvarchar(255)   NULL
,  [last_name]  nvarchar(255)   NULL
,  [phone]  nvarchar(255)   NULL
,  [email]  nvarchar(255)   NULL
, CONSTRAINT [PK_dbo.DimCustomers] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;


/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [datekey]  int IDENTITY  NOT NULL
,  [full_date] datetime  
,  [day]  int   
,  [month] int   
,  [year]  int   
,  [quarter] int  
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [datekey])
) ON [PRIMARY]
;


ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_productKey FOREIGN KEY
   (productKey) REFERENCES DimProducts(productKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_customerKey FOREIGN KEY
   (customerKey) REFERENCES DimCustomers
   (customerKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_datekey FOREIGN KEY
   (datekey) REFERENCES DimDate
   (datekey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_locationKey FOREIGN KEY
   (locationKey) REFERENCES DimLocation
   (locationKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_staffKey FOREIGN KEY
   (staffKey) REFERENCES DimStaffs
   (staffKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_locationKey FOREIGN KEY
   (locationKey) REFERENCES DimLocation
   (locationKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_DateKey FOREIGN KEY
   (dateKey) REFERENCES DimDate
   (datekey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_storeKey FOREIGN KEY
   (storeKey) REFERENCES DimStores
   (storeKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
 
