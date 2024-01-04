<?php
session_start();
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


$db_host = 'localhost';
$db_name = 'sample';
$db_user = 'root';
$db_password = '';


$connection = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_password);
$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


$fname = $_POST['fname'] ?? '';
$lname = $_POST['lname'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';
$role = $_POST['role'] ?? ''; 


$hashedPassword = password_hash($password, PASSWORD_DEFAULT);


$checkUserQuery = "SELECT COUNT(*) AS count FROM users WHERE email = :email";
$checkUserStmt = $connection->prepare($checkUserQuery);
$checkUserStmt->bindParam(':email', $email);
$checkUserStmt->execute();
$userCount = $checkUserStmt->fetch(PDO::FETCH_ASSOC)['count'];

if ($userCount > 0) {
    echo json_encode(['success' => false, 'message' => 'User with this email already exists']);
} else {
  
    if ($role === 'admin' || $role === 'user') {
        
        $sql = "CALL InsertUser(:fname, :lname, :email, :password, :role)";
        $stmt = $connection->prepare($sql);
        $stmt->bindParam(':fname', $fname);
        $stmt->bindParam(':lname', $lname);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->bindParam(':role', $role);
        $stmt->execute();

    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    echo json_encode($result);
   } else {
    echo json_encode(['success' => false, 'message' => 'Invalid role']);
}
}
