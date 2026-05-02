USE library_db;

DELIMITER $$

-- MEMBERS
CREATE PROCEDURE generate_members()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 60 DO
        INSERT INTO members (name, email, membership_date)
        VALUES (
            CONCAT('User_', i),
            CONCAT('user', i, '@mail.com'),
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*730) DAY)
        );
        SET i = i + 1;
    END WHILE;
END$$

-- BOOKS
CREATE PROCEDURE generate_books()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 120 DO
        INSERT INTO books (
            title, author_id, category_id, publication_year, available_copies
        )
        VALUES (
            CONCAT('Book_', i),
            FLOOR(1 + RAND()*20),
            FLOOR(1 + RAND()*10),
            FLOOR(1990 + RAND()*34),
            FLOOR(2 + RAND()*8)
        );
        SET i = i + 1;
    END WHILE;
END$$

-- BORROW RECORDS
CREATE PROCEDURE generate_borrows()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE b_date DATE;
    DECLARE r_date DATE;

    WHILE i <= 250 DO

        SET b_date = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY);

        IF RAND() < 0.7 THEN
            SET r_date = DATE_ADD(b_date, INTERVAL FLOOR(5 + RAND()*20) DAY);
        ELSE
            SET r_date = NULL;
        END IF;

        INSERT INTO borrow_records (
            member_id, book_id, borrow_date, due_date, return_date
        )
        VALUES (
            FLOOR(1 + RAND()*60),
            FLOOR(1 + RAND()*120),
            b_date,
            DATE_ADD(b_date, INTERVAL 14 DAY),
            r_date
        );

        SET i = i + 1;
    END WHILE;
END$$

-- REVIEWS
CREATE PROCEDURE generate_reviews()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 120 DO
        INSERT INTO reviews (
            member_id, book_id, rating, review_text
        )
        VALUES (
            FLOOR(1 + RAND()*60),
            FLOOR(1 + RAND()*120),
            FLOOR(1 + RAND()*5),
            CONCAT('Review text ', i)
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- CALL PROCEDURES
CALL generate_members();
CALL generate_books();
CALL generate_borrows();
CALL generate_reviews();
