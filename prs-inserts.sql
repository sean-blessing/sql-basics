-- create and select the database
USE MASTER;
GO

DROP DATABASE IF EXISTS prsdb;
GO


CREATE DATABASE prsdb;
GO

USE prsdb;
GO

-- create User table
-- unique constraint ensures a username can't be used more than once
CREATE TABLE [User] (
Id 				int 			PRIMARY KEY IDENTITY(1,1),
Username 		varchar(20) 	not null,
Password 		varchar(10) 	not null,
FirstName 		varchar(20) 	not null,
LastName 		varchar(20) 	not null,
PhoneNumber	 	varchar(12) 	not null,
Email 			varchar(75) 	not null,
Reviewer 		bit		 		DEFAULT 0 not null,
Admin	 		bit 			DEFAULT 0 not null,
CONSTRAINT UQ_User_Username		UNIQUE (Username),
CONSTRAINT UQ_User_Person		UNIQUE (FirstName, LastName, PhoneNumber),
CONSTRAINT UQ_User_Email		UNIQUE (Email)
);

-- create Vendor table
-- unique code ensures two vendors can't share the same code
CREATE TABLE Vendor (
Id 				int		 		PRIMARY KEY IDENTITY(1,1),
Code 			varchar(10) 	not null,
Name 			varchar(255) 	not null,
Address 		varchar(255) 	not null,
City 			varchar(255) 	not null,
State 			char(2) 		not null,
Zip 			char(5) 		not null,
PhoneNumber	 	varchar(12) 	not null,
Email 			varchar(100) 	not null,
CONSTRAINT UQ_Vendor_Code		UNIQUE (Code),
CONSTRAINT UQ_Vendor_Business	UNIQUE (Name, Address, City, State)
);

-- create Product table
-- unique vendor-part allows partnumber to repeat, but not for a single vendor...
--   also allows for multiple vendors to source the same product
CREATE TABLE Product (
Id 				int 			PRIMARY KEY IDENTITY(1,1),
VendorID 		int		 		not null,
PartNumber 		varchar(50) 	not null,
Name 			varchar(150) 	not null,
Price 			decimal(10,2)	not null,
Unit 			varchar(255) 	null,
PhotoPath 		varchar(255) 	null,
FOREIGN KEY (VendorId) REFERENCES Vendor(Id),
CONSTRAINT UQ_Product_Vid_Pnum	UNIQUE (VendorID, PartNumber)
);

-- create Request table
CREATE TABLE Request (
Id 					int 			PRIMARY KEY IDENTITY(1,1),
UserId 				int		 		not null,
RequestNumber		varchar(
Description 		varchar(100) 	not null,
Justification 		varchar(255) 	not null,
DateNeeded 			date 			null,
DeliveryMode 		varchar(25) 	not null,
Status 				varchar(20) 	not null DEFAULT 'New',
Total 				decimal(10,2) 	not null,
SubmittedDate 		datetime 		DEFAULT current_timestamp not null,
ReasonForRejection 	varchar(100) 	null,
FOREIGN KEY (UserID) REFERENCES [User](Id)
);



-- create PurchaseRequestLineItem table
-- unique constraint on combo of request - product prevents the same 
-- product appearing more than once for a single request
CREATE TABLE LineItem (
Id 				int 		PRIMARY KEY IDENTITY(1,1),
RequestId 		int 		not null,
ProductId 		int 		not null,
Quantity 		int 		not null,
FOREIGN KEY (ProductId) REFERENCES Product(Id),
FOREIGN KEY (RequestId) REFERENCES Request(Id),
CONSTRAINT UQ_LineItem_Req_Prod UNIQUE (RequestId, ProductId)
);

/*
-- Add a couple users
-- Note:  replace 'sblessing' user with your info
insert into user (ID, Username, Password, FirstName, LastName, Phone, Email, Reviewer, Admin) VALUES
	(1, 'SYSTEM', 'xxxxx', 'System', 'System', 'XXX-XXX-XXXX', 'system@test.com', 0, 0),
	(2, 'sblessing', 'login', 'Sean', 'Blessing', '513-600-7096', 'sean@blessingtechnology.com', 1, 1);

-- insert some rows into the Vendor table
INSERT into vendor (ID, code, name, address, city, state, zip, phone, email) VALUES
(1, 'BB-1001', 'Best Buy', '100 Best Buy Street', 'Louisville', 'KY', '40207', '502-111-9099', 'geeksquad@bestbuy.com'),
(2, 'AP-1001', 'Apple Inc', '1 Infinite Loop', 'Cupertino', 'CA', '95014', '800-123-4567', 'genius@apple.com'),
(3, 'AM-1001', 'Amazon', '410 Terry Ave. North', 'Seattle', 'WA', '98109','206-266-1000', 'amazon@amazon.com'),
(4, 'ST-1001', 'Staples', '9550 Mason Montgomery Rd', 'Mason', 'OH', '45040', '513-754-0235', 'support@orders.staples.com'),
(5, 'MC-1001', 'Micro Center', '11755 Mosteller Rd', 'Sharonville', 'OH', '45241', '513-782-8500', 'support@microcenter.com');

-- insert some rows into the Product table
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (1,1,'ME280LL','iPad Mini 2',296.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (2,2,'ME280LL','iPad Mini 2',299.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (3,3,'105810','Hammermill Paper, Premium Multi-Purpose Paper Poly Wrap',8.99,'1 Ream / 500 Sheets',NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (4,4,'122374','HammerMill® Copy Plus Copy Paper, 8 1/2\" x 11\", Case',29.99,'1 Case, 10 Reams, 500 Sheets per ream',NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (5,4,'784551','Logitech M325 Wireless Optical Mouse, Ambidextrous, Black ',14.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (6,4,'382955','Staples Mouse Pad, Black',2.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (7,4,'2122178','AOC 24-Inch Class LED Monitor',99.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (8,4,'2460649','Laptop HP Notebook 15-AY163NR',529.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (9,4,'2256788','Laptop Dell i3552-3240BLK 15.6\"',239.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (10,4,'IM12M9520','Laptop Acer Acer™ Aspire One Cloudbook 14\"',224.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (11,4,'940600','Canon imageCLASS Copier (D530)',99.99,NULL,NULL);
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (12,5,'228148','Acer Aspire ATC-780A-UR12 Desktop Computer',399.99,'','/images/AcerAspireDesktop.jpg');
INSERT INTO `product` (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) VALUES (13,5,'279364','Lenovo IdeaCentre All-In-One Desktop',349.99,'','/images/LenovoIdeaCenter.jpg');

-- create a user and grant privileges to that user
-- this is the user we'll use when accessing the db from our app
DROP USER IF EXISTS prs_user@localhost;
CREATE USER prs_user@localhost IDENTIFIED BY 'sesame';
GRANT SELECT, INSERT, DELETE, UPDATE ON prs.* TO prs_user@localhost;

*/