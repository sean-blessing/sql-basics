USE MASTER;
GO

DROP DATABASE IF EXISTS SALESDB;
GO


CREATE DATABASE SALESDB;
GO

USE SALESDB;
GO

CREATE TABLE Sales_Denormalized (
	Id int PRIMARY KEY IDENTITY(1,1),
	SalesPersonId int NOT NULL,
	SalesPersonFirstName varchar(25) NOT NULL,
	SalesPersonLastName varchar(25) NOT NULL,
	Region varchar(20) NOT NULL,
	SalesDate date NOT NULL,
	SalesAmount decimal(10,2),
	Customer varchar(50)
);

-- name should be unique
CREATE TABLE Region (
	Id int PRIMARY KEY IDENTITY(1,1),
	-- Name varchar(15) NOT NULL UNIQUE
	Name varchar(15) NOT NULL,
	CONSTRAINT UQ_Region_Name UNIQUE (Name)
);

-- name should be unique
CREATE TABLE Customer (
	Id int PRIMARY KEY IDENTITY(1,1),
	Name varchar(50) NOT NULL,
	CONSTRAINT UQ_Customer_Name UNIQUE (Name)
);


-- RegionId is a FK to Region(Id)
CREATE TABLE SalesPerson (
	Id int PRIMARY KEY IDENTITY(1,1),
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	RegionId int NOT NULL,
	FOREIGN KEY (RegionId) REFERENCES Region(Id)
);

CREATE TABLE Sales (
	Id int PRIMARY KEY IDENTITY(1,1),
	SalesPersonId int NOT NULL,
	SalesDate	date NOT NULL,
	SalesAmount decimal(10,2) NOT NULL,
	CustomerId int NOT NULL,
	FOREIGN KEY (SalesPersonId) REFERENCES SalesPerson(Id),
	FOREIGN KEY (CustomerId) REFERENCES Customer(Id)
);

