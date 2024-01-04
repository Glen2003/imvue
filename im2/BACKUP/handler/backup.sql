CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---------------------------
CREATE DATABASE sample;
--------------------------
CREATE TABLE `sample`.`users` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `fname` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `lname` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `email` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `role` ENUM('admin', 'user') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-------------------------------
-- CREATE DEFINER = 'root'@'localhost'
-- PROCEDURE sample.deleteUser(IN userId INT)
-- BEGIN
--   DELETE FROM users WHERE id = userId;
-- END
--------------------------------------
CREATE DEFINER = 'root'@'localhost'
PROCEDURE sample.getAllUser()
BEGIN
  SELECT
    id,
    fname,
    lname,
    email,
    password,
    role
  FROM users;
END
---------------------------------------
CREATE DEFINER = 'root'@'localhost'
PROCEDURE sample.InsertUser(
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
END
-----------------------------
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
