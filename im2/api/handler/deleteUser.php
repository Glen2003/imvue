<?php
session_start();
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST,DELETE, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


if (isset($_GET['id'])) {
    $userId = $_GET['id'];

    $servername = "localhost"; 
    $username = "root"; 
    $password = ""; 
    $dbname = "sample"; 

    
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

      
        $sql = "DELETE FROM users WHERE id = :id";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':id', $userId, PDO::PARAM_INT);
        
     
        $stmt->execute();

        
        echo json_encode(array("message" => "User deleted successfully"));
    } catch (PDOException $e) {
       
        echo json_encode(array("error" => "Failed to delete user: " . $e->getMessage()));
    }
} else {
    
    echo json_encode(array("error" => "User ID not provided"));
}
