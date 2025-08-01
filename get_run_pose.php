<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "robot_db";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT motor1, motor2, motor3, motor4 FROM poses ORDER BY id DESC";
$result = $conn->query($sql);

$poses = [];
while ($row = $result->fetch_assoc()) {
  $poses[] = $row;
}

echo json_encode($poses);
$conn->close();
?>
