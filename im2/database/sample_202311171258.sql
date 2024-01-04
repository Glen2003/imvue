﻿--
-- Script was generated by Devart dbForge Studio 2022 for MySQL, Version 9.1.8.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 17/11/2023 12:58:24 pm
-- Server version: 10.4.28
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE sample;

--
-- Drop procedure `getAllStudent`
--
DROP PROCEDURE IF EXISTS getAllStudent;

--
-- Drop procedure `sp_insertStudent`
--
DROP PROCEDURE IF EXISTS sp_insertStudent;

--
-- Drop procedure `studUpdate`
--
DROP PROCEDURE IF EXISTS studUpdate;

--
-- Drop table `student`
--
DROP TABLE IF EXISTS student;

--
-- Set default database
--
USE sample;

--
-- Create table `student`
--
CREATE TABLE student (
  sys_id int(11) NOT NULL AUTO_INCREMENT,
  fname varchar(45) DEFAULT NULL,
  lname varchar(45) DEFAULT NULL,
  gender varchar(6) DEFAULT NULL,
  birthday varchar(12) DEFAULT NULL,
  PRIMARY KEY (sys_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

DELIMITER $$

--
-- Create procedure `studUpdate`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE studUpdate (IN p_id int,
IN p_fname varchar(45),
IN p_lname varchar(45),
IN p_gender varchar(6),
IN p_birthday varchar(12))
BEGIN
  UPDATE student
  SET fname = p_fname,
      lname = p_lname,
      gender = p_gender,
      birthday = p_birthday
  WHERE sys_id = p_id;
END
$$

--
-- Create procedure `sp_insertStudent`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE sp_insertStudent (IN p_fname varchar(45),
IN p_lname varchar(45),
IN p_gender varchar(6),
IN p_birthday varchar(12))
BEGIN
  DECLARE isEx int;
  SELECT
    COUNT(*) INTO isEx
  FROM student
  WHERE fname = p_fname
  AND lname = p_lname;

  IF isEx = 0 THEN
    INSERT INTO student (fname, lname, gender, birthday)
      VALUES (p_fname, p_lname, p_gender, p_birthday);
  END IF;
END
$$

--
-- Create procedure `getAllStudent`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE getAllStudent ()
BEGIN
  SELECT
    sys_id,
    fname,
    lname,
    gender,
    birthday
  FROM student;
END
$$

DELIMITER ;

-- 
-- Dumping data for table student
--
INSERT INTO student VALUES
(1, 'Pedro', 'Dro', 'Male', '2023-11-30'),
(2, 'fsdfds', 'sddfds', 'Female', '2023-11-16');

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;





  -- NEW UPDATES---


  CREATE DEFINER = 'root'@'localhost'
PROCEDURE sample.InsertUser(
    IN p_fname VARCHAR(50),
    IN p_lname VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(255)
)
BEGIN
    INSERT INTO users (fname, lname, email, password)
    VALUES (p_fname, p_lname, p_email, p_password);
END





  V2

  DELIMITER //

CREATE PROCEDURE InsertUser(
    IN p_fname VARCHAR(50),
    IN p_lname VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(255)
)
BEGIN
    INSERT INTO users (fname, lname, email, password, role)
    VALUES (p_fname, p_lname, p_email, p_password, 'student'); -- Assuming 'student' is the default role
END //

DELIMITER ;



--------------------------------------------------------------

---------------------------------------
CREATE DATABASE sample;

USE sample;
---------------------------------------


CREATE TABLE `sample`.`users` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `fname` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `lname` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `email` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `role` ENUM('admin', 'student') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'student',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


---------------------------------------
v3


DELIMITER //

CREATE PROCEDURE InsertUser(
    IN p_fname VARCHAR(255),
    IN p_lname VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_role VARCHAR(50)
)
BEGIN
    DECLARE userCount INT;

    SELECT COUNT(*) INTO userCount FROM users WHERE email = p_email;

    IF userCount > 0 THEN
        SELECT JSON_OBJECT('success', false, 'message', 'User with this email already exists') AS result;
    ELSE
        INSERT INTO users (fname, lname, email, password, role)
        VALUES (p_fname, p_lname, p_email, p_password, p_role);

        SELECT JSON_OBJECT('success', true, 'message', 'User data inserted successfully') AS result;
    END IF;
END //

DELIMITER ;




-----------------------------------------

CREATE DEFINER = 'root'@'localhost'
PROCEDURE sample.ResetPassword(IN userEmail VARCHAR(255), IN userFname VARCHAR(255), IN userLname VARCHAR(255), IN newPassword VARCHAR(255), OUT success INT)
BEGIN
  DECLARE userCount INT;
  
  -- Check if the provided email, first name, and last name match in the database
  SELECT COUNT(*)
  INTO userCount
  FROM users
  WHERE email = userEmail
    AND fname = userFname
    AND lname = userLname;
  
  -- If a matching record is found, update the password
  IF userCount > 0 THEN
    UPDATE users
    SET password = newPassword
    WHERE email = userEmail;
    SET success = 1;
  ELSE
    SET success = 0;
  END IF;
  
END
