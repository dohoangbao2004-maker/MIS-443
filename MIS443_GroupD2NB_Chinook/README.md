# 🎵 Chinook Music Store — Database & Business Analytics

> **MIS 443 | Practical Database Implementation for Data Analysis**

A relational database and business analytics project that recreates the **Chinook Digital Music Store** in PostgreSQL, analyzes business performance using SQL, and transforms database results into visual insights with Python.

<p align="center">

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17-4169E1?style=flat-square&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=flat-square&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Analysis-150458?style=flat-square&logo=pandas&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin-4-336791?style=flat-square)
![Status](https://img.shields.io/badge/Status-Completed-2EA44F?style=flat-square)

</p>

---

## ⚡ Project Snapshot

| | |
|---|---|
| 🗄️ **Database** | PostgreSQL 17 |
| 📊 **Analysis** | 6 Business Questions |
| 🧩 **Tables** | 11 |
| 🎵 **Tracks** | 3,503 |
| 👥 **Customers** | 59 |
| 🐍 **Python** | Pandas + SQLAlchemy |
| 📈 **Charts** | Line · Bar · Combo · Donut |
| 🛠️ **Tool** | pgAdmin 4 |

---

# 🎯 What We Built

This project follows a complete database-to-insight workflow:

```text
Original Chinook Database
          │
          ▼
   Schema Redesign
          │
          ▼
     PostgreSQL 17
          │
          ▼
    Data Validation
          │
          ▼
     SQL Analysis
          │
          ▼
 PostgreSQL → Python
          │
          ▼
 Visualization
          │
          ▼
 Business Insights
```
The redesigned database is implemented in the:
```
new_chinook
```
schema, while the original public schema is retained as the reference for validation.

# 🗄️ Database Architecture

The database contains 11 relational tables covering the main operations of a digital music store.
```
Artist ──< Album ──< Track >── Genre
                       │
                       ├── Media Type
                       │
                       └──< Invoice Line >── Invoice >── Customer
                                                     │
                                                     └── Employee
```
Playlist ──< Playlist Track >── Track
Core Entities

Artist · Album · Track · Genre · Media Type · Playlist · Employee · Customer · Invoice · Invoice Line

The complete ERD is available in erd/.

# 🔎 Business Questions

The SQL analysis focuses on six business questions rather than simple database retrieval.

01 — Revenue Trend

Is the store growing, flat, or shrinking over time?

02 — Market Performance

Which countries generate the most revenue, and is their value driven by customer volume or spending per customer?

03 — Genre Performance

Which genres earn the most, and does catalog size match demand?

04 — Unsold Catalog

How much of the catalog has never sold a single unit?

05 — Sales Agent Performance

Do sales agents differ in ability, or mainly in the number of customers assigned to them?

06 — Revenue Accumulation

How did revenue accumulate over time, and how long did it take to reach the first $1,000?

# 💡 Key Findings

📈 Revenue remained relatively stable
The store's revenue shows a relatively stable pattern over the analyzed period rather than strong long-term growth or decline.

🌎 The United States is the strongest market
The United States generates the highest revenue and also shows strong average spending per customer.

🎵 Catalog size does not directly determine genre performance
Rock has by far the largest catalog and generates the highest revenue, while several smaller genres achieve relatively strong revenue with fewer tracks.
```
Catalog size does not always correspond directly to revenue performance across genres.
```

🚫 43.4% of the catalog remains unsold
1,519 tracks, representing 43.4% of the catalog, have never generated a sale.
The unsold catalog is concentrated in particular genres, showing that customer demand is uneven across the available content.

📊 Python Visualization
The PostgreSQL database was connected directly to Python for analytical processing and visualization.
```
PostgreSQL
    │
    ▼
SQLAlchemy
    │
    ▼
Pandas DataFrame
    │
    ▼
Business Analysis
    │
    ▼
Visualization
```
**Visualizations**
|  |  |
|---|---|
|Analysis	| Visualization |
|Revenue over time	|📈 Line Chart|
|Country performance	|📊 Bar Chart|
|Genre performance	|📊 Bar Chart
|Revenue + catalog comparison	|📊📈 Combo Chart|
|Catalog distribution	|🍩 Donut Chart|
|Revenue accumulation	|📈 Line Chart|

Visual outputs are available in visualizations/.


# 🧠 SQL Techniques

The project applies both fundamental and advanced SQL concepts:
```
SELECT
WHERE
ORDER BY
GROUP BY
JOIN
LEFT JOIN
COUNT()
SUM()
AVG()
CASE
FILTER
Subqueries
CTEs
Window Functions
Date Functions
```

Examples include:

- Revenue aggregation
- Customer and market analysis
- Genre performance analysis
- Anti-joins for unsold tracks
- Conditional aggregation
- Cumulative revenue using window functions

  
# 🔄 Database Redesign

The project recreates the original Chinook database under a dedicated schema:
```
public
   ↓
new_chinook
```
The redesigned schema introduces explicit database constraints including:
- Primary keys
- Foreign keys
- NOT NULL
- CHECK
- Referential integrity
- Controlled delete behavior

The new schema was cross-checked against the original data to verify that the reimplementation remained faithful to the source.

# 📁 Repository Structure
```
MIS443-Chinook/
│
├── README.md
│
├── database/
│   ├── 00_create_database.sql
│   ├── 01_load_source_data.sql
│   ├── 02_create_new_schema.sql
│   ├── 03_load_new_chinook.sql
│   └── 04_analysis_queries.sql
│
├── python/
│   ├── chinook_analysis.ipynb
│   └── requirements.txt
│
├── erd/
│   └── chinook_erd.png
│
├── visualizations/
│   ├── revenue_trend.png
│   ├── country_revenue.png
│   ├── genre_performance.png
│   ├── unsold_catalog.png
│   ├── sales_agent_performance.png
│   └── cumulative_revenue.png
│
├── screenshots/
│   ├── database_implementation/
│   ├── sql_queries/
│   └── validation/
│
├── docs/
│   ├── database_structure.md
│   ├── schema_comparison.md
│   ├── sql_analysis.md
│   └── python_analysis.md
│
└── report/
    └── MIS443_Chinook_Report.pdf
```
# 🚀 Getting Started
1. Create the database
```00_create_database.sql```
2. Load the source data
```01_load_source_data.sql```
3. Create the redesigned schema
```02_create_new_schema.sql```
4. Populate new_chinook
```03_load_new_chinook.sql```
5. Run the analytical queries
```04_analysis_queries.sql```
6. Run Python analysis
Open:
```python/chinook_analysis.ipynb```
and connect it to the PostgreSQL database.


# 📚 Project Documentation
|  |  |
|---|---|
|Document	|Description|
|database/	|Database creation, schema and SQL implementation|
|python/	|Python connection, analysis and visualization|
|erd/	|Entity-Relationship Diagram|
|visualizations/	|Analytical charts|
|screenshots/	|pgAdmin evidence|
|docs/	|Supporting project documentation|
|report/	|Complete academic report|

---
# 👥 Team
MIS 443 — Group D2NB
|  |  |
|---|---|
|Member	|Main Contribution|
|Vũ Đông Dương	|SQL analysis, testing & documentation|
|Thân Quế Ngọc	|Project coordination, report integration & analysis|
|Văn Vũ Quỳnh Như	|SQL analysis, testing & documentation|
|Đỗ Hoàng Bảo	|Database implementation, SQL analysis & conclusions|
---

🛠️ Tech Stack
Database: PostgreSQL 17
Database Management: pgAdmin 4
Programming: SQL · Python
Analysis: Pandas
Database Connection: SQLAlchemy
Visualization: Matplotlib

<p align="center">
From relational data → analytical queries → visual insights.
MIS 443 · Chinook Digital Music Store · Group D2NB
</p> 
