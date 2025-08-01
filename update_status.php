<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "robot_arm_db";

$conn = mysqli_connect($host, $user, $pass, $db);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$sql = "UPDATE poses SET status = 0 WHERE status = 1";

if (mysqli_query($conn, $sql)) {
    echo "Status updated to 0";
} else {
    echo "Error: " . mysqli_error($conn);
}

mysqli_close($conn);
?>
