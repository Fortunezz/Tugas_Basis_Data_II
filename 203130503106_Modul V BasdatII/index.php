<?php
include("fungsi.php");
$action = "";
$id_merk = "";
$nama_merk = "";
$model_sepatu = "";
$action2 = "";
$id_sepatu = "";
$id_merk = "";
$ukuran = "";
$warna = "";
$harga = "";
$stok = "";
$action3 = "";
$id_detail = "";
$id_sepatu = "";
$jumlah_beli = "";
$action4 = "";
$no_nota = "";
$tanggal = "";
$id_detail = "";
$total_pembelian = "";
$bayar = "";
$sisa_bayar = "";
if (isset($_GET['action'])) {
    $action = $_GET['action'];
    $id_merk = $_GET['id_merk'];
    $nama_merk = $_GET['nama_merk'];
    $model_sepatu = $_GET['model_sepatu'];
}
if (isset($_GET['action2'])) {
    $action2 = $_GET['action2'];
    $id_sepatu = $_GET['id_sepatu'];
    $id_merk = $_GET['id_merk'];
    $ukuran = $_GET['ukuran'];
    $warna = $_GET['warna'];
    $harga = $_GET['harga'];
    $stok = $_GET['stok'];
}
if (isset($_GET['action3'])) {
    $action3 = $_GET['action3'];
    $id_detail = $_GET['id_detail'];
    $id_sepatu = $_GET['id_sepatu'];
    $jumlah_beli = $_GET['jumlah_beli'];
}
if (isset($_GET['action4'])) {
    $action4 = $_GET['action4'];
    $no_nota = $_GET['no_nota'];
    $tanggal = $_GET['tanggal'];
    $id_detail = $_GET['id_detail'];
    $total_pembelian = $_GET['total_pembelian'];
    $bayar = $_GET['bayar'];
    $sisa_bayar = $_GET['sisa_bayar'];
}
if (isset($_GET['action5']) && $_GET['action'] == 'delete' && isset($_GET['id_merk'])) {
    $id_merk = $_GET['id_merk'];
    include("fungsi.php");
    DeleteDataMerk($id_merk);
}
connect();
$result = query("Select * From merk");
$result2 = query("Select * From sepatu");
$result3 = query("Select * From detail_bayar");
$result4 = query("Select * From header_bayar");
?>
<!DOCTYPE html>
<html>

