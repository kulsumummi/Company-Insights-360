# Interview Preparation Guide — Company Insights 360

This guide is specifically designed for a **Fresher Data Analyst** preparing for technical and behavioral interviews using the **Company Insights 360** project. All answers are grounded directly in the actual project code, queries, calculations, and data files.

---

## 🎯 Section 1 — Project Introduction

### Q1: Tell me about your "Company Insights 360" project. (30–60 Second Pitch)
> "In my project, **Company Insights 360**, I built an end-to-end data analytics workflow using Excel, MySQL, Python, and Power BI to analyze HR workforce metrics and sales performance across a organization. I worked with 3 datasets covering 5 departments, 100 employees, and 1,000 sales transactions. I cleaned the data using Pandas, built a relational MySQL database with 13 business queries, designed a 3-page Power BI dashboard with DAX measures, and showcased the whole project on a responsive HTML/CSS webpage. This project allowed me to practice the full data lifecycle from raw data cleaning to executive insights."

### Q2: What was the primary objective of this project?
> "The main objective was to integrate HR compensation and performance data with commercial sales transactions to answer key management questions—such as identifying our highest-earning departments, top sales representatives, regional revenue drivers, and product categories with the best profit margins."

### Q3: Why did you choose this project?
> "I chose this project because it simulates a real-world scenario where data analyst business insights are needed across multiple departments. It allowed me to apply and connect all the core skills I learned—SQL querying, Python data handling, and Power BI visualization—into one clean portfolio project."

### Q4: What business problem does it solve?
> "It helps management understand where company budget is being spent versus revenue generated. For example, it identifies whether higher salary departments deliver higher performance ratings, which regions yield the best profit margin percentage, and how discount rates impact profit margins."

### Q5: What was your specific role and contribution?
> "As the sole Data Analyst on this portfolio project, I was responsible for the entire pipeline: checking raw dataset quality, designing the MySQL database schema with foreign keys, writing 13 SQL business queries, conducting Python Pandas exploratory analysis, creating DAX measures in Power BI, and building a responsive web presentation page."

### Q6: What were your top learnings from this project?
> "I learned how crucial referential integrity is between tables, how `WHERE` differs from `HAVING` when filtering aggregated SQL data, how Pandas handles date type conversions, and how safe DAX functions like `DIVIDE()` prevent calculation errors in Power BI dashboards."

---

## 📊 Section 2 — Dataset & Architecture Questions

### Q7: What datasets did you use and how many records are there?
> "I analyzed **3 datasets**:
> 1. `departments.csv` (5 records): Department master table containing department names, managers, budgets, and headcount goals.
> 2. `employees.csv` (100 records): HR master table containing employee IDs, names, departments, salaries, performance ratings, hire dates, cities, and experience.
> 3. `sales.csv` (1,000 records): Sales order log containing order IDs, employee IDs, customer names, regions, product categories, sales revenue, profit, discount rates, and transaction dates."

### Q8: What are the primary keys and foreign keys in your database?
> * **Primary Keys**: `Department` in `departments`, `EmployeeID` in `employees`, and `OrderID` in `sales`.
> * **Foreign Keys**: `employees.Department` references `departments.Department`, and `sales.EmployeeID` references `employees.EmployeeID`."

### Q9: How are the tables related?
> "They have a chain of **One-to-Many (`1:N`) relationships**:
> * `departments` (1) → (N) `employees` on `Department` (one department employs multiple workers).
> * `employees` (1) → (N) `sales` on `EmployeeID` (one sales representative can close multiple sales orders)."

---

## 💾 Section 3 — SQL & MySQL Technical Questions

### Q10: Why did you use MySQL for this project?
> "I used MySQL because it is a reliable relational database management system. It allowed me to define explicit database tables using DDL scripts, enforce primary key and foreign key constraints (`ON DELETE CASCADE`), and write structured SQL queries to analyze data across multiple joined tables."

### Q11: How did you create the database schema?
```sql
CREATE DATABASE IF NOT EXISTS company_insights_db;
USE company_insights_db;

CREATE TABLE departments (
    Department VARCHAR(50) PRIMARY KEY,
    Manager VARCHAR(100) NOT NULL,
    Budget INT NOT NULL,
    Headcount INT NOT NULL
);

CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Salary INT NOT NULL,
    HireDate DATE NOT NULL,
    PerformanceScore DECIMAL(3,1) NOT NULL,
    ManagerID INT NOT NULL,
    Experience INT NOT NULL,
    FOREIGN KEY (Department) REFERENCES departments(Department) ON DELETE CASCADE
);

CREATE TABLE sales (
    OrderID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Sales DECIMAL(10,2) NOT NULL,
    Profit DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(4,2) NOT NULL,
    Date DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES employees(EmployeeID) ON DELETE CASCADE
);
```

