CREATE DATABASE student_db;

USE student_db;

CREATE TABLE students(
    id INT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NULL,
    telegram VARCHAR(50) NULL,
    email VARCHAR(50) NULL,
    git VARCHAR(50) NULL,
    PRIMARY KEY (id)
    );


