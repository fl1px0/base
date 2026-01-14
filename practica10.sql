--1--
--Изначальная структура нарушает 1НФ, т.к. в одной ячейке хранится несколько значений, а столбцы не являются атомарными--
--Исправленная структура:--
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255)
);

CREATE TABLE ProjectTeamMembers (
    project_id INT,
    team_member_name VARCHAR(255),
    PRIMARY KEY (project_id, team_member_name),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

--2--
-- client_name → client_id, client_email  → client_id, equipment_name  →  equipment_id , (client_id, equipment_id) → rental_date
CREATE TABLE Clients (
    client_id PRIMARY KEY,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);

CREATE TABLE  Equipments (
     equipment_id PRIMARY KEY,
     equipment_name VARCHAR(255)
);

CREATE TABLE EquipmentRentals (
    client_id INT,
    equipment_id INT,
    rental_date DATE,
    PRIMARY KEY (client_id,equipment_id),
    FOREIGN KEY client_id REFERENCES Clients(client_id),
    FOREIGN KEY equipment_id REFERENCES Equipments(equipment_id)
);

--3--
--Она нарушает 1нф, т.к. в поле assignments_and_grades  неатомарные значения.

CREATE TABLE Students (
    student_id PRIMARY KEY,
    student_name VARCHAR(255)
);

CREATE TABLE Courses (
    course_id PRIMARY KEY,
    course_professor VARCHAR(255)
);

CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    assignment_name VARCHAR(255),
    grades int,
    PRIMARY KEY (student_id,course_id),
    FOREIGN KEY (student_id) REFERENCES Students (student_id),
    FOREIGN KEY (course_id) REFERENCES Courses (course_id)
);
