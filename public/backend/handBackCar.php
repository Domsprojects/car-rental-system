<?php
include('DB.php');
session_start();
$zaktualizowano = false;

if ($_POST['id_rezerwacji']) {
    $id_rezerwacji = $_POST['id_rezerwacji'];
    $id_uzytkownika = $_POST['id_uzytkownika'];
    $id_samochodu = $_POST['id_samochodu'];
    $poczatek = $_POST['poczatek'];
    $koniec = $_POST['koniec'];
    $status = 'zaakceptowane';

    // $stmt = $conn->prepare("INSERT INTO archiwum (id_uzytkownika, id_samochodu, poczatek, koniec, status) VALUES (?, ?, ?, ?, ?); ");
    // $stmt->bind_param("iisss", $id_uzytkownika, $id_samochodu, $poczatek, $koniec, $status);
    // $stmt->execute();

    $stmt = $conn->prepare("DELETE FROM rezerwacje WHERE id_rezerwacji=?");
    $stmt->bind_param("i", $id_rezerwacji);
    $stmt->execute();

    $zaktualizowano = true;
}
$conn->close();
echo json_encode($zaktualizowano);
