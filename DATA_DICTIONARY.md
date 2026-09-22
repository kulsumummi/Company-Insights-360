# Data Dictionary — Company Insights 360

This document describes all datasets used in the **Company Insights 360** project. It provides field names, data types, descriptions, example values, and table relationships in clear, beginner-friendly language.

---

## 🏢 1. `departments` Table
Contains master information about company departments, budget allocation, and target headcount.

| Column Name | Data Type | Key Type | Description | Example Value |
| :--- | :--- | :--- | :--- | :--- |
| `Department` | VARCHAR(50) | **Primary Key** | Unique name of the department | `Sales`, `IT`, `HR` |
| `Manager` | VARCHAR(100) | None | Name of the department head / manager | `Ravi`, `Arjun` |
| `Budget` | INT | None | Total annual budget allocated to department (INR) | `1200000` |
| `Headcount` | INT | None | Target budgeted number of employees | `35` |

---

## 👤 2. `employees` Table
Contains HR and demographic information for all company employees.

| Column Name | Data Type | Key Type | Description | Example Value |
| :--- | :--- | :--- | :--- | :--- |
| `EmployeeID` | INT | **Primary Key** | Unique numerical ID assigned to each employee | `1` |
| `Name` | VARCHAR(100) | None | Full name of the employee | `Shreya`, `Ananya` |
| `Department` | VARCHAR(50) | **Foreign Key** | Department where employee works (links to `departments.Department`) | `Sales` |
| `Role` | VARCHAR(100) | None | Job title / designation | `Sales Executive`, `Software Engineer` |
| `City` | VARCHAR(50) | None | Work location city | `Bangalore`, `Mumbai`, `Noida` |
| `Gender` | VARCHAR(10) | None | Gender identifier (`M` / `F`) | `F` |
| `Salary` | INT | None | Annual salary in INR | `75000` |
| `HireDate` | DATE | None | Joining date (`YYYY-MM-DD`) | `2021-04-17` |
| `PerformanceScore` | DECIMAL(3,1) | None | Annual performance rating (scale 1.0 to 5.0) | `4.2` |
| `ManagerID` | INT | None | Employee ID of reporting manager | `4` |
| `Experience` | INT | None | Total years of professional work experience | `5` |

---

## 🛒 3. `sales` Table
Contains individual sales transaction records closed by sales team members.

| Column Name | Data Type | Key Type | Description | Example Value |
| :--- | :--- | :--- | :--- | :--- |
| `OrderID` | INT | **Primary Key** | Unique identifier for each sales order | `1001` |
| `EmployeeID` | INT | **Foreign Key** | ID of employee who closed the sale (links to `employees.EmployeeID`) | `35` |
| `CustomerName` | VARCHAR(100) | None | Name of the purchasing customer | `Neha Kapoor` |
| `Region` | VARCHAR(50) | None | Geographical sales territory (`North`, `South`, `East`, `West`) | `North` |
| `Category` | VARCHAR(50) | None | Product / service category (`Technology`, `Furniture`, etc.) | `Office Supplies` |
| `Sales` | DECIMAL(10,2) | None | Total transaction revenue amount | `5173.50` |
| `Profit` | DECIMAL(10,2) | None | Net profit generated from transaction | `909.99` |
| `Discount` | DECIMAL(4,2) | None | Discount rate applied (e.g. `0.05` for 5%) | `0.05` |
| `Date` | DATE | None | Date transaction occurred (`YYYY-MM-DD`) | `2024-10-10` |

---

## 🔗 Table Relationships Overview

```
 [departments] (1) <---- (N) [employees] (1) <---- (N) [sales]
  • Department               • Department               • EmployeeID
                             • EmployeeID
```

1. **`departments` to `employees`**: One-to-Many relationship on `Department`. Each department has multiple employees.
2. **`employees` to `sales`**: One-to-Many relationship on `EmployeeID`. One employee can close multiple sales orders.
