<?php
$dbhost = 'localhost';
$dbuser = 'root';
$dbpass = '';
$dbname = "203130503106_toko_sepatu";
$koneksi = new mysqli($dbhost,$dbuser,$dbpass,$dbname);
if ($koneksi->connect_error)
{
die('Database Tidak Terhubung :'. $koneksi->connect_error);
}
