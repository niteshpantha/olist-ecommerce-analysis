# 🛒 Olist Brazilian E-Commerce — End-to-End Data Analysis

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

## 📌 Project Overview

This is an end-to-end data analysis project using the **Olist Brazilian E-Commerce dataset** from Kaggle. The project covers the full analyst workflow — from raw data ingestion and SQL analysis to an interactive Power BI dashboard and written business insights.

**Goal:** Analyse 100K+ orders to uncover revenue trends, geographic patterns, delivery performance issues, and customer retention opportunities for a Brazilian e-commerce marketplace.

---

## 🗂️ Project Structure

```
olist-ecommerce-analysis/
├── README.md
├── sql/
│   └── analysis_queries.sql       # 7 business questions answered in SQL
├── powerbi/
│   ├── olist_dashboard.pbix       # Power BI dashboard file
│   └── screenshots/               # Dashboard page screenshots
│   └── dax_measures.md            # Dax Measures

├── docs/
│   ├── ERD.png                    # Entity Relationship Diagram
│   └── data_dictionary.md         # Column-level data documentation
└── reports/
    └── insights_report.md         # Business insights & recommendations
```

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| PostgreSQL 17 | Database setup, data storage |
| pgAdmin 4 | SQL query execution, ERD generation |
| Power BI Desktop | Interactive dashboard |
| SQL | Business analysis queries |
| GitHub | Version control, portfolio publishing |

---

## 📊 Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

| Table | Rows | Description |
|---|---|---|
| orders | 99,441 | Master order table |
| customers | 99,441 | Customer information |
| order_items | 112,650 | Items within each order |
| order_payments | 103,886 | Payment details |
| order_reviews | 99,224 | Customer reviews |
| products | 32,951 | Product catalogue |
| sellers | 3,095 | Seller information |
| geolocation | 1,000,163 | Brazilian zip code coordinates |

---

## 🔍 SQL Business Analysis

Seven business questions answered using SQL:

1. **Monthly Revenue Trend** — How is Olist growing over time?
2. **Top Product Categories** — Which categories drive the most revenue?
3. **Customer Geography** — Which Brazilian states have the most customers?
4. **Delivery Performance** — Which states have the worst delivery delays?
5. **Delivery vs Reviews** — Does late delivery hurt customer satisfaction?
6. **Seller Performance** — Who are the top performing sellers?
7. **Customer Retention** — How many customers purchase more than once?

📂 See [`sql/analysis_queries.sql`](sql/analysis_queries.sql) for all queries with comments.

---

## 📈 Power BI Dashboard

Three-page interactive dashboard:

**Page 1 — Sales Overview**
- KPI cards: Total Revenue, Total Orders, Avg Order Value, Avg Review Score
- Monthly revenue trend line chart
- Top 10 product categories by revenue
- Payment type distribution donut chart

**Page 2 — Geography**
- Brazil map with order volume by state
- Orders by state bar chart
- State-level summary table

**Page 3 — Operations & Delivery**
- Late orders by state
- Review score distribution
- Top sellers performance table

---

## 💡 Key Findings

| # | Insight |
|---|---|
| 1 | Revenue grew **12x** from late 2016 to mid-2018, peaking at ~R$1.2M/month |
| 2 | **São Paulo accounts for 42%** of all orders — significant concentration risk |
| 3 | Late deliveries drop average review score from **4.3★ to 2.6★** |
| 4 | Northern states (AM, RR, AP) have **30%+ late delivery rates** vs SP's 5% |
| 5 | **97% of customers never return** — retention is the biggest growth opportunity |
| 6 | **Credit card dominates** at 74%, but boleto's 19% represents an underserved segment |
| 7 | Review scores are U-shaped — **57% give 5★** but **11% give 1★** |

📂 See [`reports/insights_report.md`](reports/insights_report.md) for full analysis.

---

## 🚀 How to Reproduce

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Set up PostgreSQL and create database `olist_db`
3. Run the table creation script from `sql/analysis_queries.sql`
4. Load CSVs using `\copy` commands
5. Open `powerbi/olist_dashboard.pbix` in Power BI Desktop
6. Refresh data connection to your local PostgreSQL instance

---

## 📁 Documentation

- 📘 [Data Dictionary](docs/data_dictionary.md) — Full column-level documentation for all 9 tables
- 🗺️ [ERD Diagram](docs/ERD.png) — Entity relationship diagram
- 💡 [Insights Report](reports/insights_report.md) — Business findings and recommendations

---

## 👤 Author

**Nitesh**  
Aspiring Data Analyst | SQL · Power BI · PostgreSQL  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/nitesh-pantha-310745181/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/niteshpantha/olist-ecommerce-analysis)

---

*This project was built as part of my data analyst portfolio. Dataset provided by Olist via Kaggle.*
