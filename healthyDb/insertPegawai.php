<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$nama = $_POST['nama'];
$no_bp = $_POST['no_bp'];
$no_telp = $_POST['no_telp'];
$email = $_POST['email'];

// Query untuk menambahkan pegawai baru
$sql = "INSERT INTO pegawai (nama, no_bp, no_telp, email, tgl_input) VALUES ('$nama', '$no_bp', '$no_telp', '$email', NOW())";

// Menjalankan pernyataan SQL
if ($koneksi->query($sql) === TRUE) {
    // Menyiapkan respons JSON untuk mengindikasikan keberhasilan penyisipan data
    $response['isSuccess'] = true;
    $response['message'] = "Data berhasil disisipkan ke dalam tabel pegawai";
} else {
    // Menyiapkan respons JSON untuk mengindikasikan kegagalan penyisipan data
    $response['isSuccess'] = false;
    $response['message'] = "Gagal menyisipkan data ke dalam tabel pegawai: " . $koneksi->error;
}



// Mengirimkan respons JSON ke klien
echo json_encode($response);
