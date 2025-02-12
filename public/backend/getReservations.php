<?php
include('DB.php');
if (
    $_POST['id_samochodu']
) {
    $id = $_POST['id_samochodu'];
    $sql = "SELECT * FROM rezerwacje WHERE id_samochodu=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    $offer = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode($offer);
    $conn->close();
}
