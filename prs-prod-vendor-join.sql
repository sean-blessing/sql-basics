-- PRS Product - Vendor JOIN
SELECT * 
  FROM Product;

-- Result Set: PartNumber, Part Name, Price, VendorName 
SELECT PartNumber, P.Name AS PartName, Price
  FROM Product P
  JOIN Vendor V ON V.Id = P.VendorID
 ORDER BY PartName;