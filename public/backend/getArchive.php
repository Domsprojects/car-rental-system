<?php
include('DB.php');

$sql = "SELECT archiwum.id_archiwum, archiwum.poczatek, archiwum.koniec, archiwum.status, oferta.model, oferta.marka, uzytkownicy.email FROM archiwum
    LEFT JOIN oferta ON oferta.id_samochodu=archiwum.id_samochodu
    LEFT JOIN uzytkownicy ON archiwum.id_uzytkownika=uzytkownicy.id_uzytkownika";

$stmt = $conn->prepare($sql);
$stmt->execute();
$result = $stmt->get_result();
$reservations = $result->fetch_all(MYSQLI_ASSOC);
echo json_encode($reservations);
$conn->close();
