<?php
session_start();
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $data = json_decode(file_get_contents("php://input"), true);
    $userId = $data['id'] ?? null;
    $newRole = $data['role'] ?? null;

    if ($userId && $newRole) {
        $servername = "localhost";
        $username = "root"; 
        $password = ""; 
        $dbname = "sample"; 

        try {
            $pdo = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

         
            $sql = "UPDATE users SET role = :role WHERE id = :id";
            $stmt = $pdo->prepare($sql);
            $stmt->bindParam(':id', $userId, PDO::PARAM_INT);
            $stmt->bindParam(':role', $newRole, PDO::PARAM_STR);

        
            $stmt->execute();

           
            echo json_encode(array("message" => "Role updated successfully"));
        } catch (PDOException $e) {
           
            echo json_encode(array("error" => "Failed to update role: " . $e->getMessage()));
        }
    } else {
        
        echo json_encode(array("error" => "User ID or new role not provided"));
    }
} else {
    
    echo json_encode(array("error" => "Unsupported request method"));
}
