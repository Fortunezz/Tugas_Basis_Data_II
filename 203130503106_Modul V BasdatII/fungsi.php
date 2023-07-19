<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "203130503106_toko_sepatu";
$koneksi = mysqli_connect($host, $username, $password, $database);
function connect()
{
    global $koneksi;
    if (!$koneksi) {
        die('koneksi gagal:' . mysql_error());
    }
}
function query($sql)
{
    global $koneksi;
    $result = mysqli_query($koneksi, $sql);
    return $result;
}
function MasukDataMerk($id_merk, $nama_merk, $model_sepatu)
{
    global $koneksi;
    $result = mysqli_query($koneksi, "call MasukDataMerk('$id_merk','$nama_merk','$model_sepatu')");
    return $result;
}
function MasukDataSepatu($id_sepatu, $id_merk, $ukuran, $warna, $harga, $stok)
{
    global $koneksi;
    $result2 = mysqli_query($koneksi, "call MasukDataSepatu('$id_sepatu','$id_merk','$ukuran','$warna','$harga','$stok')");
    return $result2;
}
function MasukDataDetail($id_detail, $id_sepatu, $jumlah_beli)
{
    global $koneksi;
    $result3 = mysqli_query($koneksi, "call MasukDataDetail('$id_detail','$id_sepatu','$jumlah_beli')");
    return $result3;
}
function MasukDataHeader($no_nota, $tanggal, $id_detail, $total_pembelian, $bayar, $sisa_bayar)
{
    global $koneksi;
    $result4 = mysqli_query($koneksi, "call MasukDataHeader('$no_nota','$tanggal','$id_detail', '$total_pembelian', '$bayar', '$sisa_bayar')");
    return $result4;
}

function DeleteDataMerk($id_merk)
{
    global $koneksi;
    $result5 = mysqli_query($koneksi, "call DeleteDataMerk('$id_merk')");
    return $result5;
}
function DeleteDataSepatu($id_sepatu)
{
    global $koneksi;
    $result5 = mysqli_query($koneksi, "call DeleteDataSepatu('$id_sepatu')");
    return $result5;
}