<body>
    <p1>INPUT DATA MERK</p1> </br></br>
    <form method='post' action='Masukdatamerk.php'>
        <table style="background-color: gray;">
            <tr>
                <td>ID Merk</td>
                <td>
                    <input type='text' name='id_merk' value=<?php print $id_merk ?>></input>
                </td>
            </tr>
            <tr>
                <td>Nama Merk </td>
                <td>
                    <input type='text' name='nama_merk' value=<?php print $nama_merk ?>></input>
                </td>
            </tr>
            <tr>
                <td>Model Sepatu</td>
                <td>
                    <input type='text' name='model_sepatu' value=<?php print $model_sepatu ?>></input>
                </td>
            </tr>
            <tr>
                <td></td>
                <td align='right'>
                    <input type='submit' value='Save'></input>
                    <input type='hidden' value='<?php print $action ?>' name='action'></input>
                </td>
            </tr>
        </table>
    </form>
    <table style="background-color: gray;" border=1>
        <tr>
            <th>ID Merk</th>
            <th>Nama Merk</th>
            <th>Model Sepatu </th>
        </tr>
        <?php
        $action = "";
        foreach ($result as $d) { ?>
            <tr>
                <td><?php echo $d["id_merk"]; ?></td>
                <td><?php echo $d["nama_merk"]; ?></td>
                <td><?php echo $d["model_sepatu"]; ?></td>
            </tr>
        <?php } ?>
    </table>
    <form method='post' action='MasukDatasepatu.php'>
        <table style="background-color: gray;"> </br></br>
            <p1>INPUT DATA SEPATU</p1> </br> </br>
            <tr>
                <td>ID Sepatu </td>
                <td>
                    <input type='text' name='id_sepatu' value=<?php print $id_sepatu ?>></input>
                </td>
            </tr>
            <tr>
                <td>ID Merk </td>
                <td>
                    <input type='text' name='id_merk' value=<?php print $id_merk ?>></input>
                </td>
            </tr>
            <tr>
                <td>Ukuran</td>
                <td>
                    <input type='text' name='ukuran' value=<?php print $ukuran ?>></input>
                </td>
            </tr>
            <tr>
                <td>Warna</td>
                <td>
                    <input type='text' name='warna' value=<?php print $warna ?>></input>
                </td>
            </tr>
            <tr>
                <td>Harga</td>
                <td>
                    <input type='text' name='harga' value=<?php print $harga ?>></input>
                </td>
            </tr>
            <tr>
                <td>Stok</td>
                <td>
                    <input type='text' name='stok' value=<?php print $stok ?>></input>
                </td>
            </tr>
            <tr>
                <td></td>
                <td align='right'>
                    <input type='submit' value='Save'></input>
                    <input type='hidden' value='<?php print $action2 ?>' name='action2'></input>
                </td>
            </tr>
        </table>
    </form>
    <table style="background-color: gray;" border=1>
        <tr> <br>
            <th>ID Sepatu</th>
            <th>ID Merk</th>
            <th>Ukuran</th>
            <th>Warna</th>
            <th>Harga</th>
            <th>Stok</th>
        </tr>
        <?php
        $action2 = "";
        foreach ($result2 as $d) { ?>
            <tr>
                <td><?php echo $d["id_sepatu"]; ?></td>
                <td><?php echo $d["id_merk"]; ?></td>
                <td><?php echo $d["ukuran"]; ?></td>
                <td><?php echo $d["warna"]; ?></td>
                <td><?php echo $d["harga"]; ?></td>
                <td><?php echo $d["stok"]; ?></td>
            </tr>
        <?php } ?>
        <form method='post' action='MasukDatadetail.php'>
            <table style="background-color: gray;"> </br></br>
                <p1>INPUT DATA DETAIL BAYAR</p1> </br></br>
                <tr>
                    <td>ID Detail</td>
                    <td>
                        <input type='text' name='id_detail' value=<?php print $id_detail ?>></input>
                    </td>
                </tr>
                <tr>
                    <td>ID Sepatu</td>
                    <td>
                        <input type='text' name='id_sepatu' value=<?php print $id_sepatu ?>></input>
                    </td>
                </tr>
                <tr>
                    <td>Jumlah Beli</td>
                    <td>
                        <input type='text' name='jumlah_beli' value=<?php print $jumlah_beli ?>></input>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td align='right'>
                        <input type='submit' value='Save'></input>
                        <input type='hidden' value='<?php print $action3 ?>' name='action3'></input>
                    </td>
                </tr>
            </table>
        </form>
        <table style="background-color: gray;" border=1>
            <tr> <br>
                <th>ID Detail</th>
                <th>ID Sepatu</th>
                <th>Jumlah Beli</th>
            </tr>
            <?php
            $action3 = "";
            foreach ($result3 as $d) { ?>
                <tr style="background-color: gary;">
                    <td><?php echo $d["id_detail"]; ?></td>
                    <td><?php echo $d["id_sepatu"]; ?></td>
                    <td><?php echo $d["jumlah_beli"]; ?></td>
                </tr>
            <?php } ?>
            <form method='post' action='MasukDataheader.php'>
                <table style="background-color: gray;"> </br></br>
                    <p1>INPUT DATA HEADER BAYAR</p1> </br></br>
                    <tr>
                        <td>No Nota</td>
                        <td>
                            <input type='text' name='no_nota' value=<?php print $no_nota ?>></input>
                        </td>
                    </tr>
                    <tr>
                        <td>Tanggal</td>
                        <td>
                            <input type='date' name='tanggal' value=<?php print $tanggal ?>></input>
                        </td>
                    </tr>
                    <tr>
                        <td>ID Detail</td>
                        <td>
                            <input type='text' name='id_detail' value=<?php print $id_detail ?>></input>
                        </td>
                    </tr>
                    <tr>
                        <td>Total Pembelian</td>
                        <td>
                            <input type='text' name='total_pembelian' value=<?php print $total_pembelian ?>></input>
                        </td>
                    </tr>
                    <tr>
                        <td>Bayar</td>
                        <td>
                            <input type='text' name='bayar' value=<?php print $bayar ?>></input>
                        </td>
                    </tr>
                    <tr>
                        <td>Sisa Bayar</td>
                        <td>
                            <input type='text' name='sisa_bayar' value=<?php print $sisa_bayar ?>></input>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align='right'>
                            <input type='submit' value='Save'></input>
                            <input type='hidden' value='<?php print $action4 ?>' name='action4'></input>
                        </td>
                    </tr>
                </table>
            </form>
            <table style="background-color: gray;" border=1>
                <tr> <br>
                    <th>No Nota</th>
                    <th>Tanggal</th>
                    <th>ID Detail</th>
                    <th>Total Pembelian</th>
                    <th>Harga</th>
                    <th>Sisa Bayar</th>
                </tr>
                <?php
                $action4 = "";
                foreach ($result4 as $d) { ?>
                    <tr>
                        <td><?php echo $d["no_nota"]; ?></td>
                        <td><?php echo $d["tanggal"]; ?></td>
                        <td><?php echo $d["id_detail"]; ?></td>
                        <td><?php echo $d["total_pembelian"]; ?></td>
                        <td><?php echo $d["bayar"]; ?></td>
                        <td><?php echo $d["sisa_bayar"]; ?></td>
                    </tr>
                <?php } ?>
                <form method='post' action='MasukDatadetail.php'>
                    <table style="background-color: gray;"> </br></br>
                        <p1>INPUT DATA DETAIL BAYAR</p1> </br></br>
                        <tr>
                            <td>ID Detail</td>
                            <td>
                                <input type='text' name='id_detail' value=<?php print $id_detail ?>></input>
                            </td>
                        </tr>
                        <tr>
                            <td>ID Sepatu</td>
                            <td>
                                <input type='text' name='id_sepatu' value=<?php print $id_sepatu ?>></input>
                            </td>
                        </tr>
                        <tr>
                            <td>Jumlah Beli</td>
                            <td>
                                <input type='text' name='jumlah_beli' value=<?php print $jumlah_beli ?>></input>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td align='right'>
                                <input type='submit' value='Save'></input>
                                <input type='hidden' value='<?php print $action3 ?>' name='action3'></input>
                            </td>
                        </tr>
                    </table>
                </form>
                <table style="background-color: gray;" border=1>
                    <tr> <br>
                        <th>ID Detail</th>
                        <th>ID Sepatu</th>
                        <th>Jumlah Beli</th>
                    </tr>
                    <?php
                    $action3 = "";
                    foreach ($result3 as $d) { ?>
                        <tr style="background-color: gary;">
                            <td><?php echo $d["id_detail"]; ?></td>
                            <td><?php echo $d["id_sepatu"]; ?></td>
                            <td><?php echo $d["jumlah_beli"]; ?></td>
                        </tr>
                    <?php } ?>
                    <form method='post' action='MasukDatadetail.php'>
                        <table style="background-color: gray;"> </br></br>
                            <p1>INPUT DATA DETAIL BAYAR</p1> </br></br>
                            <tr>
                                <td>ID Detail</td>
                                <td>
                                    <input type='text' name='id_detail' value=<?php print $id_detail ?>></input>
                                </td>
                            </tr>
                            <tr>
                                <td>ID Sepatu</td>
                                <td>
                                    <input type='text' name='id_sepatu' value=<?php print $id_sepatu ?>></input>
                                </td>
                            </tr>
                            <tr>
                                <td>Jumlah Beli</td>
                                <td>
                                    <input type='text' name='jumlah_beli' value=<?php print $jumlah_beli ?>></input>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td align='right'>
                                    <input type='submit' value='Save'></input>
                                    <input type='hidden' value='<?php print $action3 ?>' name='action3'></input>
                                </td>
                            </tr>
                        </table>
                    </form>
                    <table style="background-color: gray;" border=1>
                        <tr> <br>
                            <th>ID Detail</th>
                            <th>ID Sepatu</th>
                            <th>Jumlah Beli</th>
                        </tr>
                        <?php
                        $action3 = "";
                        foreach ($result3 as $d) { ?>
                            <tr style="background-color: gary;">
                                <td><?php echo $d["id_detail"]; ?></td>
                                <td><?php echo $d["id_sepatu"]; ?></td>
                                <td><?php echo $d["jumlah_beli"]; ?></td>
                            </tr>
                        <?php } ?>


</body>

</html>