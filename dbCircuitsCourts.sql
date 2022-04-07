-- MySQL dump 10.19  Distrib 10.3.31-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: dbCircuitsCourts
-- ------------------------------------------------------
-- Server version	10.3.31-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Abonnement`
--

DROP TABLE IF EXISTS `Abonnement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Abonnement` (
  `numeroAbonnement` int(11) NOT NULL,
  `dateDebAbonnement` date DEFAULT NULL,
  `dateFinAbonnement` date DEFAULT NULL,
  `numeroProducteur` int(11) NOT NULL,
  `numeroTypeAbonnement` int(11) NOT NULL,
  PRIMARY KEY (`numeroAbonnement`),
  KEY `numeroProducteur` (`numeroProducteur`),
  KEY `numeroTypeAbonnement` (`numeroTypeAbonnement`),
  CONSTRAINT `Abonnement_ibfk_1` FOREIGN KEY (`numeroProducteur`) REFERENCES `Producteur` (`numeroProducteur`),
  CONSTRAINT `Abonnement_ibfk_2` FOREIGN KEY (`numeroTypeAbonnement`) REFERENCES `TypeAbonnement` (`numeroTypeAbonnement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Activite`
--

DROP TABLE IF EXISTS `Activite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Activite` (
  `numeroActivite` varchar(5) NOT NULL,
  `libelleActivite` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`numeroActivite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Client`
--

DROP TABLE IF EXISTS `Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Client` (
  `numeroClient` int(11) NOT NULL,
  `nomClient` varchar(25) DEFAULT NULL,
  `prenomClient` varchar(25) DEFAULT NULL,
  `mailClient` varchar(50) DEFAULT NULL,
  `telClient` varchar(14) DEFAULT NULL,
  `adresseClient` varchar(50) DEFAULT NULL,
  `villeClient` varchar(30) DEFAULT NULL,
  `codePostalClient` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`numeroClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Commande`
--

DROP TABLE IF EXISTS `Commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Commande` (
  `numeroCommande` int(11) NOT NULL,
  `prixCommande` float DEFAULT NULL,
  `dateRetraitCommande` date DEFAULT NULL,
  `numeroClient` int(11) NOT NULL,
  `numeroSemaine` int(11) NOT NULL,
  PRIMARY KEY (`numeroCommande`),
  KEY `numeroClient` (`numeroClient`),
  KEY `numeroSemaine` (`numeroSemaine`),
  CONSTRAINT `Commande_ibfk_1` FOREIGN KEY (`numeroClient`) REFERENCES `Client` (`numeroClient`),
  CONSTRAINT `Commande_ibfk_2` FOREIGN KEY (`numeroSemaine`) REFERENCES `Semaine` (`numeroSemaine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Contient`
--

DROP TABLE IF EXISTS `Contient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Contient` (
  `quantiteContient` float DEFAULT NULL,
  `numeroCommande` int(11) NOT NULL,
  `numeroProduitProducteur` int(11) NOT NULL,
  PRIMARY KEY (`numeroCommande`,`numeroProduitProducteur`),
  KEY `numeroProduitProducteur` (`numeroProduitProducteur`),
  CONSTRAINT `Contient_ibfk_1` FOREIGN KEY (`numeroCommande`) REFERENCES `Commande` (`numeroCommande`),
  CONSTRAINT `Contient_ibfk_2` FOREIGN KEY (`numeroProduitProducteur`) REFERENCES `ProduitProducteur` (`numeroProduitProducteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Employe`
--

DROP TABLE IF EXISTS `Employe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employe` (
  `numeroEmploye` int(11) NOT NULL,
  `loginEmploye` varchar(25) DEFAULT NULL,
  `nomEmploye` varchar(25) DEFAULT NULL,
  `prenomEmploye` varchar(25) DEFAULT NULL,
  `adresseEmploye` varchar(50) DEFAULT NULL,
  `codePostalEmploye` varchar(5) DEFAULT NULL,
  `villeEmploye` varchar(30) DEFAULT NULL,
  `mailEmploye` varchar(50) DEFAULT NULL,
  `telEmploye` varchar(17) DEFAULT NULL,
  `motDePasseEmploye` varchar(41) DEFAULT NULL,
  `numeroTypeEmploye` int(11) NOT NULL,
  `estActif` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`numeroEmploye`),
  KEY `numeroTypeEmploye` (`numeroTypeEmploye`),
  CONSTRAINT `Employe_ibfk_1` FOREIGN KEY (`numeroTypeEmploye`) REFERENCES `TypeEmploye` (`numeroTypeEmploye`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ImageProducteur`
--

