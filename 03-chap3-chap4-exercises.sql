-- chap 3 ex 3
SELECT VendorContactLName +', ' + VendorContactFName AS 'Full Name'
  FROM Vendors
 ORDER BY 'Full Name'

-- #6
SELECT VendorContactLName +', ' + VendorContactFName AS 'Full Name'
  FROM Vendors
-- WHERE VendorContactLName LIKE 'A%'
--    OR VendorContactLName LIKE 'B%'
--	OR VendorContactLName LIKE 'C%'
--	OR VendorContactLName LIKE 'E%'
 WHERE VendorContactLName LIKE '[A-C]%'
    OR VendorContactLName LIKE 'E%'
 ORDER BY 'Full Name';
 
-- Chap 4 Ex #1 (p. 132)
-- inner join Vendors - Invoices
-- If a vendorId is NOT in the invoices table, then that vendor
-- has no invoices
-- The question is really querying all vendors who have invoices
select * from Vendors;
SELECT *
  FROM Vendors
  JOIN Invoices ON Invoices.VendorID = Vendors.VendorID;

-- another (wrong) way to write an inner join:
--SELECT *
--  FROM Vendors, Invoices
-- WHERE Vendors.VendorID = Invoices.VendorID;

-- same join but use aliases
SELECT *
  FROM Vendors AS V
  JOIN Invoices AS I ON V.VendorID = I.VendorID;

--SELECT *
--  FROM Vendors AS V, Invoices as I
-- WHERE V.VendorID = I.VendorID;

-- same join query with aliases but no AS keyword
SELECT *
  FROM Vendors V
  JOIN Invoices I ON V.VendorID = I.VendorID;

-- same join query different formatting
SELECT *
  FROM Vendors V
  JOIN Invoices I
    ON V.VendorID = I.VendorID;

-- longer alias names, still abbreviations
SELECT *
  FROM Vendors Vnd
  JOIN Invoices Inv ON Vnd.VendorID = Inv.VendorID;

-- same join, but only display a few columns
SELECT Vnd.VendorID, VendorName, InvoiceID, InvoiceNumber, InvoiceTotal
  FROM Vendors Vnd
  JOIN Invoices Inv ON Vnd.VendorID = Inv.VendorID;

-- ex2 - same tables, adding where clause
-- invoices w/ non-zero balance ( > 0 )
-- balance = InvoiceTotal minus the sum of PaymentTotal and CreditTotal
SELECT VendorName, InvoiceNumber, InvoiceDate, (InvoiceTotal - (PaymentTotal + CreditTotal)) AS Balance
  FROM Vendors Vnd
  JOIN Invoices Inv ON Vnd.VendorID = Inv.VendorID
 WHERE (InvoiceTotal - (PaymentTotal + CreditTotal)) > 0;

-- #5 Join 3 tables alias columns and order by
-- Vendors (122), Invoices (114), InvoiceLineItems (118)
-- This is a LineItem Summary w/ associated Invoice and Vendor info
SELECT VendorName Vendor, InvoiceDate Date, InvoiceNumber Number, InvoiceSequence #, 
	   InvoiceLineItemAmount  LineItem
  FROM Vendors V
  JOIN Invoices I ON V.VendorID = I.VendorID
  JOIN InvoiceLineItems LI on LI.InvoiceID = I.InvoiceID
 ORDER BY Vendor, Date, Number, #;

-- #7 
-- Accounts table has 75 rows, ILI has 118 rows
-- "account that has never been used" => 
--				that account number is not in the ILI table
-- outer join GLAccounts -> InvoiceLineItems
SELECT G.AccountNo, AccountDescription
  FROM GLAccounts G
  LEFT OUTER JOIN InvoiceLineItems ILI ON ILI.AccountNo = G.AccountNo
 WHERE ILI.AccountNo is NULL
 ORDER BY G.AccountNo;

