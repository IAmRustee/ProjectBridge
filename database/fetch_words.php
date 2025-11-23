<?php
// === ADD THESE 4 LINES HERE ===
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
// ==============================

// 1. Set the content type to JSON
header('Content-Type: application/json');
// Optional: Allow requests from any origin (Crucial for testing with Flutter)
header('Access-Control-Allow-Origin: *'); 

// --- Database Credentials ---
$servername = "localhost";
$username = "root";       // XAMPP default username
$password = "";           // XAMPP default password (often blank)
$dbname = "japanese_app";      // **CORRECTED**

// --- Connection ---
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    // If connection fails, return a JSON error
    http_response_code(500);
    echo json_encode(["error" => "Connection Failed: " . $conn->connect_error]);
    exit();
}

// --- Query ---
// **CORRECTED: Selecting japanese, romaji, and english columns from the dictionary table**
$sql = "SELECT japanese, romaji, english FROM dictionary LIMIT 100"; 

$result = $conn->query($sql);

$words_array = array();

if ($result->num_rows > 0) {
    // Fetch all results and add them to the array
    while($row = $result->fetch_assoc()) {
        $words_array[] = $row;
    }
    // Encode the PHP array into a JSON string and output it
    echo json_encode($words_array, JSON_UNESCAPED_UNICODE); // Added for Japanese support

} else {
    // No results found
    echo json_encode([]); 
}

$conn->close();
?>