<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "robot_arm_db";

$conn = mysqli_connect($host, $user, $pass, $db);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$motor1 = $_POST['motor1'];
$motor2 = $_POST['motor2'];
$motor3 = $_POST['motor3'];
$motor4 = $_POST['motor4'];

$sql = "INSERT INTO poses (motor1, motor2, motor3, motor4, status) 
        VALUES ('$motor1', '$motor2', '$motor3', '$motor4', 1)";

if (mysqli_query($conn, $sql)) {
    echo "Pose sent for execution";
} else {
    echo "Error: " . mysqli_error($conn);
}

mysqli_close($conn);
?>
