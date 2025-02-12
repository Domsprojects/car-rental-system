<?php
include('DB.php');
$sql = "SELECT * FROM oferta";
$stmt = $conn->prepare($sql);
$stmt->execute();
$result = $stmt->get_result();
$offers = $result->fetch_all(MYSQLI_ASSOC);
echo json_encode($offers);
$conn->close();
