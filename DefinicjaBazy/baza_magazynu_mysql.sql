
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `magazyn` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `magazyn`;


--
-- Table structure for table `dostawcy`
--

DROP TABLE IF EXISTS `dostawcy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dostawcy` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(50) NOT NULL,
  `skrocona_nazwa` varchar(20) NOT NULL,
  `adres` varchar(100) DEFAULT NULL,
  `tagi` varchar(100) NOT NULL DEFAULT '#',
  `email` varchar(50) NOT NULL,
  `zamawiac_automatycznie` tinyint(4) DEFAULT 0,
  `czestotliwosc` int(11) NOT NULL DEFAULT 0,
  `dzien_zamowienia` varchar(20) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `grupy_produktow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupy_produktow` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `pozycje_magazynowe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pozycje_magazynowe` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `opis` varchar(50) NOT NULL,
  `id_dostawcy` smallint(6) NOT NULL,
  `numer_katalogowy` varchar(50) NOT NULL,
  `kod_kreskowy` varchar(50) DEFAULT NULL,
  `zakladany_stan` int(11) NOT NULL DEFAULT 0,
  `zamawiac_automatycznie` tinyint(4) NOT NULL DEFAULT 0,
  `ilosc_w_opakowaniu` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `id_grupy_produktow` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_pozycjemagazynowe_iddostawcy` (`id_dostawcy`),
  KEY `ix_pozycjemagazynowe_idgrupyproduktow` (`id_grupy_produktow`),
  CONSTRAINT `pozycje_magazynowe_ibfk_1` FOREIGN KEY (`id_dostawcy`) REFERENCES `dostawcy` (`id`),
  CONSTRAINT `pozycje_magazynowe_ibfk_2` FOREIGN KEY (`id_grupy_produktow`) REFERENCES `grupy_produktow` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `pracownicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pracownicy` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `nazwisko` varchar(30) NOT NULL,
  `imie` varchar(30) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `stany_magazynowe`
--

DROP TABLE IF EXISTS `stany_magazynowe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stany_magazynowe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pozycji` smallint(6) NOT NULL,
  `ilosc` smallint(6) NOT NULL,
  `rodzaj` tinyint(3) unsigned NOT NULL,
  `id_pracownika` smallint(6) NOT NULL DEFAULT 1,
  `data_zamowienia` datetime(3) DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  KEY `ix_stany_magazynowe_idpoz` (`id_pozycji`),
  KEY `ix_stany_magazynowe_idpoz_rodzaj_ilosc` (`id_pozycji`,`rodzaj`,`ilosc`),
  KEY `id_pracownika` (`id_pracownika`),
  CONSTRAINT `stany_magazynowe_ibfk_1` FOREIGN KEY (`id_pozycji`) REFERENCES `pozycje_magazynowe` (`id`),
  CONSTRAINT `stany_magazynowe_ibfk_2` FOREIGN KEY (`id_pracownika`) REFERENCES `pracownicy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1436 DEFAULT CHARSET=utf8mb4;
