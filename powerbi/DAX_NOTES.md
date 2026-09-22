# Power BI DAX Notes & Dashboard Blueprint — Company Insights 360

This document provides the data model architecture, beginner-friendly **DAX measures**, and a **3-Page Dashboard Design Blueprint** for the **Company Insights 360** project.

---

## 🏗️ 1. Data Model & Relationships

The Power BI data model imports 3 clean tables from `data/` (`departments.csv` / `.xlsx`, `employees.csv` / `.xlsx`, `sales.csv` / `.xlsx`):

```text
  [departments] (1) ──── (N) [employees] (1) ──── (N) [sales]
   • Department               • Department            • EmployeeID
                              • EmployeeID
```

### Table Relationships Configuration:
1. **`departments` to `employees`**:
   * **Primary Key**: `departments[Department]`
   * **Foreign Key**: `employees[Department]`
   * **Cardinality**: One-to-Many (`1:*`)
   * **Cross Filter Direction**: Single (`departments` filters `employees`)

2. **`employees` to `sales`**:
   * **Primary Key**: `employees[EmployeeID]`
   * **Foreign Key**: `sales[EmployeeID]`
   * **Cardinality**: One-to-Many (`1:*`)
   * **Cross Filter Direction**: Single (`employees` filters `sales`)

---

## 🧮 2. Beginner-Friendly DAX Measures

All DAX measures use standard, easy-to-explain functions (`SUM`, `AVERAGE`, `COUNTROWS`, `DIVIDE`).

### Measure 1: Total Sales Revenue
```dax
Total Sales = SUM(sales[Sales])
```
* **Calculates**: The total sum of revenue generated across all sales transactions.
* **DAX Function**: `SUM()` adds together all values in the `Sales` column of the `sales` table.

---

### Measure 2: Total Profit
```dax
Total Profit = SUM(sales[Profit])
```
* **Calculates**: The total net profit earned across all sales orders.
* **DAX Function**: `SUM()` adds together all values in the `Profit` column of the `sales` table.

---

### Measure 3: Profit Margin %
```dax
Profit Margin % = DIVIDE([Total Profit], [Total Sales], 0)
```
* **Calculates**: The percentage of revenue converted into net profit.
* **DAX Function**: `DIVIDE()` safely divides `[Total Profit]` by `[Total Sales]`. If `[Total Sales]` is 0, it returns `0` instead of a division-by-zero error (`#DIV/0!`).

---

### Measure 4: Total Employees
```dax
Total Employees = COUNTROWS(employees)
```
* **Calculates**: The total count of active company employees.
* **DAX Function**: `COUNTROWS()` counts the total number of rows in the `employees` table.

---

### Measure 5: Average Salary
```dax
Average Salary = AVERAGE(employees[Salary])
```
* **Calculates**: The mean annual salary across employees.
* **DAX Function**: `AVERAGE()` sums all values in the `Salary` column and divides by the employee count.

---

### Measure 6: Average Performance Score
```dax
Average Performance Score = AVERAGE(employees[PerformanceScore])
```
* **Calculates**: The average employee performance rating (scale 1.0 to 5.0).
* **DAX Function**: `AVERAGE()` calculates the mean rating from the `PerformanceScore` column.

---

### Measure 7: Total Sales Orders
```dax
Total Orders = COUNTROWS(sales)
```
* **Calculates**: The total number of closed sales transactions.
* **DAX Function**: `COUNTROWS()` counts total rows in the `sales` table.

---

### Measure 8: Average Discount Rate %
```dax
Average Discount = AVERAGE(sales[Discount])
```
* **Calculates**: The average discount percentage applied across orders.
* **DAX Function**: `AVERAGE()` calculates the mean value of the `Discount` column.

---

## 📊 3. Three-Page Dashboard Design Blueprint

---

### 🟢 PAGE 1 — Executive Overview
**Objective**: Provide senior leadership with a high-level summary of organizational health, revenue performance, and key workforce metrics.

