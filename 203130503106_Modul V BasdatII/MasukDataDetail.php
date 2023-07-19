<?php
if ($_POST['action3'] == "") {
    $id_detail = $_POST['id_detail'];
    $id_sepatu = $_POST['id_sepatu'];
    $jumlah_beli = $_POST['jumlah_beli'];
    include("fungsi.php");
    connect();
    MasukDataDetail($id_detail, $id_sepatu, $jumlah_beli);
    header('Location:index.php');
}
