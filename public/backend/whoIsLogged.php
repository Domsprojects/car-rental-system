<?php
session_start();
if (isset($_SESSION['email'])) {
    $email = $_SESSION['email'];

    include("DB.php");
    $sql = "SELECT * FROM uzytkownicy WHERE email=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $uzytkownik = $result->fetch_assoc();

    echo (json_encode($uzytkownik));
} else {
    echo (json_encode(false));
}
