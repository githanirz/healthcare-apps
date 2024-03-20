<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';
$id = $_POST['id'];

// Buat query SQL untuk menghapus data berdasarkan ID
$sql = "DELETE FROM pegawai WHERE id = $id";

// Jalankan query
if ($koneksi->query($sql) === TRUE) {
    // Jika penghapusan berhasil
    $response['isSuccess'] = true;
    $response['message'] = "Data pegawai berhasil dihapus";
} else {
    // Jika terjadi kesalahan saat menghapus data
    $response['isSuccess'] = false;
    $response['message'] = 'Error: ' . $koneksi->error;
}


// Mengirimkan response dalam format JSON
echo json_encode($response);
