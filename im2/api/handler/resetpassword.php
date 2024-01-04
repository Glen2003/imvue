<?php
session_start();
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$servername = "localhost"; // Replace with your server name
$username = "root"; // Replace with your database username
$password = ""; // Replace with your database password
$dbname = "sample"; // Replace with your database name

// Retrieve data from the POST request
$data = json_decode(file_get_contents("php://input"));

$email = $data->email;
$fname = $data->fname;
$lname = $data->lname;
$newPassword = $data->newPassword;


$hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $stmt = $conn->prepare("CALL sample.ResetPassword(:userEmail, :userFname, :userLname, :newPassword, @success)");
    $stmt->bindParam(':userEmail', $email, PDO::PARAM_STR);
    $stmt->bindParam(':userFname', $fname, PDO::PARAM_STR);
    $stmt->bindParam(':userLname', $lname, PDO::PARAM_STR);
    $stmt->bindParam(':newPassword', $hashedPassword, PDO::PARAM_STR);
    $stmt->execute();

    $stmt->closeCursor();

   
    $successStmt = $conn->query("SELECT @success AS success");
    $successResult = $successStmt->fetch(PDO::FETCH_ASSOC);
    $success = $successResult['success'];

    $response = [];
    if ($success == 1) {
        $response['success'] = true;
        $response['message'] = 'Password updated successfully';
    } else {
        $response['success'] = false;
        $response['message'] = 'Verification failed. Provided information does not match our records';
    }

    header('Content-Type: application/json');
    echo json_encode($response);
} catch(PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'An error occurred while resetting the password.']);
}