DROP TABLE IF EXISTS `ImageProducteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ImageProducteur` (
  `numeroImageProducteur` int(11) NOT NULL,
  `cheminImageProducteur` varchar(75) DEFAULT NULL,
  `numeroProducteur` int(11) NOT NULL,
  `numeroVariete` int(11) NOT NULL,
  `numeroSemaine` int(11) NOT NULL,
  PRIMARY KEY (`numeroImageProducteur`),
  KEY `numeroProducteur` (`numeroProducteur`),
  KEY `numeroVariete` (`numeroVariete`),
  KEY `numeroSemaine` (`numeroSemaine`),
  CONSTRAINT `ImageProducteur_ibfk_1` FOREIGN KEY (`numeroProducteur`) REFERENCES `Producteur` (`numeroProducteur`),
  CONSTRAINT `ImageProducteur_ibfk_2` FOREIGN KEY (`numeroVariete`) REFERENCES `Variete` (`numeroVariete`),
  CONSTRAINT `ImageProducteur_ibfk_3` FOREIGN KEY (`numeroSemaine`) REFERENCES `Semaine` (`numeroSemaine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Possede`
--

DROP TABLE IF EXISTS `Possede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Possede` (
  `numeroClient` int(11) NOT NULL,
  `numeroProducteur` int(11) NOT NULL,
  PRIMARY KEY (`numeroClient`,`numeroProducteur`),
  KEY `numeroProducteur` (`numeroProducteur`),
  CONSTRAINT `Possede_ibfk_1` FOREIGN KEY (`numeroClient`) REFERENCES `Client` (`numeroClient`),
  CONSTRAINT `Possede_ibfk_2` FOREIGN KEY (`numeroProducteur`) REFERENCES `Producteur` (`numeroProducteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Producteur`
--

DROP TABLE IF EXISTS `Producteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Producteur` (
  `numeroProducteur` int(11) NOT NULL,
  `nomProducteur` varchar(30) DEFAULT NULL,
  `prenomProducteur` varchar(30) DEFAULT NULL,
  `adresseProducteur` varchar(50) DEFAULT NULL,
  `villeProducteur` varchar(30) DEFAULT NULL,
  `codePostalProducteur` varchar(5) DEFAULT NULL,
  `mailProducteur` varchar(50) DEFAULT NULL,
  `telProducteur` varchar(14) DEFAULT NULL,
  `mdpProducteur` varchar(30) DEFAULT NULL,
  `dateInscriptionProducteur` date DEFAULT NULL,
  `validationProducteur` tinyint(1) DEFAULT NULL,
  `raisonInvalidationProducteur` varchar(300) DEFAULT NULL,
  `activationProducteur` tinyint(1) NOT NULL DEFAULT 1,
  `numeroSirenProducteur` int(9) NOT NULL,
  `confirmationMailProducteur` tinyint(1) NOT NULL DEFAULT 0,
  `codeConfirmationMailProducteur` varchar(40) DEFAULT NULL,
  `latitudeProducteur` double(8,5) DEFAULT NULL,
  `longitudeProducteur` double(8,5) DEFAULT NULL,
  `numeroActivite` varchar(5) NOT NULL,
  PRIMARY KEY (`numeroProducteur`),
  KEY `FK_numeroActivite` (`numeroActivite`),
  CONSTRAINT `FK_numeroActivite` FOREIGN KEY (`numeroActivite`) REFERENCES `Activite` (`numeroActivite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Produit`
--

DROP TABLE IF EXISTS `Produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Produit` (
  `numeroProduit` int(11) NOT NULL,
  `libelleProduit` varchar(25) DEFAULT NULL,
  `imageProduit` varchar(75) DEFAULT NULL,
  `numeroRayon` int(11) NOT NULL,
  `dateInscriptionProduit` date DEFAULT NULL,
  PRIMARY KEY (`numeroProduit`),
  KEY `numeroRayon` (`numeroRayon`),
  CONSTRAINT `Produit_ibfk_1` FOREIGN KEY (`numeroRayon`) REFERENCES `Rayon` (`numeroRayon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProduitProducteur`
--

DROP TABLE IF EXISTS `ProduitProducteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProduitProducteur` (
  `numeroProduitProducteur` int(11) NOT NULL,
  `quantiteProduitProducteur` float DEFAULT NULL,
  `prixUnitaireProduitProducteur` float DEFAULT NULL,
  `dateAjoutProduitProducteur` date DEFAULT NULL,
  `numeroProducteur` int(11) NOT NULL,
  `numeroSemaine` int(11) NOT NULL,
  `numeroUnite` int(11) NOT NULL,
  `numeroVariete` int(11) NOT NULL,
  `numeroImageProducteur` int(11) DEFAULT NULL,
  PRIMARY KEY (`numeroProduitProducteur`),
  KEY `numeroProducteur` (`numeroProducteur`),
  KEY `numeroSemaine` (`numeroSemaine`),
  KEY `numeroUnite` (`numeroUnite`),
  KEY `numeroVariete` (`numeroVariete`),
  KEY `numeroImageProducteur` (`numeroImageProducteur`),
  CONSTRAINT `ProduitProducteur_ibfk_1` FOREIGN KEY (`numeroProducteur`) REFERENCES `Producteur` (`numeroProducteur`),
  CONSTRAINT `ProduitProducteur_ibfk_2` FOREIGN KEY (`numeroSemaine`) REFERENCES `Semaine` (`numeroSemaine`),
  CONSTRAINT `ProduitProducteur_ibfk_3` FOREIGN KEY (`numeroUnite`) REFERENCES `Unite` (`numeroUnite`),
  CONSTRAINT `ProduitProducteur_ibfk_4` FOREIGN KEY (`numeroVariete`) REFERENCES `Variete` (`numeroVariete`),
  CONSTRAINT `ProduitProducteur_ibfk_5` FOREIGN KEY (`numeroImageProducteur`) REFERENCES `ImageProducteur` (`numeroImageProducteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Profession`
--

DROP TABLE IF EXISTS `Profession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Profession` (
  `numeroProducteur` int(11) NOT NULL,
  `numeroTypeProducteur` int(11) NOT NULL,
  PRIMARY KEY (`numeroProducteur`,`numeroTypeProducteur`),
  KEY `numeroTypeProducteur` (`numeroTypeProducteur`),
  CONSTRAINT `Profession_ibfk_1` FOREIGN KEY (`numeroProducteur`) REFERENCES `Producteur` (`numeroProducteur`),
  CONSTRAINT `Profession_ibfk_2` FOREIGN KEY (`numeroTypeProducteur`) REFERENCES `TypeProducteur` (`numeroTypeProducteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Rayon`
--

DROP TABLE IF EXISTS `Rayon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rayon` (
  `numeroRayon` int(11) NOT NULL,
  `libelleRayon` varchar(25) DEFAULT NULL,
  `imageRayon` varchar(75) DEFAULT NULL,
  `dateInscriptionRayon` date DEFAULT NULL,
  PRIMARY KEY (`numeroRayon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Semaine`
--

DROP TABLE IF EXISTS `Semaine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Semaine` (
  `numeroSemaine` int(11) NOT NULL,
  `dateDebSemaine` date DEFAULT NULL,
  `dateFinSemaine` date DEFAULT NULL,
  PRIMARY KEY (`numeroSemaine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Ticket`
--

DROP TABLE IF EXISTS `Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ticket` (
  `numeroTicket` int(11) NOT NULL,
  `cleTicket` varchar(75) DEFAULT NULL,
  `numeroSemaine` int(11) NOT NULL,
  `numeroProducteur` int(11) NOT NULL,
  `numeroClient` int(11) NOT NULL,
  PRIMARY KEY (`numeroTicket`),
  KEY `numeroSemaine` (`numeroSemaine`),
  KEY `numeroProducteur` (`numeroProducteur`),
  KEY `numeroClient` (`numeroClient`),
  CONSTRAINT `Ticket_ibfk_1` FOREIGN KEY (`numeroSemaine`) REFERENCES `Semaine` (`numeroSemaine`),
  CONSTRAINT `Ticket_ibfk_2` FOREIGN KEY (`numeroProducteur`) REFERENCES `Producteur` (`numeroProducteur`),
  CONSTRAINT `Ticket_ibfk_3` FOREIGN KEY (`numeroClient`) REFERENCES `Client` (`numeroClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TypeAbonnement`
--

DROP TABLE IF EXISTS `TypeAbonnement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TypeAbonnement` (
  `numeroTypeAbonnement` int(11) NOT NULL,
  `libelleTypeAbonnement` varchar(25) DEFAULT NULL,
  `prixTypeAbonnement` float DEFAULT NULL,
  `dureeMoisAbonnement` int(11) DEFAULT NULL,
  PRIMARY KEY (`numeroTypeAbonnement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TypeEmploye`
--

DROP TABLE IF EXISTS `TypeEmploye`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TypeEmploye` (
  `numeroTypeEmploye` int(11) NOT NULL,
  `libelleTypeEmploye` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`numeroTypeEmploye`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TypeProducteur`
--

DROP TABLE IF EXISTS `TypeProducteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TypeProducteur` (
  `numeroTypeProducteur` int(11) NOT NULL,
  `libelleTypeProducteur` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`numeroTypeProducteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Unite`
--

DROP TABLE IF EXISTS `Unite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Unite` (
  `numeroUnite` int(11) NOT NULL,
  `libelleUnite` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`numeroUnite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Variete`
--

DROP TABLE IF EXISTS `Variete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Variete` (
  `numeroVariete` int(11) NOT NULL,
  `libelleVariete` varchar(25) DEFAULT NULL,
  `imageVariete` varchar(75) DEFAULT NULL,
  `numeroProduit` int(11) NOT NULL,
  `dateInscriptionVariete` date DEFAULT NULL,
  `estValide` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`numeroVariete`),
  KEY `numeroProduit` (`numeroProduit`),
  CONSTRAINT `Variete_ibfk_1` FOREIGN KEY (`numeroProduit`) REFERENCES `Produit` (`numeroProduit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-07 14:08:32
