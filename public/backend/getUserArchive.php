<?php
include('DB.php');
$id_uzytkownika = $_POST['id_uzytkownika'];

$sql = "SELECT archiwum.id_archiwum, archiwum.poczatek, archiwum.koniec, archiwum.status, oferta.model, oferta.marka, uzytkownicy.email FROM archiwum
    LEFT JOIN oferta ON oferta.id_samochodu=archiwum.id_samochodu
    LEFT JOIN uzytkownicy ON archiwum.id_uzytkownika=uzytkownicy.id_uzytkownika WHERE archiwum.id_uzytkownika=?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id_uzytkownika);
$stmt->execute();
$result = $stmt->get_result();
$offer = $result->fetch_all(MYSQLI_ASSOC);
echo json_encode($offer);
$conn->close();
