# MySQL Database Notes — Company Insights 360

This document explains the database structure, table relationships, key SQL concepts, and individual query explanations for the **Company Insights 360** project.

---

## 🏗️ 1. Database Architecture & Tables

The database consists of **3 clean tables** in MySQL (`company_insights_db`):

### A. `departments` Table
* **Purpose**: Master table storing company department details, manager names, budgets, and headcount goals.
* **Primary Key**: `Department` (VARCHAR(50))
* **Rows**: 5 departments (`Sales`, `HR`, `IT`, `Finance`, `Marketing`).

### B. `employees` Table
* **Purpose**: Master HR dataset with employee records, salaries, performance ratings, and joining dates.
* **Primary Key**: `EmployeeID` (INT)
* **Foreign Key**: `Department` → References `departments(Department)`
* **Rows**: 100 employees.

### C. `sales` Table
* **Purpose**: Transactional log of sales orders closed by sales representatives.
* **Primary Key**: `OrderID` (INT)
* **Foreign Key**: `EmployeeID` → References `employees(EmployeeID)`
* **Rows**: 1,000 orders.

---

## 🔗 2. Why Tables Are Related (Entity Relationships)

1. **`departments` (1) to `employees` (N)**:
   * **Relationship**: One-to-Many
   * **Explanation**: One department employs multiple workers, but each worker belongs to exactly one department. Linked by `Department`.

2. **`employees` (1) to `sales` (N)**:
   * **Relationship**: One-to-Many
   * **Explanation**: One employee (sales rep) can close multiple sales orders over time. Linked by `EmployeeID`.

---

## 💡 3. Key SQL Concepts Demonstrated

### A. `WHERE` vs. `HAVING`
* **`WHERE`**: Filters **raw individual rows** *before* grouping occurs.
  * *Example*: `WHERE PerformanceScore >= 4.5` (filters individual employee records).
* **`HAVING`**: Filters **aggregated group results** *after* `GROUP BY` has executed.
  * *Example*: `HAVING AVG(Salary) > 80000` (filters summary rows after department grouping).

### B. `INNER JOIN` vs. `LEFT JOIN`
* **`INNER JOIN`**: Returns only rows where there is a matching value in **both** tables.
  * *Example*: Joining `employees` and `sales` on `EmployeeID` matches employees with their sales transactions.
* **`LEFT JOIN`**: Returns **all** rows from the left table and matched rows from the right table. (If no match, returns `NULL`).

### C. Aggregations & `GROUP BY`
* Functions like `SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()` combine multiple rows into single summary calculations.
* `GROUP BY` tells SQL how to partition the data before applying aggregations (e.g. by `Department` or `Region`).

### D. Conditional Formatting with `CASE WHEN`
* Evaluates conditions sequentially and returns a specified value when the first condition is met (equivalent to Excel IF statements).

---

## 🔍 4. Explanation of Key Queries

| Query # | Query Objective | Main SQL Clause Used | Purpose |
| :--- | :--- | :--- | :--- |
| **Q1** | Employee headcount per department | `GROUP BY`, `COUNT()` | Identifies team size across departments. |
| **Q2** | Average salary by department | `GROUP BY`, `AVG()` | Evaluates compensation levels across teams. |
| **Q3** | Departments with average salary > 80k | `HAVING` | Demonstrates filtering aggregated results. |
| **Q4** | Average performance score by department | `GROUP BY`, `AVG()` | Compares departmental productivity ratings. |
| **Q5** | High-performing employees (Score ≥ 4.5) | `WHERE` | Lists top individual talent. |
| **Q6** | Categorize performance into tiers | `CASE WHEN` | Groups employees into High, Average, and Low tiers. |
| **Q7** | Total sales & profit by region | `GROUP BY`, `SUM()` | Measures regional revenue contribution. |
| **Q8** | Region profit margin % | Calculated Expression | Determines profitability efficiency per region. |
| **Q9** | Sales & profit by product category | `GROUP BY`, `SUM()` | Highlights top product categories. |
| **Q10** | Annual sales trend | `YEAR()`, `GROUP BY` | Tracks yearly business growth from 2020 to 2024. |
| **Q11** | Top 5 employees by total sales | `INNER JOIN`, `LIMIT` | Combines HR and Sales data to spot top sellers. |
| **Q12** | Budget vs actual salary spend | `INNER JOIN`, Subtraction | Evaluates budget utilization per department. |
| **Q13** | Discount rate impact on profit | `GROUP BY` | Analyzes discount impact on average order profit. |

---

## 📌 5. Verified Facts vs. Working Assumptions

### Verified Empirical Facts (Calculated directly from datasets)
* **Row Counts**: `departments` has exactly 5 rows, `employees` has 100 rows, `sales` has 1,000 orders.
* **Foreign Key Integrity**: 100% of employees belong to one of the 5 departments; 100% of sales orders map to a valid employee ID between 1 and 100.
* **Regional & Category Ranges**: Sales dates range from 2020-01-06 to 2024-12-28. Regions are North, South, East, West.

### Working Assumptions (Not verified empirical data properties)
* **Assumption 1**: Department names (`Sales`, `HR`, `IT`, `Finance`, `Marketing`) serve as unique natural Primary Keys.
* **Assumption 2**: Each order's `EmployeeID` represents the single sales representative responsible for closing the order.

