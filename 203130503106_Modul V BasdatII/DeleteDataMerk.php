<?php
$conn = mysqli_connect("localhost", "root", "", "203130503106_toko_sepatu");
$id = $_GET['id_merk'];
$query = "call DeleteDataMerk('$id')";
$result = mysqli_query($conn, $query);
mysqli_close($conn);
header("Location: index.php");
