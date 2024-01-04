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
    $pdo = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

   
    $query = "CALL sample.getAllUser()";
    $stmt = $pdo->prepare($query);
    $stmt->execute();

   
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

 
    header('Content-Type: application/json');
    echo json_encode($users);
} catch(PDOException $e) {
   
    echo "Connection failed: " . $e->getMessage();
}
?>
