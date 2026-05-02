DELIMITER $$

CREATE TRIGGER after_borrow
AFTER INSERT ON borrow_records
FOR EACH ROW
BEGIN
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;
END$$

CREATE TRIGGER after_return
AFTER UPDATE ON borrow_records
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NOT NULL THEN
        UPDATE books
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;
    END IF;
END$$

DELIMITER ;
