<?php
session_start();
if (!isset($_SESSION["email"])) {
    $logowanie = false;
} else {
    $logowanie = true;
}
echo (json_encode($logowanie));
