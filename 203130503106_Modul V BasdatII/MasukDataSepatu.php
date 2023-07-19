<?php
if($_POST['action2']=="") {
$id_sepatu = $_POST['id_sepatu'];
$id_merk = $_POST['id_merk'];
$ukuran = $_POST['ukuran'];
$warna = $_POST['warna'];
$harga = $_POST['harga'];
$stok = $_POST['stok'];
include("fungsi.php");
connect();
MasukDataSepatu($id_sepatu,$id_merk,$ukuran,$warna, $harga, $stok);
header('Location:index.php');
} ?>’