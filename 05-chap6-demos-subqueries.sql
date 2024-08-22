-- Chapter 6 subqueries

-- p. 161
-- show me the invoices w/ a total greater than the average InvoiceTotal
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
  FROM Invoices
 WHERE InvoiceTotal > (
	SELECT AVG(InvoiceTotal)
	  FROM Invoices
 )
 ORDER BY InvoiceTotal;

-- p. 163 an inner join and a subquery which does the same
-- join invoices and vendors, display the inv #, inv date, and inv total for invoices for vendors in CA
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
  FROM Invoices I
  JOIN Vendors V ON V.VendorID = I.VendorID
 WHERE VendorState = 'CA'
 ORDER BY InvoiceDate;

-- same query restated as subquery
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
  FROM Invoices
 WHERE VendorID IN (
	SELECT VendorID
	  FROM Vendors
	WHERE VendorState = 'CA'
 )
 ORDER BY InvoiceDate;