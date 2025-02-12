<?php
include('DB.php');

$id_uzytkownika = $_POST['id_uzytkownika'];
$sql = "SELECT oferta.marka, oferta.model, rezerwacje.id_samochodu, rezerwacje.poczatek, rezerwacje.koniec, rezerwacje.status, rezerwacje.id_rezerwacji  FROM rezerwacje
    LEFT JOIN oferta ON oferta.id_samochodu=rezerwacje.id_samochodu
    WHERE id_uzytkownika=?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id_uzytkownika);
$stmt->execute();
$result = $stmt->get_result();
$reservations = $result->fetch_all(MYSQLI_ASSOC);
echo json_encode($reservations);
$conn->close();
