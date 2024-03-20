<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$id = $_POST['id'];
$username = $_POST['username'];

$sql = "UPDATE users SET username='$username' WHERE id='$id'";
$isSuccess = $koneksi->query($sql);

if ($isSuccess) {
    $cek = "SELECT * FROM users WHERE id = $id";
    $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
    $response['isSuccess'] = true;
    $response['value'] = 1;
    $response['message'] = "Berhasil edit user";
    $response['username'] = $result['username'];
    $response['id'] = $result['id'];
} else {
    $response['is_success'] = false;
    $response['value'] = 0;
    $response['message'] = "Gagal edit user";
}

echo json_encode($response);
