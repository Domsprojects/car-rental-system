<?php
include('DB.php');
$sql = "SELECT * FROM uzytkownicy";
$stmt = $conn->prepare($sql);
$stmt->execute();
$result = $stmt->get_result();
$users = $result->fetch_all(MYSQLI_ASSOC);
echo json_encode($users);
$conn->close();
