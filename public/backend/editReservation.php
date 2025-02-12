<?php
include('DB.php');
session_start();
$zaktualizowano = false;

if ($_POST['id_rezerwacji'] && $_POST['poczatek'] && $_POST['koniec']) {
    $id_rezerwacji = $_POST['id_rezerwacji'];
    $poczatek = $_POST['poczatek'];
    $koniec = $_POST['koniec'];
    $status = 'zaakceptowane';

    $stmt = $conn->prepare("UPDATE rezerwacje SET poczatek=?, koniec=?, status=? WHERE id_rezerwacji=?");
    $stmt->bind_param("sssi", $poczatek, $koniec, $status, $id_rezerwacji);
    $stmt->execute();

    $id_samochodu = $_POST['id_samochodu'];
    $stmt = $conn->prepare("DELETE FROM rezerwacje WHERE id_samochodu=? AND status='oczekujace'");
    $stmt->bind_param("i", $id_samochodu);
    $stmt->execute();

    $zaktualizowano = true;
}
$conn->close();
echo json_encode($zaktualizowano);
