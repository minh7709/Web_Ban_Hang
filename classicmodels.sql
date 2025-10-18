-- classicmodels.sql
CREATE DATABASE IF NOT EXISTS classicmodels; 
USE classicmodels;

-- Tạo bảng 'offices'
CREATE TABLE offices (
    officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    territory VARCHAR(10) NOT NULL
);

-- Tạo bảng 'employees'
CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    officeCode VARCHAR(10) NOT NULL,
    reportsTo INT,
    jobTitle VARCHAR(50) NOT NULL,
    FOREIGN KEY (officeCode) REFERENCES offices(officeCode),
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)
);

-- Tạo bảng 'customers'
CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50) NOT NULL,
    salesRepEmployeeNumber INT,
    creditLimit DECIMAL(10,2),
    FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

-- Tạo bảng 'productlines'
CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000),
    htmlDescription MEDIUMTEXT,
    image MEDIUMBLOB
);

-- Tạo bảng 'products'
CREATE TABLE products (
    productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productLine VARCHAR(50) NOT NULL,
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock SMALLINT NOT NULL,
    buyPrice DECIMAL(10,2) NOT NULL,
    MSRP DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

-- Tạo bảng 'orders'
CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE NOT NULL,
    requiredDate DATE NOT NULL,
    shippedDate DATE,
    status VARCHAR(15) NOT NULL,
    comments TEXT,
    customerNumber INT NOT NULL,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

-- Tạo bảng 'orderdetails'
CREATE TABLE orderdetails (
    orderNumber INT NOT NULL,
    productCode VARCHAR(15) NOT NULL,
    quantityOrdered INT NOT NULL,
    priceEach DECIMAL(10,2) NOT NULL,
    orderLineNumber SMALLINT NOT NULL,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
);

-- Tạo bảng 'payments'
CREATE TABLE payments (
    customerNumber INT NOT NULL,
    checkNumber VARCHAR(50) NOT NULL,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (customerNumber, checkNumber),
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);