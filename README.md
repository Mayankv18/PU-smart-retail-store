PU_SmartRetail: Advanced SQL Retail Management & Analytics

📌 Project Overview

PU_SmartRetail is an end-to-end SQL-based retail database management system designed to streamline operations and extract actionable business insights. The project simulates a real-world retail environment, handling everything from customer CRM and inventory management to transactional integrity and sales reporting.

The primary goal of this project was to demonstrate advanced SQL capabilities, including automation triggers, stored procedures, and complex analytical joins.

🏗️ Database Architecture

The database follows a normalized relational schema with five core tables:

Customers: Stores demographics (City, Email) and joining history.

Categories: Logical product groupings.

Products: Inventory master data (Pricing, Stock Levels, Launch Dates).

Orders: Transaction headers (Date, Channel, Total Amount).

OrderDetails: Line-item granularity (Quantity, Unit Price).

Schema Features

Data Integrity: Enforced via Foreign Keys and Unique Constraints.

Auto-Incrementing PKs: For seamless record indexing.

Precision Typing: Using DECIMAL(10,2) for financial accuracy.

🚀 Key Technical Features

1. Automated Inventory Management (Trigger)

To prevent manual errors and overselling, I implemented an AFTER INSERT trigger on the OrderDetails table.

Function: Automatically deducts the purchased quantity from the Products table inventory every time a new order is placed.

2. Standardized Operations (Stored Procedure)

I created the AddOrder procedure to encapsulate complex order insertion logic, making the database more developer-friendly and reducing repetitive code.

3. Reporting Optimization (Views)

The sales_summary view provides an abstraction layer that allows stakeholders to view total units sold and total revenue per product without writing complex JOIN queries.

4. Performance Tuning (Indexing)

Implemented indexing on CategoryID within the Products table to optimize search performance for category-based product filtering.

📊 Business Insights Extracted

Using complex subqueries and aggregate functions, I extracted the following KPIs:

Top Performance: Identified Electronics as the highest revenue-generating category.

Market Reach: Found that Delhi is the city with the highest customer density.

Stock Efficiency: Identified "Rarely Sold Products" (products never appearing in an order) to assist in stock clearance strategies.

Customer Loyalty: Ranked customers by total lifetime value (LTV) to support targeted marketing programs.

🛠️ How to Use

Ensure you have a MySQL environment set up.

Clone this repository.

Run the Pu_retail store database.sql script to:

Create the database and tables.

Seed the database with sample data.

Initialize triggers, procedures, and views.

👨‍💻 Author

Mayank Vijayvargiya SQL & Data Analytics Enthusiast



Portfolio: [Your Portfolio Link Here]

Note: This project was built to demonstrate proficiency in SQL Database Design and Business Intelligence.
