# Company Insights 360 – Sales & HR Data Analysis

A comprehensive **Data Analyst Portfolio Project** demonstrating end-to-end data preparation, MySQL database querying, Python/Pandas exploratory analysis, Power BI dashboard architecture, and HTML/CSS web presentation.

---

## 📌 1. Project Overview

**Company Insights 360** analyzes simulated departmental HR records and sales transaction logs for an organization across 5 business departments, 100 employees, and 1,000 sales transactions closed between 2020 and 2024.

The project solves practical management problems by linking employee compensation, productivity metrics, product categories, and regional sales efficiency into actionable business insights.

---

## ❓ 2. Business Questions Answered

* Which departments employ the largest workforce?
* What is the average compensation level across departments?
* Which sales region generates the highest revenue and profit?
* Which region achieves the best profit margin percentage?
* Which product categories drive the highest sales revenue?
* Who are the top sales representatives by total closed revenue?
* How has annual sales revenue trended from 2020 to 2024?
* How do discount rates impact order profitability?

---

## 📊 3. Dataset Description

The project uses **3 structured datasets** located in the `data/` folder:

1. **`departments.csv`** *(5 rows × 4 columns)*: Master department records containing `Department` (PK), `Manager`, `Budget` (INR), and `Headcount` targets.
2. **`employees.csv`** *(100 rows × 11 columns)*: HR records containing `EmployeeID` (PK), `Name`, `Department` (FK), `Role`, `City`, `Gender`, `Salary`, `HireDate`, `PerformanceScore`, `ManagerID`, and `Experience`.
3. **`sales.csv`** *(1,000 rows × 9 columns)*: Sales order logs containing `OrderID` (PK), `EmployeeID` (FK), `CustomerName`, `Region`, `Category`, `Sales`, `Profit`, `Discount`, and `Date`.

> Detailed field definitions, data types, and key constraints are documented in [DATA_DICTIONARY.md](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/DATA_DICTIONARY.md).

---

## 🛠️ 4. Tools & Technologies Used

