<?php
include('DB.php');
session_start();
$zaktualizowano = false;

if ($_POST['id'] && $_POST['email'] && $_POST['funkcja'] && $_POST['status']) {
    $id = $_POST['id'];
    $email = $_POST['email'];
    $funkcja = $_POST['funkcja'];
    $status = $_POST['status'];

    $stmt = $conn->prepare("UPDATE uzytkownicy SET funkcja=?, status=? WHERE id_uzytkownika=? AND email=?");
    $stmt->bind_param("ssis", $funkcja, $status, $id, $email);
    $stmt->execute();

    $zaktualizowano = true;
}
$conn->close();
echo json_encode($zaktualizowano);
