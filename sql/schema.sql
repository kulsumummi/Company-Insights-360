-- ============================================================
-- Company Insights 360 — MySQL Database Schema
-- Database Name: company_insights_db
-- Description: DDL script to set up tables and relationships
-- ============================================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS company_insights_db;
USE company_insights_db;

-- 2. Drop tables if they already exist (for fresh initialization)
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 3. Create 'departments' Master Table
CREATE TABLE departments (
    Department VARCHAR(50) NOT NULL,
    Manager VARCHAR(100) NOT NULL,
    Budget INT NOT NULL,
    Headcount INT NOT NULL,
    PRIMARY KEY (Department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Create 'employees' HR Table
CREATE TABLE employees (
    EmployeeID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Salary INT NOT NULL,
    HireDate DATE NOT NULL,
    PerformanceScore DECIMAL(3, 1) NOT NULL,
    ManagerID INT NOT NULL,
    Experience INT NOT NULL,
    PRIMARY KEY (EmployeeID),
    CONSTRAINT fk_employees_department 
        FOREIGN KEY (Department) 
        REFERENCES departments(Department) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Create 'sales' Transactions Table
CREATE TABLE sales (
    OrderID INT NOT NULL,
    EmployeeID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Sales DECIMAL(10, 2) NOT NULL,
    Profit DECIMAL(10, 2) NOT NULL,
    Discount DECIMAL(4, 2) NOT NULL,
    Date DATE NOT NULL,
    PRIMARY KEY (OrderID),
    CONSTRAINT fk_sales_employee 
        FOREIGN KEY (EmployeeID) 
        REFERENCES employees(EmployeeID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
