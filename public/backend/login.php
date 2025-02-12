<?php
$email = $_POST['email'];
$haslo = $_POST['haslo'];
$logowanie = false;

if (isset($email, $haslo)) {
    include("DB.php");
    $sql = "SELECT * FROM uzytkownicy";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $result = $stmt->get_result();
    $uzytkownicy = $result->fetch_all(MYSQLI_ASSOC);

    foreach ($uzytkownicy as $uzytkownik) {
        if ($uzytkownik['email'] == $email && password_verify($haslo, $uzytkownik['haslo']) && $uzytkownik['status'] == "aktywny") {
            $logowanie = true;
            session_start();
            $_SESSION['email'] = $email;
        }
    }
}

echo (json_encode($logowanie));
