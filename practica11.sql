--1--
-- book_id  → title, book_id → author_name, book_id → publisher_id,book_id → publisher_name, book_id → publisher_city,   publisher_id → publisher_name, publisher_city--
--Транзитивная зависимость: book_id → publisher_id → publisher_name,publisher_city--
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author_name VARCHAR(255),
    publisher_id INT,
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
)

CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(255),
    publisher_city VARCHAR(100)
)

--2--
-- car_model → (race_id,driver_id)   , car_manufacturer → car_model, finish time → (race_id,driver_id)--
--Транзитивная зависимость: (race_id,driver_id) → car_model → car_manufacturer--
CREATE TABLE Cars (
    car_model VARCHAR(100) PRIMARY KEY,      
    car_manufacturer VARCHAR(100),
)

CREATE TABLE RaceResults (
    race_id INT ,
    driver_id INT ,
    car_model VARCHAR(100),
    finish_time TIME,
    PRIMARY KEY (race_id, driver_id),
    FOREIGN KEY (car_model) REFERENCES CarModels(car_model)
)

--3--
--Зависимость нарушает нфбк, т.к. event_type , от которого зависит room name, не являестя суперключом--
CREATE TABLE EventTypeRoom (
    event_type VARCHAR(50) PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL
);


CREATE TABLE RoomBookings (
    booking_time DATETIME,
    event_name VARCHAR(255),
    event_type VARCHAR(50),
    PRIMARY KEY (booking_time, event_name),
    FOREIGN KEY (event_type) REFERENCES EventTypeRoom(event_type)
);
