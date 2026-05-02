# 📚 Library Book Tracking & Recommendation System

## 📌 Project Overview

This project is a **full-stack data system** designed to simulate a real-world library management platform. It enables tracking of books, members, and borrowing activity while also providing **analytical insights and basic recommendation logic**.

The system is built using **MySQL (Dockerized)** for data storage and **Streamlit (Python)** for interactive visualization.

---

## 🎯 Objective

* Design a **normalized relational database**
* Track **book inventory and borrowing transactions**
* Analyze **user behavior and book popularity**
* Implement **basic recommendation logic**
* Build a **dashboard for decision-making**

---

## 🛠️ Tech Stack

* **Database:** MySQL (Docker)
* **Backend/Data Processing:** SQL
* **Visualization:** Python (Streamlit, Plotly)
* **Containerization:** Docker

---

## 🧱 Database Schema

The system consists of the following tables:

* **Authors**
* **Categories**
* **Books**
* **Members**
* **Borrow_Records**
* **Reviews**

Key Features:

* Primary & Foreign Key relationships
* Data normalization for scalability
* Constraints for data integrity

---

## ⚙️ Key Features

### 📌 1. Book Tracking System

* Tracks available copies
* Updates inventory using SQL triggers
* Prevents over-borrowing

### 📌 2. Borrowing & Return Logic

* Maintains borrow history
* Identifies overdue books
* Tracks member activity

### 📌 3. Analytics & Insights

* Most borrowed books
* Monthly borrowing trends
* Active members
* Category-wise popularity
* Rating distribution

### 📌 4. Recommendation System (SQL-based)

* Category-based recommendations
* Popular book suggestions
* Rating-based suggestions

---

## 📊 Dashboard Highlights

Built using Streamlit, the dashboard includes:

* KPI Metrics:

  * Total Books
  * Total Members
  * Total Borrow Records
  * Overdue Books

* Visualizations:

  * Top Borrowed Books
  * Monthly Borrowing Trend
  * Top Active Members
  * Category Popularity
  * Rating Distribution

---

## 🚀 How to Run the Project

### 1. Clone the Repository

```bash
git clone <your-repo-link>
cd library-project
```

### 2. Start Docker

```bash
docker-compose up -d
```

### 3. Connect to MySQL

* Host: `127.0.0.1`
* Port: `3307`
* User: `root`
* Password: `root`

### 4. Execute SQL Files (in order)

1. `schema.sql`
2. `base_data.sql`
3. `generate_data.sql`
4. `triggers.sql`

### 5. Run Dashboard

```bash
docker-compose up --build
```

Open:

```
http://localhost:8501
```

---

## 📂 Project Structure

```
library-project/
│
├── database/
│   ├── schema.sql
│   ├── base_data.sql
│   ├── generate_data.sql
│   ├── triggers.sql
│   └── queries.sql
│
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── docker-compose.yml
└── README.md
```

---

## 📈 Key Insights

* Certain books dominate borrowing trends
* A small percentage of users are highly active
* Borrowing patterns vary across categories
* Overdue behavior highlights potential policy gaps

---

## 🧠 Learnings

* End-to-end system design using SQL + Python
* Database normalization & relationships
* Writing analytical SQL queries
* Building interactive dashboards
* Using Docker for reproducible environments

---

## 🔮 Future Improvements

* Advanced recommendation engine (user similarity)
* Fine/penalty calculation for overdue books
* Search & filtering in dashboard
* Role-based access system
* Integration with frontend UI

---

## 📬 Author

Debarati Pal

---

