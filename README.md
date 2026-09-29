# E-Commerce SQL Analytics

A practical SQL analytics project focused on understanding e-commerce customers, orders, products, payments, revenue, and business performance using MySQL.

## 📌 Project Overview

This project uses an e-commerce database to perform customer, product, revenue, and business analysis.

The analysis starts with fundamental SQL queries and progresses to advanced techniques such as:

- JOINs
- Subqueries
- CTEs
- Window Functions
- Customer Segmentation
- Revenue Analysis
- Retention Analysis
- Ranking
- Month-over-Month Growth

The goal is to demonstrate how SQL can be used to transform transactional data into meaningful business analysis.

---

## 🗄️ Database Schema

The project contains five main tables:

| Table | Description |
|---|---|
| `customers` | Customer information such as name, city, state and signup date |
| `products` | Product information and pricing |
| `orders` | Customer orders and order status |
| `order_items` | Products and quantities included in each order |
| `payments` | Payment amounts, dates and payment status |

### Table Relationships

``text
customers
    │
    └── orders
          |
          ├── order_items ── products
          │
          └── payments


### 🛠️ Tools & Technologies
MySQL ,
SQL,
GitHub,
📚 SQL Concepts Demonstrated ,
SQL Fundamentals ,
SELECT ,
WHERE ,
DISTINCT ,
ORDER BY ,
LIMIT ,
Aggregate Functions ,
Aggregation & Analysis ,
GROUP BY ,
HAVING,
COUNT(),
SUM(),
AVG(),
MIN(),
MAX(),
CASE WHEN,
Data Relationships,
INNER JOIN,
LEFT JOIN,
Advanced SQL,
Subqueries,
Common Table Expressions (CTEs),
Window Functions,
ROW_NUMBER(),
RANK(),
DENSE_RANK(),
LAG(),
Date Analysis,
YEAR(),
MONTH(),
MONTHNAME(),
Monthly Revenue Analysis,
Month-over-Month Growth,
🔎 Business Analysis,
👥 Customer Analysis,
Total customer analysis,
Customer spending,
Top customers by revenue,
Customers with no orders,
Repeat customers,
Customer ranking,
Customer segmentation,
Customer retention analysis,

## 📦 Product Analysis
Product quantity sold
Product revenue
Top products
Product performance ranking
Revenue and quantity-based ranking

## 💰 Revenue Analysis
Total revenue
Monthly revenue
Average Order Value (AOV)
Previous month revenue
Month-over-Month revenue growth
Customer revenue contribution
🌍 City & Business Analysis
City-wise customer analysis
City-wise revenue
City-wise order analysis
Order status analysis
Overall business performance


🚀 Advanced Portfolio Analysis
Monthly Revenue Growth

## calculates:

Monthly revenue
Previous month's revenue
Month-over-Month growth percentage
Customer Retention Analysis

Classifies customers based on completed orders:

New → 1 order
Repeat → 2–3 orders
Loyal → 4+ orders
Product Performance Ranking

Ranks products independently based on:

Revenue
Quantity sold
Customer Revenue Contribution

Calculates each customer's:

Total spending
Revenue contribution percentage
Overall spending rank
Final Customer Analysis

Combines customer-level metrics including:

Total orders
Total spending
Average Order Value
First order date
Latest order date
Customer rank
Customer segment
One-time / repeat customer classification


📁 Project Files
Ecommerce-SQL-Analytics/
│
├── ecommerce_analytics.sql
├── SQL_Analysis.sql
└── README.md
ecommerce_analytics.sql

Contains the database setup, table definitions and project data.

SQL_Analysis.sql

Contains the SQL analysis queries covering basic SQL through advanced business analysis.

▶️ How to Run the Project
1. Create the Database

Open MySQL / MySQL Workbench and run:

SOURCE ecommerce_analytics.sql;

Or open and execute ecommerce_analytics.sql directly in MySQL Workbench.

2. Select the Database
USE ecommerce_analytics;
3. Run the Analysis

Open:

SQL_Analysis.sql

Execute the queries to explore the different analyses.


## 🎯 Project Objective

The objective of this project is to demonstrate practical SQL and business analytics skills by analyzing e-commerce transactional data.

The project progresses from basic SQL operations to advanced analytical techniques and business-focused insights.

## 💡 Key Skills Demonstrated
SQL Query Writing
Data Aggregation
Relational Data Analysis
Customer Analytics
Product Analytics
Revenue Analysis
Business Analysis
Advanced SQL
Window Functions
CTEs
Analytical Problem Solving

## Topic's
sql
mysql
data-analytics
sql-project
ecommerce
business-analytics
customer-analytics
data-analysis


👤 Author
Gourav Rawat
