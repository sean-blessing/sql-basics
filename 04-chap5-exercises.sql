-- chapter 5 exercises

--#4
-- group by account #, sum the LIAmount, count(*)
SELECT GLA.AccountNo, AccountDescription, COUNT(*) LineItemCount, SUM(InvoiceLineItemAmount) LineItemSum
  FROM GLAccounts GLA
  JOIN InvoiceLineItems ILI ON ILI.AccountNo = GLA.AccountNo
 GROUP BY GLA.AccountNo, AccountDescription
 HAVING COUNT(*) > 1
 ORDER BY LineItemCount DESC;

 -- #5
 SELECT GLA.AccountNo, AccountDescription, COUNT(*) LineItemCount, SUM(InvoiceLineItemAmount) LineItemSum
  FROM GLAccounts GLA
  JOIN InvoiceLineItems ILI ON ILI.AccountNo = GLA.AccountNo
  JOIN Invoices I ON I.InvoiceID = ILI.InvoiceID
 WHERE InvoiceDate BETWEEN '2022-10-01' and '2022-12-31'
 GROUP BY GLA.AccountNo, AccountDescription
 HAVING COUNT(*) > 1
 ORDER BY LineItemCount DESC;

 SELECT *
   FROM INVOICES
   ORDER BY InvoiceDate;