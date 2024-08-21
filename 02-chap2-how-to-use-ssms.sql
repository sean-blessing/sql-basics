-- Chapter 2 Basic Statements
SELECT * FROM Vendors;

-- Chapter 3 p. 65
SELECT *
  FROM Invoices;

-- same query, but only show 3 columns and order by invoice total
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
  FROM Invoices
 ORDER BY InvoiceTotal;

-- two columns and a calculated value for a specific invoice (id 17)
SELECT InvoiceID, InvoiceTotal, CreditTotal + PaymentTotal AS TotalCredits
  FROM Invoices
 WHERE InvoiceID = 17;

 -- get all invoices between 2 dates
 SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
   FROM Invoices
  WHERE InvoiceDate BETWEEN '2023-01-01' and '2023-03-31'
  ORDER BY InvoiceDate;

-- returning an empty result set
 SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
   FROM Invoices
  WHERE InvoiceTotal > 50000;

-- page 69
-- naming columns in the result set:
SELECT InvoiceNumber AS [Invoice Number], InvoiceDate AS Date, InvoiceTotal AS Total
  FROM Invoices;

-- no name for calculated column
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceTotal - PaymentTotal - CreditTotal
  FROM Invoices;

-- p. 71 coding expressions
-- concatenating string data
SELECT VendorCity, VendorState, VendorCity + VendorState
  FROM Vendors;
-- concatenate using commas and spaces
SELECT VendorName, (VendorCity+', '+VendorState+' '+ VendorZipCode) as Address
  FROM Vendors;

-- include apostrophes
SELECT VendorName + '''s Address: ', VendorCity + ', ' + VendorState + ' ' +VendorZipCode
  FROM Vendors;