* **Database**: MySQL (DDL Schema, Primary/Foreign Keys, Relational Constraints)
* **Querying Language**: SQL (`SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `CASE WHEN`, `INNER JOIN`)
* **Data Analysis**: Python 3, Pandas (`read_csv`, `info`, `isnull().sum`, `duplicated().sum`, `to_datetime`, `groupby`, `agg`)
* **Data Visualization**: Matplotlib (`plt.bar`, `plt.plot`), Power BI Desktop (`.pbix`)
* **DAX**: Power BI Data Analysis Expressions (`SUM`, `AVERAGE`, `COUNTROWS`, `DIVIDE`)
* **Web Showcase**: HTML5, CSS3 (Pure responsive layout, Zero JavaScript)
* **Version Control**: Git, GitHub

---

## 🔄 5. Project Workflow

```text
  CSV Data (Excel) ──> MySQL Database ──> SQL Analysis (13 Queries)
       │
       ├──> Python / Pandas Data Cleaning & Matplotlib Plots
       │
       ├──> Power BI 3-Page Dashboard Blueprint & DAX Measures
       │
       └──> HTML5 / CSS3 Portfolio Presentation Website
```

---

## 💾 6. MySQL Database Setup & Queries

Located in the `sql/` directory:

* **[sql/schema.sql](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/sql/schema.sql)**: DDL script creating `company_insights_db` with relational constraints linking `employees.Department → departments.Department` and `sales.EmployeeID → employees.EmployeeID`.
* **[sql/analysis_queries.sql](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/sql/analysis_queries.sql)**: 13 business queries covering:
  1. Department headcount (`GROUP BY`, `COUNT`)
  2. Average salary by department (`AVG`)
  3. High-salary departments filtering (`HAVING AVG(Salary) > 80000`)
  4. Average employee performance rating by department
  5. High performer list (`WHERE PerformanceScore >= 4.5`)
  6. Performance tier classification (`CASE WHEN`)
  7. Regional sales and profit totals (`SUM`)
  8. Regional profit margin percentage calculations
  9. Category revenue and profit breakdown
  10. Annual revenue trend (`YEAR(Date)`)
  11. Top 5 sales representatives (`INNER JOIN` + `LIMIT 5`)
  12. Department budget vs actual salary spend comparison
  13. Discount rate impact on profit
* **[sql/SQL_NOTES.md](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/sql/SQL_NOTES.md)**: Beginner-friendly explanations of SQL concepts (`WHERE` vs `HAVING`, `JOINs`, `GROUP BY`) and empirical facts vs assumptions.

---

## 🐍 7. Python & Pandas Data Cleaning Analysis

Located in **[python/data_cleaning.ipynb](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/python/data_cleaning.ipynb)**:

1. **Data Quality Audit**: Confirmed 0 missing values (`isnull().sum()`) and 0 duplicate records (`duplicated().sum()`).
2. **Date Field Standardization**: Converted string dates to Pandas `datetime64[ns]` objects for time-series extraction.
3. **Exploratory Data Aggregation**: Computed departmental compensation summary statistics, regional profit margins, and top sales rep revenue.
4. **Matplotlib Plotting**: Exported clean PNG charts:
   * `chart_revenue_by_region.png`
   * `chart_salary_by_dept.png`
   * `chart_yearly_trend.png`

---

## 📊 8. Power BI Dashboard & DAX Measures

Located in the `powerbi/` directory:

* **[powerbi/DAX_NOTES.md](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/powerbi/DAX_NOTES.md)**: Documents the data model schema, DAX measure definitions, and visual field blueprints.
* **[powerbi/Company_Insights_360.pbix](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/powerbi/Company_Insights_360.pbix)**: Interactive report file.

### Key DAX Measures
```dax
Total Sales = SUM(sales[Sales])
Total Profit = SUM(sales[Profit])
Profit Margin % = DIVIDE([Total Profit], [Total Sales], 0)
Total Employees = COUNTROWS(employees)
Average Salary = AVERAGE(employees[Salary])
Average Performance Score = AVERAGE(employees[PerformanceScore])
```

### 3-Page Dashboard Layout
* **Page 1 — Executive Overview**: Total Sales, Total Profit, Profit Margin %, Employees KPI cards, Revenue Line Trend, Regional Donut Chart.
* **Page 2 — Sales Analysis**: Sales & Profit by Category Column Chart, Regional Profit Margin % Bar Chart, Top 5 Sales Reps Table, Date/Category Slicers.
* **Page 3 — HR Analysis**: Average Salary by Department Column Chart, Average Performance Rating Column Chart, Gender Donut Chart, City Bar Chart, Department Slicers.

---

## 📈 9. Verified Business Insights

Calculated directly from empirical dataset values:

1. **Top Average Compensation**: **Finance** offers the highest average salary (**₹84,917.65**), closely followed by **IT** (**₹84,159.09**).
2. **Workforce Distribution**: **Marketing** has the largest workforce size (**23 employees**), while Finance and HR have 17 employees each.
3. **Regional Revenue Leader**: **South** region generates the highest total gross revenue (**₹1,372,223.31**).
4. **Highest Profit Margin Efficiency**: **West** region achieves the best profit margin (**15.86%**).
5. **Top Product Category**: **Software** is the largest product category driver (**₹1,211,686.62** revenue).
6. **Peak Growth Year**: Annual company revenue reached its 5-year peak in **2023** at **₹1,143,544.39**.
7. **Top Sales Performer**: Employee **Manav** (IT Department) generated the highest individual sales revenue (**₹111,363.93**).

---

## 🌐 10. Project Presentation Website

Located in **[website/index.html](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/website/index.html)** and **[website/style.css](file:///c:/Users/ummik/Downloads/Company_insights_360-main/Company_insights_360-main/website/style.css)**:

* Built using **100% pure HTML5 and CSS3** (Zero JavaScript).
* Provides a portfolio showcase page detailing the project workflow, datasets, MySQL queries, Python data analysis, Power BI layout, and verified insights.
* Responsive for desktop, tablet, and mobile browsers.

---

## 📂 11. Project Directory Structure

```text
Company-Insights-360/
│
├── data/
│   ├── raw/                       # Preserved raw CSV backup files
│   │   ├── departments_raw.csv
│   │   ├── employees_raw.csv
│   │   └── sales_raw.csv
│   ├── departments.xlsx           # Clean Excel Master
│   ├── employees.xlsx             # Clean Excel Master
│   ├── sales.xlsx                 # Clean Excel Master
│   ├── departments.csv            # Clean CSV Master
│   ├── employees.csv              # Clean CSV Master
│   └── sales.csv                  # Clean CSV Master
│
├── sql/
│   ├── schema.sql                 # MySQL table DDL schema & FK constraints
│   ├── analysis_queries.sql       # 13 MySQL business queries
│   └── SQL_NOTES.md               # Plain-English guide to SQL concepts & queries
│
├── python/
│   ├── data_cleaning.ipynb        # Pandas cleaning & EDA notebook
│   ├── chart_revenue_by_region.png
│   ├── chart_salary_by_dept.png
│   └── chart_yearly_trend.png
│
├── powerbi/
│   ├── Company_Insights_360.pbix  # Power BI interactive dashboard report file
│   └── DAX_NOTES.md               # Data model schema & DAX measure explanations
│
├── website/
│   ├── index.html                 # Pure HTML5 portfolio showcase page
│   └── style.css                  # Pure CSS3 responsive stylesheet
│
├── DATA_DICTIONARY.md             # Column-by-column beginner reference
├── README.md                      # Comprehensive project documentation
└── .gitignore                     # Git exclusion settings
```

---

## 🚀 12. How to Explore the Project

1. **MySQL**: Open `sql/schema.sql` in MySQL Workbench or DBeaver to execute table creation, then run `sql/analysis_queries.sql` to view business queries.
2. **Python**: Open `python/data_cleaning.ipynb` in Jupyter Notebook or VS Code and run all cells to reproduce the Pandas data cleaning and charts.
3. **Power BI**: Open `powerbi/Company_Insights_360.pbix` in Power BI Desktop or review DAX measure definitions in `powerbi/DAX_NOTES.md`.
4. **Website**: Double-click `website/index.html` in your file explorer to view the project presentation in any browser.

---

## 🎯 13. Skills Demonstrated

* MySQL Database Architecture & Table Relationships
* SQL Query Aggregations, Filtering (`HAVING`), Conditional Statements (`CASE`), and `JOINs`
* Python Exploratory Data Analysis & Data Cleaning with `pandas`
* Data Visualization with `matplotlib`
* Power BI Data Modeling & Calculated DAX Measures (`SUM`, `AVERAGE`, `COUNTROWS`, `DIVIDE`)
* Web Presentation using Pure HTML5 & CSS3
* GitHub Version Control & Technical Documentation

---

## 🔮 14. Future Improvements

* Connect Power BI directly to live MySQL database via ODBC connection.
* Add automated python scripts for periodic dataset ingestion.
* Implement dynamic date range slicers and drill-through pages in Power BI.
