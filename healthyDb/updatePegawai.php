<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';


// Mengambil nilai data dari permintaan POST
$id = $_POST['id'];
$nama = $_POST['nama'];
$no_bp = $_POST['no_bp'];
$no_telp = $_POST['no_telp'];
$email = $_POST['email'];

// Menyiapkan pernyataan SQL untuk memperbarui data dalam tabel
$sql = "UPDATE pegawai SET nama='$nama', no_bp='$no_bp', no_telp='$no_telp', email='$email' WHERE id=$id";

// Menjalankan pernyataan SQL
if ($koneksi->query($sql) === TRUE) {
    // Menyiapkan respons JSON untuk mengindikasikan keberhasilan pembaruan data
    $response['isSuccess'] = true;
    $response['message'] = "Data berhasil diperbarui dalam tabel pegawai";
} else {
    // Menyiapkan respons JSON untuk mengindikasikan kegagalan pembaruan data
    $response['isSuccess'] = false;
    $response['message'] = 'Error: ' . $sql . '<br>'  . $koneksi->error;
}



// Mengirimkan respons JSON ke klien
echo json_encode($response);
