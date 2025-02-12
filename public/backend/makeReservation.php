<?php
include("DB.php");
$id_samochodu = $_POST['id_samochodu'];
$id_uzytkownika = $_POST['id_uzytkownika'];
$poczatek = $_POST['poczatek'];
$koniec = $_POST['koniec'];
$status = 'oczekujace';

$stmt = $conn->prepare("INSERT INTO rezerwacje(id_uzytkownika, id_samochodu, poczatek, koniec, status) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("iisss", $id_uzytkownika, $id_samochodu, $poczatek, $koniec, $status);
$stmt->execute();

$dodanie = true;
echo (json_encode($dodanie));