### Q12: What is the difference between `WHERE` and `HAVING` in SQL?
> "`WHERE` filters raw individual rows **before** any `GROUP BY` aggregation takes place. `HAVING` filters summary group rows **after** `GROUP BY` has executed. For example, in Query 3, I used `HAVING AVG(Salary) > 80000` to filter departments whose summary average salary exceeded ₹80,000."

### Q13: How did you find departments with an average salary greater than ₹80,000?
```sql
SELECT 
    Department, 
    ROUND(AVG(Salary), 2) AS AvgSalary
FROM employees
GROUP BY Department
HAVING AVG(Salary) > 80000
ORDER BY AvgSalary DESC;
```
> * **Line-by-line breakdown**: `SELECT Department, ROUND(AVG(Salary), 2)` computes mean salary rounded to 2 decimals. `FROM employees` specifies the table. `GROUP BY Department` aggregates records per team. `HAVING AVG(Salary) > 80000` filters out departments with lower average salaries. `ORDER BY AvgSalary DESC` sorts results highest to lowest.

### Q14: How did you rank top sales representatives?
```sql
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
```
> * **Explanation**: I joined `employees` and `sales` on `EmployeeID`, grouped by employee, calculated `SUM(s.Sales)`, sorted descending, and used `LIMIT 5` to get the Top 5 sellers.

### Q15: How did you perform yearly sales analysis in MySQL?
```sql
SELECT 
    YEAR(Date) AS SalesYear, 
    ROUND(SUM(Sales), 2) AS TotalSales, 
    ROUND(SUM(Profit), 2) AS TotalProfit
FROM sales
GROUP BY YEAR(Date)
ORDER BY SalesYear ASC;
```
> * **Explanation**: I used MySQL's `YEAR(Date)` function to extract the year component from order transaction dates, grouped by year, and summed sales and profit.

---

## 🐍 Section 4 — Python & Pandas Technical Questions

### Q16: Why did you use Python and Pandas?
> "I used Python and Pandas because Pandas makes inspecting, cleaning, and validating tabular data fast and intuitive. It allowed me to check for missing values, verify row duplicates, parse date columns, and generate visual plots using Matplotlib."

### Q17: How did you inspect datasets in Pandas?
> * `df.shape`: Shows the number of rows and columns (e.g. `(100, 11)` for employees).
> * `df.head()`: Previews the top 5 rows.
> * `df.info()`: Displays non-null counts and column data types.
> * `df.describe()`: Computes summary statistics like min, max, mean, and standard deviation for numerical columns.

### Q18: How did you check for missing values and duplicates?
```python
# Check missing values
print(employees.isnull().sum())

# Check duplicates
print(employees.duplicated().sum())
```
> "In my data quality audit, `isnull().sum()` returned 0 missing values across all columns, and `duplicated().sum()` confirmed 0 duplicate rows."

### Q19: How did you convert string date fields to Pandas `datetime`?
```python
employees['HireDate'] = pd.to_datetime(employees['HireDate'])
sales['Date'] = pd.to_datetime(sales['Date'])
```
> "Converting date strings to `datetime64[ns]` objects allowed me to perform time-series analysis like extracting transaction years (`sales['Date'].dt.year`) accurately."

### Q20: How did you calculate regional profit margins in Pandas?
```python
region_summary = sales.groupby('Region').agg(
    Total_Sales=('Sales', 'sum'),
    Total_Profit=('Profit', 'sum')
).reset_index()

region_summary['Profit_Margin_%'] = ((region_summary['Total_Profit'] / region_summary['Total_Sales']) * 100).round(2)
```

---

## 📊 Section 5 — Power BI & DAX Technical Questions

### Q21: What are the three pages of your Power BI dashboard?
> 1. **Page 1 — Executive Overview**: Senior management KPI cards (`Total Sales`, `Total Profit`, `Profit Margin %`, `Total Employees`, `Average Salary`) and high-level charts.
> 2. **Page 2 — Sales Analysis**: Sales & profit by product category, regional profit margin %, and Top 5 sales representatives matrix table.
> 3. **Page 3 — HR Analysis**: Average salary by department, performance score distribution, gender ratio donut chart, and city headcount bar chart.

### Q22: Explain your DAX measures.
```dax
Total Sales = SUM(sales[Sales])
Total Profit = SUM(sales[Profit])
Profit Margin % = DIVIDE([Total Profit], [Total Sales], 0)
Total Employees = COUNTROWS(employees)
Average Salary = AVERAGE(employees[Salary])
Average Performance Score = AVERAGE(employees[PerformanceScore])
```
> * **Why `DIVIDE()`?**: I used `DIVIDE([Total Profit], [Total Sales], 0)` because it safely handles division by zero by returning `0` instead of a `#DIV/0!` error if sales are zero.

