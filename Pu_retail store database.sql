CREATE DATABASE PU_SmartRetail;
USE PU_SmartRetail;

-- Customers Table
CREATE TABLE Customers(
CustomerID INT AUTO_INCREMENT PRIMARY KEY,
CustomerName VARCHAR(100) NOT NULL,
City VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
JoinDate DATE 
);

-- Categories Table
CREATE TABLE Categories(
CategoryID INT AUTO_INCREMENT PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE NOT NULL
);


-- Products Table
CREATE TABLE Products(
ProductID INT AUTO_INCREMENT PRIMARY KEY,
ProductName VARCHAR(100) NOT NULL,
CategoryID INT,
Price DECIMAL(10,2) NOT NULL,
StockQty INT DEFAULT 0,
LaunchDate DATE,
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)
);

-- Orders Table
CREATE TABLE Orders(
OrderID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
OrderDate DATE ,
Channel VARCHAR(20),
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails(
OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT NOT NULL,
UnitPrice DECIMAL(10,2) NOT NULL,
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID)
REFERENCES Products(ProductID)
);

-- INSERT INTO Customers table
INSERT INTO Customers(CustomerName,City,Email,JoinDate) VALUES
('Rahul Sharma','Delhi','rahul.sharma@gmail.com','2024-01-10'),
('Priya Patel','Ahmedabad','priya.patel@gmail.com','2024-02-15'),
('Amit Verma','Mumbai','amit.verma@gmail.com','2024-03-05'),
('Neha Singh','Jaipur','neha.singh@gmail.com','2024-01-20'),
('Karan Mehta','Pune','karan.mehta@gmail.com','2024-02-01'),
('Anjali Gupta','Delhi','anjali.gupta@gmail.com','2024-02-25'),
('Rohit Shah','Surat','rohit.shah@gmail.com','2024-03-02'),
('Sneha Kapoor','Chandigarh','sneha.kapoor@gmail.com','2024-01-18'),
('Vikram Joshi','Indore','vikram.joshi@gmail.com','2024-02-11'),
('Pooja Nair','Kochi','pooja.nair@gmail.com','2024-03-09'),
('Arjun Reddy','Hyderabad','arjun.reddy@gmail.com','2024-01-27'),
('Meera Iyer','Chennai','meera.iyer@gmail.com','2024-02-03'),
('Aditya Kumar','Patna','aditya.kumar@gmail.com','2024-02-17'),
('Ritika Malhotra','Delhi','ritika.malhotra@gmail.com','2024-03-12'),
('Sanjay Desai','Ahmedabad','sanjay.desai@gmail.com','2024-01-30'),
('Kavita Yadav','Lucknow','kavita.yadav@gmail.com','2024-02-07'),
('Nikhil Jain','Bhopal','nikhil.jain@gmail.com','2024-03-01'),
('Simran Kaur','Amritsar','simran.kaur@gmail.com','2024-02-14'),
('Manish Agarwal','Kolkata','manish.agarwal@gmail.com','2024-03-06'),
('Deepika Sharma','Delhi','deepika.sharma@gmail.com','2024-01-22');


-- INSERT Data INTO Categories Table 
INSERT INTO Categories(CategoryName) VALUES
('Electronics'),
('Clothing'),
('Home Appliances'),
('Furniture'),
('Accessories');

-- INSERT data  INTO Products Table 
INSERT INTO Products(ProductName,CategoryID,Price,StockQty,LaunchDate) VALUES
('Laptop',1,65000,15,'2024-01-05'),
('Smartphone',1,35000,25,'2024-01-10'),
('Bluetooth Headphones',5,2500,40,'2024-02-01'),
('Smart Watch',5,7000,30,'2024-02-15'),
('Men T-Shirt',2,800,100,'2024-03-01'),
('Women Kurti',2,1200,80,'2024-03-03'),
('Microwave Oven',3,12000,10,'2024-01-20'),
('Refrigerator',3,30000,8,'2024-02-12'),
('Dining Table',4,18000,5,'2024-01-18'),
('Office Chair',4,6500,12,'2024-02-05'),
('Gaming Mouse',5,1500,50,'2024-03-07'),
('Keyboard',5,1200,45,'2024-03-07'),
('LED TV',1,45000,9,'2024-01-30'),
('Air Conditioner',3,42000,7,'2024-02-20'),
('Bookshelf',4,5000,14,'2024-03-02');

