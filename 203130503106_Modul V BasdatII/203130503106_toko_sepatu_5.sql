/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.4.24-MariaDB : Database - 203130503106_toko_sepatu
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`203130503106_toko_sepatu` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `203130503106_toko_sepatu`;

/*Table structure for table `detail_bayar` */

DROP TABLE IF EXISTS `detail_bayar`;

CREATE TABLE `detail_bayar` (
  `id_detail` int(12) NOT NULL,
  `id_sepatu` int(12) NOT NULL,
  `jumlah_beli` int(12) NOT NULL,
  PRIMARY KEY (`id_detail`),
  KEY `detail_bayar_ibfk_1` (`id_sepatu`),
  CONSTRAINT `detail_bayar_ibfk_2` FOREIGN KEY (`id_sepatu`) REFERENCES `sepatu` (`id_sepatu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `detail_bayar` */

insert  into `detail_bayar`(`id_detail`,`id_sepatu`,`jumlah_beli`) values 
(1,11,1),
(2,12,1);

/*Table structure for table `header_bayar` */

DROP TABLE IF EXISTS `header_bayar`;

CREATE TABLE `header_bayar` (
  `no_nota` int(12) NOT NULL,
  `tanggal` date NOT NULL,
  `id_detail` int(12) NOT NULL,
  `total_pembelian` int(20) NOT NULL,
  `bayar` int(40) NOT NULL,
  `sisa_bayar` int(40) NOT NULL,
  PRIMARY KEY (`no_nota`),
  KEY `header_bayar_ibfk_1` (`id_detail`),
  CONSTRAINT `header_bayar_ibfk_2` FOREIGN KEY (`id_detail`) REFERENCES `detail_bayar` (`id_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `header_bayar` */

insert  into `header_bayar`(`no_nota`,`tanggal`,`id_detail`,`total_pembelian`,`bayar`,`sisa_bayar`) values 
(11,'2023-03-01',1,400000,400000,0),
(12,'2023-03-02',2,600000,600000,0);

/*Table structure for table `merk` */

DROP TABLE IF EXISTS `merk`;

CREATE TABLE `merk` (
  `id_merk` int(12) NOT NULL,
  `nama_merk` varchar(40) NOT NULL,
  `model_sepatu` varchar(40) NOT NULL,
  PRIMARY KEY (`id_merk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `merk` */

insert  into `merk`(`id_merk`,`nama_merk`,`model_sepatu`) values 
(1,'Jordan','Livid'),
(2,'Reebok','White'),
(4,'Nikke','Aero');

/*Table structure for table `sepatu` */

DROP TABLE IF EXISTS `sepatu`;

CREATE TABLE `sepatu` (
  `id_sepatu` int(12) NOT NULL,
  `id_merk` int(12) NOT NULL,
  `ukuran` int(30) NOT NULL,
  `warna` varchar(40) NOT NULL,
  `harga` int(40) NOT NULL,
  `stok` int(40) NOT NULL,
  PRIMARY KEY (`id_sepatu`),
  KEY `sepatu_ibfk_1` (`id_merk`),
  CONSTRAINT `sepatu_ibfk_2` FOREIGN KEY (`id_merk`) REFERENCES `merk` (`id_merk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sepatu` */

insert  into `sepatu`(`id_sepatu`,`id_merk`,`ukuran`,`warna`,`harga`,`stok`) values 
(11,1,42,'Navy',400000,1),
(12,2,42,'White',300000,4),
(14,4,42,'Purple',600000,2);

/* Trigger structure for table `detail_bayar` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `EditStok` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `EditStok` AFTER INSERT ON `detail_bayar` FOR EACH ROW BEGIN
        update sepatu set stok = stok-NEW.jumlah_beli
        where id_sepatu = NEW.id_sepatu;
    END */$$


DELIMITER ;

/* Trigger structure for table `header_bayar` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `HapusDetailBayar` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `HapusDetailBayar` AFTER DELETE ON `header_bayar` FOR EACH ROW BEGIN
        delete detail_bayar from detail_bayar where id_detail = old.id_detail;
    END */$$


DELIMITER ;

/* Trigger structure for table `merk` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `HapusDataSepatu` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `HapusDataSepatu` BEFORE DELETE ON `merk` FOR EACH ROW 
BEGIN
	DECLARE id_merk INT;
	DECLARE id_sepatu INT;
	DECLARE id_detail INT;
	DECLARE no_nota INT;
	
	SELECT OLD.id_merk INTO id_merk;
    
	SELECT sepatu.id_sepatu INTO id_sepatu 
	FROM sepatu 
	INNER JOIN merk ON sepatu.id_merk = merk.id_merk
	WHERE merk.id_merk = id_merk;
    
	SELECT detail_bayar.id_detail INTO id_detail 
	FROM detail_bayar 
	INNER JOIN sepatu ON detail_bayar.id_sepatu = sepatu.id_sepatu
	INNER JOIN merk ON sepatu.id_merk = merk.id_merk
	WHERE merk.id_merk = id_merk;
            
	SELECT header_bayar.no_nota INTO no_nota 
	FROM header_bayar 
	INNER JOIN detail_bayar ON header_bayar.id_detail = detail_bayar.id_detail
	INNER JOIN sepatu ON detail_bayar.id_sepatu = sepatu.id_sepatu
	INNER JOIN merk ON sepatu.id_merk = merk.id_merk
	WHERE merk.id_merk = id_merk;
    
	CALL DeleteDataHeader(no_nota);
	CALL DeleteDataDetail(id_detail);
	CALL DeleteDataSepatu(id_sepatu);
END */$$


DELIMITER ;

/* Function  structure for function  `BuatNoNota` */

/*!50003 DROP FUNCTION IF EXISTS `BuatNoNota` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `BuatNoNota`(Nomor VARCHAR(10)) RETURNS varchar(10) CHARSET utf8mb4
BEGIN
DECLARE tgl VARCHAR(10);
DECLARE bln VARCHAR(10);
DECLARE thn VARCHAR(10);
DECLARE id VARCHAR(10);
    SELECT TRIM(SUBSTRING(tanggal,9,2)) INTO tgl FROM header_bayar WHERE no_nota=Nomor;
    SELECT TRIM(SUBSTRING(tanggal,6,2)) INTO bln FROM header_bayar WHERE no_nota=Nomor;
    SELECT TRIM(SUBSTRING(tanggal,3,2)) INTO thn FROM header_bayar WHERE no_nota=Nomor;
    SELECT TRIM(SUBSTRING(no_nota,2,2)) INTO id FROM header_bayar WHERE no_nota=Nomor;
    RETURN CONCAT(thn,bln,tgl,'-',id);
END */$$
DELIMITER ;

/* Function  structure for function  `PenghasilanHarian` */

/*!50003 DROP FUNCTION IF EXISTS `PenghasilanHarian` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `PenghasilanHarian`(tgl DATE) RETURNS int(11)
BEGIN
DECLARE total INT;
SELECT SUM(`detail_bayar`.`jumlah_beli`*`sepatu`.`harga`) INTO total FROM detail_bayar,header_bayar,sepatu
WHERE `detail_bayar`.`id_detail`=`header_bayar`.`id_detail` AND `detail_bayar`.`id_sepatu`=`sepatu`.`id_sepatu`
AND `header_bayar`.`tanggal`=tgl; RETURN total;
END */$$
DELIMITER ;

/* Procedure structure for procedure `BanyakTransaksi` */

/*!50003 DROP PROCEDURE IF EXISTS  `BanyakTransaksi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `BanyakTransaksi`()
BEGIN
SELECT COUNT(total_pembelian) AS 'Total_pembelian'
FROM header_bayar;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteDataDetail` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteDataDetail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDataDetail`(del_id_detail INT(12))
BEGIN
DELETE FROM detail_bayar WHERE id_detail=del_id_detail; END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteDataHeader` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteDataHeader` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDataHeader`(del_no_nota INT(12))
BEGIN
DELETE FROM header_bayar WHERE no_nota=del_no_nota; END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteDataMerk` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteDataMerk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDataMerk`(del_id_merk INT(12))
BEGIN
DELETE FROM merk WHERE id_merk = del_id_merk; END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteDataSepatu` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteDataSepatu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDataSepatu`(del_id_sepatu INT(12))
BEGIN
DELETE FROM sepatu WHERE id_sepatu = del_id_sepatu; END */$$
DELIMITER ;

/* Procedure structure for procedure `HitungTotalPembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `HitungTotalPembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `HitungTotalPembelian`()
BEGIN
SELECT SUM(total_pembelian) AS 'Total Pembelian' FROM header_bayar;
END */$$
DELIMITER ;

/* Procedure structure for procedure `HitungTotalPembelian2` */

/*!50003 DROP PROCEDURE IF EXISTS  `HitungTotalPembelian2` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `HitungTotalPembelian2`(NO INT(3))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND ROLLBACK;
SELECT SUM(total_pembelian) FROM header_bayar WHERE no_nota=NO;
COMMIT;
END */$$
DELIMITER ;

/* Procedure structure for procedure `MasukDataDetail` */

/*!50003 DROP PROCEDURE IF EXISTS  `MasukDataDetail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `MasukDataDetail`(id_detail INT(12),id_sepatu INT(12), jumlah_beli INT(12))
BEGIN
INSERT INTO detail_bayar (id_detail,id_sepatu,jumlah_beli) VALUES (id_detail,id_sepatu,jumlah_beli);
END */$$
DELIMITER ;

/* Procedure structure for procedure `MasukDataHeader` */

/*!50003 DROP PROCEDURE IF EXISTS  `MasukDataHeader` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `MasukDataHeader`(no_nota INT(12),tanggal DATE, id_detail INT(12), total_pembelian INT(20),
bayar INT(40),sisa_bayar INT(40))
BEGIN
INSERT INTO header_bayar (no_nota,tanggal,id_detail,total_pembelian,bayar,sisa_bayar)
VALUES
(no_nota,tanggal,id_detail,total_pembelian,bayar,sisa_bayar); END */$$
DELIMITER ;

/* Procedure structure for procedure `MasukDataMerk` */

/*!50003 DROP PROCEDURE IF EXISTS  `MasukDataMerk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `MasukDataMerk`(id_merk INT(12), nama_merk VARCHAR(40),
model_sepatu VARCHAR(40))
BEGIN
INSERT INTO merk (id_merk,nama_merk,model_sepatu)
VALUES (id_merk,nama_merk,model_sepatu);
END */$$
DELIMITER ;

/* Procedure structure for procedure `MasukDataSepatu` */

/*!50003 DROP PROCEDURE IF EXISTS  `MasukDataSepatu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `MasukDataSepatu`(id_sepatu INT(12),id_merk INT(12), ukuran INT(30),warna VARCHAR(40),harga INT(40),
stok INT(40))
BEGIN
INSERT INTO sepatu (id_sepatu,id_merk,ukuran,warna,harga,stok) VALUES (id_sepatu,id_merk,ukuran,warna,harga,stok);
END */$$
DELIMITER ;

/* Procedure structure for procedure `SepatuBanyakDibeli` */

/*!50003 DROP PROCEDURE IF EXISTS  `SepatuBanyakDibeli` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SepatuBanyakDibeli`()
BEGIN
select nama_merk as 'Merk_Sepatu', jumlah_beli as 'Paling Banyak Dibeli'
       from detail_bayar
       join sepatu on detail_bayar.id_sepatu = sepatu.id_sepatu
       JOIN merk ON sepatu.id_merk = merk.id_merk
WHERE jumlah_beli = (select max(jumlah_beli) from detail_bayar); 
END */$$
DELIMITER ;

/* Procedure structure for procedure `SepatuPalingMahal` */

/*!50003 DROP PROCEDURE IF EXISTS  `SepatuPalingMahal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SepatuPalingMahal`()
BEGIN
SELECT nama_merk AS 'Merk_Sepatu', harga AS 'Sepatu harga termahal'
       FROM sepatu
       JOIN merk ON sepatu.id_merk = merk.id_merk
WHERE harga = (SELECT MAX(harga) FROM sepatu); 
END */$$
DELIMITER ;

/* Procedure structure for procedure `SepatuPalingMurah` */

/*!50003 DROP PROCEDURE IF EXISTS  `SepatuPalingMurah` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SepatuPalingMurah`()
BEGIN
SELECT nama_merk AS 'Merk_Sepatu', harga AS 'Sepatu harga termurah'
       FROM sepatu
       JOIN merk ON sepatu.id_merk = merk.id_merk
WHERE harga = (SELECT Min(harga) FROM sepatu); 
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateDataDetail` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateDataDetail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataDetail`(IN id_details INT(12), IN jumlah_belis INT(12))
BEGIN
UPDATE detail_bayar
SET jumlah_beli = jumlah_belis WHERE id_detail = id_details;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateDataHeader` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateDataHeader` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataHeader`(IN no_notas INT(12), IN SisaBayar INT(40), IN Bayar INT(40))
BEGIN
UPDATE header_bayar
SET sisa_bayar = SisaBayar WHERE no_nota = no_notas;
UPDATE header_bayar
SET bayar = Bayar WHERE no_nota = no_notas;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateDataMerk` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateDataMerk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataMerk`(IN nama_merks VARCHAR(12),IN id_merks INT(12))
BEGIN
UPDATE merk
SET nama_merk = nama_merks WHERE id_merk = id_merks;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateDataSepatu` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateDataSepatu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataSepatu`(IN id_shoes INT(12), IN color VARCHAR(40))
BEGIN
UPDATE sepatu SET warna = color
WHERE id_sepatu = id_shoes; END */$$
DELIMITER ;

/*Table structure for table `pemasukan_harian` */

DROP TABLE IF EXISTS `pemasukan_harian`;

/*!50001 DROP VIEW IF EXISTS `pemasukan_harian` */;
/*!50001 DROP TABLE IF EXISTS `pemasukan_harian` */;

/*!50001 CREATE TABLE  `pemasukan_harian`(
 `No Nota` int(12) ,
 `Tanggal` date ,
 `Total Pembelian` decimal(41,0) 
)*/;

/*Table structure for table `sepatu_puma` */

DROP TABLE IF EXISTS `sepatu_puma`;

/*!50001 DROP VIEW IF EXISTS `sepatu_puma` */;
/*!50001 DROP TABLE IF EXISTS `sepatu_puma` */;

/*!50001 CREATE TABLE  `sepatu_puma`(
 `nama_merk` varchar(40) ,
 `model_sepatu` varchar(40) ,
 `ukuran` int(30) ,
 `warna` varchar(40) ,
 `harga` int(40) 
)*/;

/*View structure for view pemasukan_harian */

/*!50001 DROP TABLE IF EXISTS `pemasukan_harian` */;
/*!50001 DROP VIEW IF EXISTS `pemasukan_harian` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pemasukan_harian` AS (select `header_bayar`.`no_nota` AS `No Nota`,`header_bayar`.`tanggal` AS `Tanggal`,sum(`header_bayar`.`total_pembelian`) AS `Total Pembelian` from `header_bayar` group by `header_bayar`.`tanggal`) */;

/*View structure for view sepatu_puma */

/*!50001 DROP TABLE IF EXISTS `sepatu_puma` */;
/*!50001 DROP VIEW IF EXISTS `sepatu_puma` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sepatu_puma` AS (select `m`.`nama_merk` AS `nama_merk`,`m`.`model_sepatu` AS `model_sepatu`,`s`.`ukuran` AS `ukuran`,`s`.`warna` AS `warna`,`s`.`harga` AS `harga` from (`merk` `m` join `sepatu` `s` on(`m`.`id_merk` = `s`.`id_merk`)) where `m`.`nama_merk` = 'Puma') */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
