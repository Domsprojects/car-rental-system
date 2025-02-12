<?php
include('DB.php');

$id_rezerwacji = $_POST['id_rezerwacji'];
$sql = "DELETE FROM rezerwacje WHERE id_rezerwacji=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id_rezerwacji);
$stmt->execute();
$conn->close();

echo (json_encode(true));