-- INSERT data INTO Orders table
INSERT INTO Orders(CustomerID,OrderDate,Channel,TotalAmount) VALUES
(1,'2024-03-01','Online',65000),
(2,'2024-03-02','Retail',800),
(3,'2024-03-03','Online',2500),
(4,'2024-03-04','Retail',12000),
(5,'2024-03-05','Online',35000),
(6,'2024-03-06','Retail',7000),
(7,'2024-03-07','Online',18000),
(8,'2024-03-08','Retail',1200),
(9,'2024-03-09','Online',45000),
(10,'2024-03-10','Retail',1500);

-- INSERT data INTO OrderDetails table
INSERT INTO OrderDetails(OrderID,ProductID,Quantity,UnitPrice) VALUES
(1,1,1,65000),
(2,5,1,800),
(3,3,1,2500),
(4,7,1,12000),
(5,2,1,35000),
(6,4,1,7000),
(7,9,1,18000),
(8,6,1,1200),
(9,13,1,45000),
(10,11,1,1500);

select * from customers;
select * from  Categories;
select * from  Products;
select * from orders;
select * from  orderdetails;

-- List products with category names
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c
ON p.CategoryID = c.CategoryID;

-- Total sales for each product
SELECT ProductID,
SUM(Quantity * UnitPrice) AS TotalSales
FROM OrderDetails
GROUP BY ProductID;

-- Top 5 customers by spending
SELECT CustomerID,
SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
ORDER BY TotalSpent DESC
LIMIT 5;

-- Products with stock less than 10
SELECT ProductName, StockQty
FROM Products
WHERE StockQty < 10;

-- Monthly sales revenue
SELECT MONTH(OrderDate) AS Month,
SUM(TotalAmount) AS Revenue
FROM Orders
GROUP BY MONTH(OrderDate);

-- Create View sales_summary
CREATE VIEW sales_summary AS
SELECT
p.ProductName,
SUM(od.Quantity) AS TotalUnitsSold,
SUM(od.Quantity * od.UnitPrice) AS Revenue
FROM OrderDetails od
JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

select * from sales_summary;


-- Index Optimization
CREATE INDEX idx_category
ON Products(CategoryID);

EXPLAIN SELECT * FROM Products
WHERE CategoryID = 1;

-- Stored Procedure
DELIMITER //

CREATE PROCEDURE AddOrder(
IN cust_id INT,
IN total DECIMAL(10,2)
)
BEGIN
INSERT INTO Orders(CustomerID,OrderDate,Channel,TotalAmount)
VALUES(cust_id,CURDATE(),'Online',total);
END //

DELIMITER ;

-- call the procedure
CALL AddOrder(1,5000);

select * from orders;

-- Trigger
CREATE TRIGGER reduce_stock
AFTER INSERT ON OrderDetails
FOR EACH ROW
UPDATE Products
SET StockQty = StockQty - NEW.Quantity
WHERE ProductID = NEW.ProductID;

-- Transactions

START TRANSACTION;

INSERT INTO Orders(CustomerID,OrderDate,Channel,TotalAmount)
VALUES(1,CURDATE(),'Online',5000);

COMMIT;

ROLLBACK;

# Business Insights
-- Highest revenue category
SELECT c.CategoryName,
SUM(od.Quantity*od.UnitPrice) AS Revenue
FROM OrderDetails od
JOIN Products p ON od.ProductID=p.ProductID
JOIN Categories c ON p.CategoryID=c.CategoryID
GROUP BY c.CategoryName
ORDER BY Revenue DESC
LIMIT 1;

-- City with most customers
SELECT City, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC
LIMIT 1;

-- Rarely sold products
SELECT ProductName
FROM Products
WHERE ProductID NOT IN
(SELECT ProductID FROM OrderDetails);

-- Loyal customers
SELECT CustomerID,
SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
ORDER BY TotalSpent DESC;