---

## 🧹 Section 6 — Data Cleaning & Validation Scenarios

### Q23: What would you do if the dataset contained missing values or duplicates?
> * **Missing Values**: I would check if missing entries can be filled using domain logic or median values. If critical primary key columns are missing, I would flag or drop those rows using `dropna()`.
> * **Duplicates**: I would identify duplicate primary key records using `duplicated(subset=['EmployeeID'])` and remove redundant rows using `drop_duplicates(keep='first')`.

### Q24: What if an employee record references a department that doesn't exist?
> "That indicates a broken foreign key reference. In SQL, `FOREIGN KEY` constraints prevent inserting invalid department names. In Pandas, I validated foreign keys using set operations `set(employees['Department']) - set(departments['Department'])`. If unmatched keys exist, I would consult the data manager to fix orphan records before analysis."

---

## 📈 Section 7 — Empirical Business Insights

### Q25: What were the main business findings from your analysis?
> 1. **Highest Average Salary**: **Finance** department offers the highest average salary at **₹84,917.65**, followed closely by **IT** at **₹84,159.09**.
> 2. **Workforce Size**: **Marketing** has the largest headcount with **23 employees**, while Finance and HR have 17 employees each.
> 3. **Top Sales Region**: **South** region generated the highest revenue at **₹1,372,223.31**.
> 4. **Best Profit Margin**: **West** region achieved the highest profit margin efficiency at **15.86%**.
> 5. **Top Product Category**: **Software** led category sales with **₹1,211,686.62** revenue.
> 6. **Top Individual Seller**: Employee **Manav** (IT Department) closed **₹111,363.93** in total sales revenue.

---

## 💡 Section 8 — Scenario-Based Questions

### Q26: If a manager asks why sales decreased in a specific period, how would you investigate?
> "I would drill down step-by-step:
> 1. Check if the drop occurred across all regions or a specific region.
> 2. Check if a particular product category lost sales.
> 3. Inspect if order volume dropped or if average discount rates increased, reducing profit margins.
> 4. Check if top-selling sales reps closed fewer deals during that period."

### Q27: If your SQL query results don't match your Pandas calculations, how would you troubleshoot?
> "I would check three things:
> 1. **Data Sources**: Verify both SQL and Pandas are querying the exact same cleaned CSV dataset.
> 2. **Filtering Differences**: Check if `WHERE` clauses in SQL match filter masks applied in Pandas.
> 3. **Aggregation Logic**: Ensure data types (e.g. integer vs float rounding) match across both tools."

---

## 🛠️ Section 9 — Realistic Fresher Challenges

### Q28: What challenges did you face during this project?
> "One challenge was ensuring date formats matched across tools—converting string dates in CSV files into proper `DATE` types in MySQL and Pandas `datetime64[ns]`. Another challenge was ensuring table joins used correct foreign key cardinalities so sales totals were not duplicated during `INNER JOIN` operations."

---

## ⚡ Section 10 — Rapid-Fire Concepts

| Term | Category | 1–2 Sentence Definition |
| :--- | :--- | :--- |
| **Primary Key** | SQL | A column containing unique values that identifies each row in a table. |
| **Foreign Key** | SQL | A column linking to a Primary Key in another table to establish relationships. |
| **`INNER JOIN`** | SQL | Combines rows from two tables where there is a matching key value in both. |
| **`HAVING`** | SQL | Filters summary group records after `GROUP BY` execution. |
| **DataFrame** | Pandas | A 2-dimensional labeled tabular data structure in Pandas. |
| **`isnull().sum()`** | Pandas | Counts total missing or NaN values per column. |
| **DAX** | Power BI | Data Analysis Expressions language used to create custom measures and calculations. |
| **`DIVIDE()`** | DAX | Performs division safely without throwing division-by-zero errors. |
| **Slicer** | Power BI | An interactive visual filter on a dashboard page allowing users to slice data dynamically. |
| **Profit Margin %** | Business | Calculated as `(Total Profit / Total Sales) * 100`. |

---

## ❓ Section 11 — Questions to Ask the Interviewer

1. *"What primary tools (SQL dialect, Power BI, Python, or cloud platforms) does the data analytics team rely on daily?"*
2. *"How are data requests typically prioritized between ad-hoc reporting and long-term dashboard building?"*
3. *"What does success look like for a fresher Data Analyst in their first 90 days at your company?"*
