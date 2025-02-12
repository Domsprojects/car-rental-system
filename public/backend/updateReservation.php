<?php
include('DB.php');
session_start();
$zaktualizowano = false;

if ($_POST['id_rezerwacji'] && $_POST['poczatek'] && $_POST['koniec']) {
    $id_rezerwacji = $_POST['id_rezerwacji'];
    $poczatek = $_POST['poczatek'];
    $koniec = $_POST['koniec'];

    $stmt = $conn->prepare("UPDATE rezerwacje SET poczatek=?, koniec=? WHERE id_rezerwacji=?");
    $stmt->bind_param("ssi", $poczatek, $koniec, $id_rezerwacji);
    $stmt->execute();
    $zaktualizowano = true;
}
$conn->close();
echo json_encode($zaktualizowano);
