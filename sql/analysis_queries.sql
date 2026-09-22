-- ============================================================
-- Company Insights 360 — MySQL Business Analysis Queries
-- Database: company_insights_db
-- Description: Practical queries answering key HR & Sales questions
-- ============================================================

USE company_insights_db;

-- ------------------------------------------------------------
-- Q1: How many employees are in each department?
-- Demonstrates: GROUP BY, COUNT(), ORDER BY
-- ------------------------------------------------------------
SELECT 
    Department, 
    COUNT(EmployeeID) AS TotalEmployees
FROM employees
GROUP BY Department
ORDER BY TotalEmployees DESC;


-- ------------------------------------------------------------
-- Q2: What is the average salary by department?
-- Demonstrates: AVG(), ROUND(), GROUP BY
-- ------------------------------------------------------------
SELECT 
    Department, 
    ROUND(AVG(Salary), 2) AS AvgSalary
FROM employees
GROUP BY Department
ORDER BY AvgSalary DESC;


-- ------------------------------------------------------------
-- Q3: Which departments have an average salary greater than 80,000?
-- Demonstrates: HAVING clause filtering aggregated data
-- ------------------------------------------------------------
SELECT 
    Department, 
    ROUND(AVG(Salary), 2) AS AvgSalary
FROM employees
GROUP BY Department
HAVING AVG(Salary) > 80000
ORDER BY AvgSalary DESC;


-- ------------------------------------------------------------
-- Q4: What is the average employee performance score by department?
-- Demonstrates: AVG(), ROUND(), GROUP BY
-- ------------------------------------------------------------
SELECT 
    Department, 
    ROUND(AVG(PerformanceScore), 2) AS AvgPerformance
FROM employees
GROUP BY Department
ORDER BY AvgPerformance DESC;


-- ------------------------------------------------------------
-- Q5: Who are the top high-performing employees (Performance >= 4.5)?
-- Demonstrates: WHERE filtering, ORDER BY DESC
-- ------------------------------------------------------------
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    PerformanceScore, 
    Salary
FROM employees
WHERE PerformanceScore >= 4.5
ORDER BY PerformanceScore DESC;


-- ------------------------------------------------------------
-- Q6: Categorize employees into Performance Tiers
-- Demonstrates: CASE WHEN conditional logic
-- ------------------------------------------------------------
SELECT 
    EmployeeID,
    Name, 
    Department, 
    PerformanceScore,
    CASE 
        WHEN PerformanceScore >= 4.5 THEN 'High Performer'
        WHEN PerformanceScore >= 3.5 THEN 'Average Performer'
        ELSE 'Needs Improvement'
    END AS PerformanceCategory
FROM employees
ORDER BY PerformanceScore DESC;


-- ------------------------------------------------------------
-- Q7: What is total sales revenue and total profit by sales region?
-- Demonstrates: SUM(), GROUP BY on sales table
-- ------------------------------------------------------------
SELECT 
    Region, 
    ROUND(SUM(Sales), 2) AS TotalSales, 
    ROUND(SUM(Profit), 2) AS TotalProfit
FROM sales
GROUP BY Region
ORDER BY TotalSales DESC;


-- ------------------------------------------------------------
-- Q8: Which region achieves the highest profit margin percentage?
-- Demonstrates: Calculated expressions in SELECT, GROUP BY
-- ------------------------------------------------------------
SELECT 
    Region, 
    ROUND(SUM(Sales), 2) AS TotalSales, 
    ROUND(SUM(Profit), 2) AS TotalProfit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS ProfitMarginPercentage
FROM sales
GROUP BY Region
ORDER BY ProfitMarginPercentage DESC;


-- ------------------------------------------------------------
-- Q9: What is total revenue and profit generated per product category?
-- Demonstrates: SUM(), GROUP BY
-- ------------------------------------------------------------
SELECT 
    Category, 
    ROUND(SUM(Sales), 2) AS TotalSales, 
    ROUND(SUM(Profit), 2) AS TotalProfit
FROM sales
GROUP BY Category
ORDER BY TotalSales DESC;


-- ------------------------------------------------------------
-- Q10: What is the annual sales and profit trend over the years?
-- Demonstrates: YEAR() date function, GROUP BY date parts
-- ------------------------------------------------------------
SELECT 
    YEAR(Date) AS SalesYear, 
    ROUND(SUM(Sales), 2) AS TotalSales, 
    ROUND(SUM(Profit), 2) AS TotalProfit
FROM sales
GROUP BY YEAR(Date)
ORDER BY SalesYear ASC;


-- ------------------------------------------------------------
-- Q11: Who are the Top 5 employees by total sales generated?
-- Demonstrates: INNER JOIN (employees + sales), SUM(), GROUP BY, LIMIT
-- ------------------------------------------------------------
SELECT 
    e.EmployeeID, 
    e.Name, 
    e.Department, 
    ROUND(SUM(s.Sales), 2) AS TotalRevenue
FROM employees e
INNER JOIN sales s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.Name, e.Department
ORDER BY TotalRevenue DESC
LIMIT 5;


-- ------------------------------------------------------------
-- Q12: Compare departmental total salary spend against allocated budget
-- Demonstrates: INNER JOIN (departments + employees), SUM(), GROUP BY
-- ------------------------------------------------------------
SELECT 
    d.Department, 
    d.Budget, 
    SUM(e.Salary) AS TotalSalarySpend,
    (d.Budget - SUM(e.Salary)) AS RemainingBudgetDifference
FROM departments d
INNER JOIN employees e ON d.Department = e.Department
GROUP BY d.Department, d.Budget
ORDER BY RemainingBudgetDifference ASC;


-- ------------------------------------------------------------
-- Q13: How do discount rates impact average sales order profit?
-- Demonstrates: AVG(), GROUP BY on discount rates
-- ------------------------------------------------------------
SELECT 
    Discount, 
    COUNT(OrderID) AS OrderCount,
    ROUND(AVG(Sales), 2) AS AvgSales, 
    ROUND(AVG(Profit), 2) AS AvgProfit
FROM sales
GROUP BY Discount
ORDER BY Discount ASC;
