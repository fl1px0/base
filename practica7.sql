CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY, -- Уникальный идентификатор студента
    full_name VARCHAR(255) NOT NULL, -- Полное имя студента
    email VARCHAR(255) UNIQUE NOT NULL, -- Электронная почта студента (должна быть уникальной)
    start_year INT -- Год поступления студента
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY, -- Уникальный идентификатор курса
    course_name VARCHAR(255) NOT NULL, -- Название курса
    credits INT CHECK (credits > 0) -- Количество зачетных единиц курса (должно быть больше 0)
);

CREATE TABLE Enrollments (
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE, -- Ссылка на ID студента (внешний ключ)
    course_id INT REFERENCES Courses(course_id) ON DELETE CASCADE, -- Ссылка на ID курса (внешний ключ)
    grade CHAR(1), -- Оценка студента за курс (например, 'A', 'B', 'C')
    PRIMARY KEY (student_id, course_id)
);

Insert INTO Students VALUES 
(DEFAULT, 'Алексей Смирнов', 'alex@example.com', 2021),
(DEFAULT, 'Елена Кузнецова', 'elena@example.com', 2022),
(DEFAULT, 'Дмитрий Новиков', 'dima@example.com', 2021),
(DEFAULT, 'Ольга Морозова', 'olga@example.com', 2023);

Insert INTO Courses VALUES
(DEFAULT, 'Введение в программирование',5),
(DEFAULT, 'Базы данных',4),
(DEFAULT, 'Веб-технологии',4);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES (1,2,'A'),
(2,2,'B'),
(2,3,'A'),
(3,1, NULL),
(3,2, NULL),
(3,3, NULL);

Update students
set email = 'elena.kuznetsova@newmail.com'
WHERE email = 'elena@example.com'

UPDATE enrollments
set grade = 'A'
WHERE student_id= '3' and course_id='1'

DELETE FROM Students
WHERE email = 'olga@example.com';


SELECT * FROM Students

SELECT course_name, credits FROM Students

SELECT * FROM Students WHERE start_year = 2021

SELECT * FROM Courses WHERE credits > 4

SELECT * FROM Students Where email = elena.kuznetsova@newmail.com

SELECT * FROM Students where full_name LIKE 'Дмитрий&'

Select * FROM Enrollments where grade IS NULL

Select * FROM Courses Order by course_name

SELECT * FROM Students Order by start_year 

SELECT * FROM Students Order by start_year DESC LIMIT 2