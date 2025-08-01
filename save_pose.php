<?php
// السماح بالوصول من تطبيق Flutter
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/x-www-form-urlencoded");

// الاتصال بقاعدة البيانات
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "robot_arm_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// التحقق من الاتصال
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// التحقق من أن جميع المتغيرات موجودة
if (
  isset($_POST['motor1']) &&
  isset($_POST['motor2']) &&
  isset($_POST['motor3']) &&
  isset($_POST['motor4'])
) {
  // قراءة القيم من الطلب
  $motor1 = intval($_POST['motor1']);
  $motor2 = intval($_POST['motor2']);
  $motor3 = intval($_POST['motor3']);
  $motor4 = intval($_POST['motor4']);

  // تنفيذ أمر الإدخال
  $sql = "INSERT INTO poses (motor1, motor2, motor3, motor4) 
          VALUES ('$motor1', '$motor2', '$motor3', '$motor4')";

  if ($conn->query($sql) === TRUE) {
    echo "Pose saved successfully";
  } else {
    echo "Database error: " . $conn->error;
  }
} else {
  echo "Array data missing";
}

// إغلاق الاتصال
$conn->close();
?>
