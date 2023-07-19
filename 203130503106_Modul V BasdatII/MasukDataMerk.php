<?php
if ($_POST['action'] == "") {
    $id_merk = $_POST['id_merk'];
    $nama_merk = $_POST['nama_merk'];
    $model_sepatu = $_POST['model_sepatu'];
    include("fungsi.php");
    connect();
    MasukDataMerk($id_merk, $nama_merk, $model_sepatu);
    header('Location:index.php');
}
