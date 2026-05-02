import streamlit as st
import pymysql
import pandas as pd
import plotly.express as px

# -------------------------------
# DATABASE CONNECTION
# -------------------------------
conn = pymysql.connect(
    host="mysql",   # use "localhost" if running outside Docker
    user="root",
    password="root",
    database="library_db"
)

# -------------------------------
# PAGE CONFIG
# -------------------------------
st.set_page_config(page_title="Library Dashboard", layout="wide")
st.title("📚 Library Analytics Dashboard")

# -------------------------------
# KPI SECTION
# -------------------------------
col1, col2, col3, col4 = st.columns(4)

queries = {
    "total_books": "SELECT COUNT(*) FROM books",
    "total_members": "SELECT COUNT(*) FROM members",
    "total_borrows": "SELECT COUNT(*) FROM borrow_records",
    "overdue": """
        SELECT COUNT(*) FROM borrow_records
        WHERE return_date IS NULL AND due_date < CURDATE()
    """
}

kpi_values = {}
for key, query in queries.items():
    df = pd.read_sql(query, conn)
    kpi_values[key] = df.iloc[0, 0]

col1.metric("📘 Total Books", kpi_values["total_books"])
col2.metric("👤 Members", kpi_values["total_members"])
col3.metric("🔄 Borrow Records", kpi_values["total_borrows"])
col4.metric("⚠️ Overdue Books", kpi_values["overdue"])

st.markdown("---")

# -------------------------------
# CHART 1: MOST BORROWED BOOKS
# -------------------------------
query1 = """
SELECT b.title, COUNT(*) AS borrow_count
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.book_id
ORDER BY borrow_count DESC
LIMIT 10;
"""
df1 = pd.read_sql(query1, conn)

fig1 = px.bar(df1, x="title", y="borrow_count", title="Top 10 Most Borrowed Books")
st.plotly_chart(fig1, use_container_width=True)

# -------------------------------
# CHART 2: MONTHLY TREND
# -------------------------------
query2 = """
SELECT DATE_FORMAT(borrow_date, '%Y-%m') AS month, COUNT(*) AS total
FROM borrow_records
GROUP BY month
ORDER BY month;
"""
df2 = pd.read_sql(query2, conn)

fig2 = px.line(df2, x="month", y="total", title="Monthly Borrowing Trend")
st.plotly_chart(fig2, use_container_width=True)

# -------------------------------
# CHART 3: TOP ACTIVE MEMBERS
# -------------------------------
query3 = """
SELECT m.name, COUNT(*) AS total
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.member_id
ORDER BY total DESC
LIMIT 10;
"""
df3 = pd.read_sql(query3, conn)

fig3 = px.bar(df3, x="name", y="total", title="Top 10 Active Members")
st.plotly_chart(fig3, use_container_width=True)

# -------------------------------
# CHART 4: CATEGORY POPULARITY
# -------------------------------
query4 = """
SELECT c.category_name, COUNT(*) AS total
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
JOIN categories c ON b.category_id = c.category_id
GROUP BY c.category_id
ORDER BY total DESC;
"""
df4 = pd.read_sql(query4, conn)

fig4 = px.pie(df4, names="category_name", values="total", title="Category Popularity")
st.plotly_chart(fig4, use_container_width=True)

# -------------------------------
# CHART 5: RATING DISTRIBUTION
# -------------------------------
query5 = """
SELECT rating, COUNT(*) AS total
FROM reviews
GROUP BY rating
ORDER BY rating;
"""
df5 = pd.read_sql(query5, conn)

fig5 = px.bar(df5, x="rating", y="total", title="Rating Distribution")
st.plotly_chart(fig5, use_container_width=True)

# -------------------------------
# CLOSE CONNECTION
# -------------------------------
conn.close()
