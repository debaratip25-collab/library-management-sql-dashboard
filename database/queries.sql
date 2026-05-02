-- MOST BORROWED BOOKS
SELECT b.title, COUNT(*) AS total_borrows
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.book_id
ORDER BY total_borrows DESC;

-- MOST ACTIVE MEMBERS
SELECT m.name, COUNT(*) AS total
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.member_id
ORDER BY total DESC;

-- OVERDUE BOOKS
SELECT m.name, b.title, br.due_date
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL
AND br.due_date < CURDATE();

-- MONTHLY TREND
SELECT DATE_FORMAT(borrow_date, '%Y-%m') AS month, COUNT(*) AS total
FROM borrow_records
GROUP BY month;

-- TOP RATED BOOKS
SELECT b.title, AVG(r.rating) AS avg_rating
FROM reviews r
JOIN books b ON r.book_id = b.book_id
GROUP BY b.book_id
ORDER BY avg_rating DESC;
