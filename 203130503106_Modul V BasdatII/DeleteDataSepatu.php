<?php
if (isset($_GET['id_sepatu'])) {
    $id_sepatu = $_GET['id_sepatu'];
    include("fungsi.php");
    connect();
    DeleteDataSepatu($id_sepatu);
    header('Location:index.php');
    exit();
}
