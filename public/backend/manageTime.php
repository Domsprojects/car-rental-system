<?php
include('DB.php');

if ($_POST['akcja'] == "stop") {
    $conn->query("ALTER EVENT dodaj_czas DISABLE");
    $conn->query("ALTER EVENT odejmij_czas DISABLE");
} else if ($_POST['akcja'] == "przyspiesz") {
    $conn->query("ALTER EVENT odejmij_czas DISABLE");
    $conn->query("ALTER EVENT dodaj_czas ENABLE");
} else if ($_POST['akcja'] == "cofnij") {
    $conn->query("ALTER EVENT dodaj_czas DISABLE");
    $conn->query("ALTER EVENT odejmij_czas ENABLE");
}
$conn->close();

echo (json_encode(true));
