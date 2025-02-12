<?php
$email = $_POST['email'];
$haslo = password_hash($_POST['haslo'], PASSWORD_BCRYPT);
$dodanie = true;

if (isset($email, $haslo)) {
    include("DB.php");
    $sql = "SELECT * FROM uzytkownicy";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $result = $stmt->get_result();
    $uzytkownicy = $result->fetch_all(MYSQLI_ASSOC);


    foreach ($uzytkownicy as $uzytkownik) {
        if ($uzytkownik['email'] == $email) {
            $dodanie = false;
        }
    }

    if ($dodanie == true) {
        $funkcja = 'uzytkownik';
        $status = 'nieaktywny';
        $stmt = $conn->prepare("INSERT INTO uzytkownicy(email,haslo,funkcja,status) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $email, $haslo, $funkcja, $status);
        $stmt->execute();
    }
} else {
    $dodanie = false;
}

echo (json_encode($dodanie));
