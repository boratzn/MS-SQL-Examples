-- 1
select MAX(COUNT(ord.EmployeeID)), emp.* from Orders ord
INNER JOIN Employees emp
ON ord.EmployeeID = emp.EmployeeID
WHERE YEAR(ord.OrderDate) = 1996

-- 2
select emp.Address , emp.FirstName , emp.LastName , emp.BirthDate , emp.City from Orders ord with(nolock)
INNER JOIN Employees emp
ON ord.EmployeeID = emp.EmployeeID
WHERE YEAR(ord.OrderDate) = 1998 AND MONTH(OrderDate) = 4 

-- 3
select distinct cust.Address , cust.ContactName , cust.CompanyName , cust.Country from Orders ord with(nolock)
INNER JOIN Customers cust
ON ord.CustomerID = cust.CustomerID

-- 4
select ord.OrderDate , emp.EmployeeID , cust.Address , cust.ContactName , cust.CompanyName , cust.Country from Orders ord with(nolock)
INNER JOIN Customers cust
ON ord.CustomerID = cust.CustomerID
INNER JOIN Employees emp
ON ord.EmployeeID = emp.EmployeeID

-- 5
select c.CategoryName , p.ProductName , ordD.Quantity from [Order Details] ordD with(nolock)
INNER JOIN Products p
ON ordD.ProductID = p.ProductID
INNER JOIN Categories c
ON p.CategoryID = c.CategoryID
