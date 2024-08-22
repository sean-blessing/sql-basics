-- Chap 5 Summary Queries

-- p. 137
-- count of unpaid inoices, calculate total due
-- total due = invoice total - (payment total + credit total)
SELECT count(*) AS NumberOfInvoices,
	SUM(InvoiceTotal - (PaymentTotal + CreditTotal)) AS TotalDue
  FROM Invoices
 WHERE InvoiceTotal - (PaymentTotal + CreditTotal) > 0;

 -- p. 139 COUNT(*), AVG and SUM
 -- After 7/1/22 # of invoices, avg inv amt, tot inv amt
 SELECT 'After 7/1/2022' as SelectionDate,
		count(*) AS NumberOfInvoices,
		AVG(InvoiceTotal) AS AverageInvoiceAmount,
		SUM(InvoiceTotal) AS TotalInvoiceAmount
   FROM Invoices
  WHERE InvoiceDate > '2022-07-01';

-- using the DISTINCT keyword - bottom of p. 139
-- Total # of vendors, total invoices, avg amount, total amt, since 7/1/2022
 SELECT COUNT(DISTINCT VendorID) AS NumberOfVendors,
		COUNT(VendorId) AS NumberOfInvoices,
		AVG(InvoiceTotal) AS AverageInvoiceAmount,
		SUM(InvoiceTotal) AS TotalInvoiceAmount
   FROM Invoices
  WHERE InvoiceDate > '2022-07-01';

-- p. 141 Group By and Having clauses
-- Avg income amt by vendor
-- return VendorID, Avg Invoice Total
-- return only those averages greater than 2000 
SELECT VendorId, AVG(InvoiceTotal) as AvgInvoiceTotal
  FROM Invoices
 GROUP BY VendorID
 HAVING AVG(InvoiceTotal) > 2000
 ORDER BY AvgInvoiceTotal DESC;

-- p. 143
-- summary query counting the number of invoices by vendor
-- group by vendor, count the invoices
SELECT VendorID, COUNT(*) AS InvoiceQty
  FROM Invoices
 GROUP BY VendorID;

 -- how about only showing the counts greater than 1? (vendors w/ more than one invoice)
SELECT VendorID, COUNT(*) AS InvoiceQty
  FROM Invoices
 GROUP BY VendorID
 HAVING COUNT(*) > 1;

-- A Join w/ a group by, order by
-- # of invoices and the avg inv amt for vendors in each state and city
SELECT VendorState, VendorCity, COUNT(*) AS InvoiceQty, 
		AVG(InvoiceTotal) AS InvoiceAvg
  FROM Invoices I
  JOIN Vendors V on V.VendorID = I.VendorID
 GROUP BY VendorState, VendorCity
 ORDER BY VendorState, VendorCity;

-- p. 145
-- summary query w/ a search condition in the having clause
SELECT VendorName, COUNT(*) AS InvoiceQty,
		AVG(InvoiceTotal) as InvoiceAvg
  FROM Vendors V
  JOIN Invoices I on V.VendorID = I.VendorID
 GROUP BY VendorName
 HAVING AVG(InvoiceTotal) > 500
 ORDER BY InvoiceQty DESC;

-- p. 147 compare having and where clauses
SELECT InvoiceDate, COUNT(*) as InvoiceQty, SUM(InvoiceTotal) AS InvoiceSum
  FROM Invoices
 GROUP BY InvoiceDate
 HAVING InvoiceDate BETWEEN '2023-01-01' and '2023-01-31'
    AND COUNT(*) > 1
	AND SUM(InvoiceTotal) > 100
 ORDER BY InvoiceDate DESC;

 -- same thing using WHERE
SELECT InvoiceDate, COUNT(*) as InvoiceQty, SUM(InvoiceTotal) AS InvoiceSum
  FROM Invoices
 WHERE InvoiceDate BETWEEN '2023-01-01' and '2023-01-31'
 GROUP BY InvoiceDate
HAVING COUNT(*) > 1
   AND SUM(InvoiceTotal) > 100
 ORDER BY InvoiceDate DESC;

-- p. 148 SQL Server Extensions - won't see these in MySQL
-- ROLLOUP operator - add summary rows at bottom of result sets
--p.149
SELECT VendorID, COUNT(*) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceTotal
  FROM Invoices
 GROUP BY ROLLUP(VendorID);

-- p. 150 CUBE operator
-- p. 151
SELECT VendorID, COUNT(*) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceTotal
  FROM Invoices
 GROUP BY CUBE(VendorID);

-- inclue a summary for each set of groups
SELECT VendorState, VendorCity, COUNT(*) AS QtyVendors   FROM Vendors WHERE VendorState IN ('IA', 'NJ')  GROUP BY CUBE (VendorState, VendorCity)  ORDER BY VendorState DESC, VendorCity DESC;