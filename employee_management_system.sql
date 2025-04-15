-- AGILE EMPLOYEE MANAGEMENT SYSTEM (MySQL)
-- Database: employee_management

CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- Departments Table
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(100)
);

-- Employees Table with Role-Based Access
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'manager', 'employee') DEFAULT 'employee',
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
);

-- Attendance Tracking
CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    check_in DATETIME,
    check_out DATETIME,
    status ENUM('present', 'absent', 'late'),
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Leave Management
CREATE TABLE leaves (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    type ENUM('sick', 'vacation', 'personal'),
    status ENUM('pending', 'approved', 'rejected'),
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Example Query: Fetch Employees with Department Names
SELECT 
    e.id, 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.name AS department,
    e.role
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
