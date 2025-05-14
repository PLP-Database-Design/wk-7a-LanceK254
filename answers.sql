-- Question One
WITH ProductCTE AS (
    SELECT
        OrderID,
        CustomerName,
        TRIM(value) AS Product
    FROM ProductDetail
    CROSS APPLY STRING_SPLIT(Products, ',')
)
SELECT * FROM ProductCTE;



-- Question Two
-- Order-level table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert distinct order-level data
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Order item details (each product per order)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data from original table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