#### Visual Layout & Fields:
1. **Top KPI Cards (Row 1)**:
   * **Card 1**: `Total Sales` (Field: `[Total Sales]`, Display: Currency)
   * **Card 2**: `Total Profit` (Field: `[Total Profit]`, Display: Currency)
   * **Card 3**: `Profit Margin %` (Field: `[Profit Margin %]`, Format: `0.0%`)
   * **Card 4**: `Total Employees` (Field: `[Total Employees]`)
   * **Card 5**: `Average Salary` (Field: `[Average Salary]`)

2. **Main Charts (Middle & Bottom)**:
   * **Line Chart (Revenue Trend)**:
     * *Axis*: `sales[Date]` (Year / Month)
     * *Values*: `[Total Sales]` and `[Total Profit]`
     * *Business Question*: How are revenue and profit trending over time?
   * **Donut Chart (Revenue by Region)**:
     * *Legend*: `sales[Region]`
     * *Values*: `[Total Sales]`
     * *Business Question*: Which sales region contributes the largest share of revenue?
   * **Clustered Bar Chart (Employees by Department)**:
     * *Y-Axis*: `employees[Department]`
     * *X-Axis*: `[Total Employees]`
     * *Business Question*: Which department has the largest workforce size?

3. **Page Slicers (Top Right)**:
   * Slicer 1: `sales[Date]` (Date Range Slider)
   * Slicer 2: `sales[Region]` (Dropdown)

---

### 🔵 PAGE 2 — Sales Analysis
**Objective**: Analyze commercial revenue drivers, regional profit margins, product categories, and sales representative performance.

#### Visual Layout & Fields:
1. **KPI Header Cards**:
   * **Card 1**: `Total Sales`
   * **Card 2**: `Total Profit`
   * **Card 3**: `Profit Margin %`
   * **Card 4**: `Total Orders`

2. **Visual Charts**:
   * **Stacked Column Chart (Sales & Profit by Category)**:
     * *X-Axis*: `sales[Category]`
     * *Y-Axis*: `[Total Sales]` and `[Total Profit]`
     * *Business Question*: Which product categories drive the most revenue and profit?
   * **Clustered Bar Chart (Profit Margin % by Region)**:
     * *Y-Axis*: `sales[Region]`
     * *X-Axis*: `[Profit Margin %]`
     * *Business Question*: Which region is most efficient at generating profit?
   * **Table / Matrix Visual (Top 5 Sales Representatives)**:
     * *Rows*: `employees[Name]`, `employees[Department]`
     * *Values*: `[Total Sales]`, `[Total Profit]`, `[Total Orders]`
     * *Filter*: Top 5 N filter applied on `[Total Sales]`
     * *Business Question*: Who are our top-performing sales representatives?

3. **Interactive Slicers**:
   * Slicer 1: `sales[Date]` (Year / Quarter hierarchy)
   * Slicer 2: `sales[Region]`
   * Slicer 3: `sales[Category]`

---

### 🟣 PAGE 3 — HR Analysis
**Objective**: Evaluate employee distribution, compensation patterns, performance ratings, and demographic breakdown.

#### Visual Layout & Fields:
1. **KPI Header Cards**:
   * **Card 1**: `Total Employees`
   * **Card 2**: `Average Salary`
   * **Card 3**: `Average Performance Score`

2. **Visual Charts**:
   * **Clustered Column Chart (Average Salary by Department)**:
     * *X-Axis*: `employees[Department]`
     * *Y-Axis*: `[Average Salary]`
     * *Business Question*: How does average compensation vary across departments?
   * **Clustered Column Chart (Average Performance by Department)**:
     * *X-Axis*: `employees[Department]`
     * *Y-Axis*: `[Average Performance Score]`
     * *Business Question*: Which department achieves the highest performance rating?
   * **Donut Chart (Employees by Gender)**:
     * *Legend*: `employees[Gender]`
     * *Values*: `[Total Employees]`
     * *Business Question*: What is the gender ratio across the company?
   * **Bar Chart (Employees by City)**:
     * *Y-Axis*: `employees[City]`
     * *X-Axis*: `[Total Employees]`
     * *Business Question*: How is the workforce distributed geographically?

3. **Interactive Slicers**:
   * Slicer 1: `employees[Department]`
   * Slicer 2: `employees[City]`
   * Slicer 3: `employees[Gender]`
