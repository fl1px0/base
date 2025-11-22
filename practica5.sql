Create Table Authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

Create Table Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    published_year DATE,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

ALTER TABLE Books ADD COLUMN genre VARCHAR(100);
ALTER Table Books ADD CONSTRAINT  check_published_year CHECK(published_year <='2025-01-01');

ALTER TABLE Books DROP COLUMN author_id;

CREATE TABLE Book_Authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id,author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

Create TABLE Temp_Table(
    temp_id INT
);


Drop Table Temp_Table