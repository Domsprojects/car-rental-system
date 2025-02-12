<?php
include('DB.php');
$sql = "SELECT rezerwacje.id_rezerwacji, rezerwacje.poczatek, rezerwacje.koniec, rezerwacje.status, rezerwacje.id_samochodu, oferta.model, oferta.marka, uzytkownicy.email FROM rezerwacje
LEFT JOIN oferta ON oferta.id_samochodu=rezerwacje.id_samochodu
LEFT JOIN uzytkownicy ON rezerwacje.id_uzytkownika=uzytkownicy.id_uzytkownika";
$stmt = $conn->prepare($sql);
$stmt->execute();
$result = $stmt->get_result();
$reservations = $result->fetch_all(MYSQLI_ASSOC);
echo json_encode($reservations);
$conn->close();
