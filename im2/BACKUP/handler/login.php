<?php
session_start();
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$servername = "localhost";
$username = "root"; 
$password = ""; 
$dbname = "sample"; 

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $postEmail = $_POST['email'] ?? '';
        $postPassword = $_POST['password'] ?? '';

        $stmt = $conn->prepare("SELECT id, fname, lname, email, password, role FROM users WHERE email = :email");
        $stmt->bindParam(':email', $postEmail);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($row) {
            $hashedPassword = $row['password'];
            if (password_verify($postPassword, $hashedPassword)) {
                $response = array(
                    'success' => true,
                    'message' => 'Login successful',
                    'fname' => $row['fname'],
                    'role' => $row['role']
                );
                echo json_encode($response);
            } else {
                $response = array(
                    'success' => false,
                    'message' => 'Incorrect password'
                );
                echo json_encode($response);
            }
        } else {
            $response = array('success' => false, 'message' => 'User not found');
            echo json_encode($response);
        }
    }
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>
