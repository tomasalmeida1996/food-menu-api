-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: foodmenu
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `menu_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Pizza','Best Pizza, authentic Italian style, fresh ingredients','2022-07-05 18:33:50','2022-07-06 22:43:57',1,1),(2,'Pasta','Delicious pasta','2022-07-05 18:33:50','2022-07-06 22:43:57',1,1),(4,'Another Salads','Another Worlds best salads','2022-07-06 23:23:08','2022-07-06 23:53:24',0,1),(15,'Salads','More Worlds best salads','2022-07-07 00:28:37','2022-07-07 00:28:37',1,1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoriesotheroptionsgroups`
--

DROP TABLE IF EXISTS `categoriesotheroptionsgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoriesotheroptionsgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `otheroptiongroup_id` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_categoryid_idx` (`category_id`),
  KEY `FK_otheroptionsgroupid_idx` (`otheroptiongroup_id`),
  CONSTRAINT `FK_categoriesid` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `FK_otheroptionsgroups` FOREIGN KEY (`otheroptiongroup_id`) REFERENCES `otheroptionsgroups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoriesotheroptionsgroups`
--

LOCK TABLES `categoriesotheroptionsgroups` WRITE;
/*!40000 ALTER TABLE `categoriesotheroptionsgroups` DISABLE KEYS */;
INSERT INTO `categoriesotheroptionsgroups` VALUES (1,1,3,'2022-07-05 22:04:11','2022-07-05 22:04:11'),(2,1,4,'2022-07-06 17:59:28','2022-07-06 17:59:28');
/*!40000 ALTER TABLE `categoriesotheroptionsgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `currency` varchar(10) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'Summer menu','Menu for summer time','USD','2022-07-05 16:54:08','2022-07-05 16:54:08',1),(2,'Winter menu','Menu for winter time','USD','2022-07-05 18:23:34','2022-07-05 18:24:26',0);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otheroptionsgroups`
--

DROP TABLE IF EXISTS `otheroptionsgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otheroptionsgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otheroptionsgroups`
--

LOCK TABLES `otheroptionsgroups` WRITE;
/*!40000 ALTER TABLE `otheroptionsgroups` DISABLE KEYS */;
INSERT INTO `otheroptionsgroups` VALUES (1,'Toppings 1st half',0,'2022-07-05 20:12:31','2022-07-05 20:12:31',1),(2,'Toppings 2nd half',0,'2022-07-05 20:12:31','2022-07-05 20:12:31',1),(3,'Crust',1,'2022-07-05 20:12:31','2022-07-05 20:12:31',1),(4,'Extra toppings',0,'2022-07-05 20:12:31','2022-07-05 20:12:31',1);
/*!40000 ALTER TABLE `otheroptionsgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otheroptionsgroupsitems`
--

DROP TABLE IF EXISTS `otheroptionsgroupsitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otheroptionsgroupsitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `otheroptiongroup_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` decimal(18,2) NOT NULL,
  `associated_productitem_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_otheroption_productitemid_idx` (`associated_productitem_id`),
  CONSTRAINT `FK_otheroptiongroupitem_productitemid` FOREIGN KEY (`associated_productitem_id`) REFERENCES `productitems` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otheroptionsgroupsitems`
--

LOCK TABLES `otheroptionsgroupsitems` WRITE;
/*!40000 ALTER TABLE `otheroptionsgroupsitems` DISABLE KEYS */;
INSERT INTO `otheroptionsgroupsitems` VALUES (1,3,'Thick',0.00,NULL),(2,3,'Crispy',0.00,NULL),(3,1,'Ham',1.20,NULL),(4,1,'Mushrooms',1.20,NULL),(5,1,'Salami',1.20,NULL),(6,1,'Onion rings',0.70,NULL),(7,2,'Olives',1.20,NULL),(8,2,'Ham',1.20,NULL),(9,2,'Salami',1.20,NULL),(10,2,'Corn',1.20,NULL),(11,4,'Corn',1.20,NULL),(12,4,'Extra mozzarella',1.00,NULL),(13,4,'Extra ham',1.20,NULL);
/*!40000 ALTER TABLE `otheroptionsgroupsitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productitems`
--

DROP TABLE IF EXISTS `productitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `price` decimal(18,2) NOT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_product_Categoryid_idx` (`category_id`),
  CONSTRAINT `FK_product_categoryid` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productitems`
--

LOCK TABLES `productitems` WRITE;
/*!40000 ALTER TABLE `productitems` DISABLE KEYS */;
INSERT INTO `productitems` VALUES (1,'Pizza Margherita','Tomato sauce, oregano, garlic and fresh basil','2022-07-05 18:52:56','2022-07-05 18:52:56',1,8.00,1),(2,'Pizza Prosciutto','Splitted half / half. For each half you can choose your own toppings','2022-07-05 18:52:56','2022-07-05 18:52:56',1,10.00,1),(3,'Traditional Lasagna','Home made pasta, ground beef, tomato sauce, bechamel sauce and parmesan','2022-07-05 18:52:56','2022-07-05 18:52:56',1,11.00,2),(4,'Spaghetti Pomodoro','Spaghetti, tomatoes, mushrooms, garlic, basil','2022-07-05 18:52:56','2022-07-05 18:52:56',1,9.00,2),(5,'Spaghetti carbonara','Spaghetti, bacon, egg, garlic, parsley','2022-07-05 18:52:56','2022-07-05 18:52:56',1,15.00,2),(7,'rice','A lot of rice','2022-07-07 00:04:15','2022-07-07 00:04:15',1,1.20,4),(8,'Rice Bowl','One rice bowl','2022-07-07 00:22:37','2022-07-07 00:22:37',1,8.00,4),(11,'cesar salad','cesar salad','2022-07-07 00:40:51','2022-07-07 00:42:02',1,3.99,15);
/*!40000 ALTER TABLE `productitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productsitemsotheroptionsgroups`
--

DROP TABLE IF EXISTS `productsitemsotheroptionsgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsitemsotheroptionsgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productitem_id` int NOT NULL,
  `otheroptiongroup_id` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_productotheroptionsgroups_otheroptionsgroups_idx` (`otheroptiongroup_id`),
  KEY `FK_productotheroptionsgroups_productitems_idx` (`productitem_id`),
  CONSTRAINT `FK_productotheroptionsgroups_otheroptionsgroups` FOREIGN KEY (`otheroptiongroup_id`) REFERENCES `otheroptionsgroups` (`id`),
  CONSTRAINT `FK_productotheroptionsgroups_productitems` FOREIGN KEY (`productitem_id`) REFERENCES `productitems` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productsitemsotheroptionsgroups`
--

LOCK TABLES `productsitemsotheroptionsgroups` WRITE;
/*!40000 ALTER TABLE `productsitemsotheroptionsgroups` DISABLE KEYS */;
INSERT INTO `productsitemsotheroptionsgroups` VALUES (1,2,1,'2022-07-06 17:57:48','2022-07-06 17:57:48'),(2,2,2,'2022-07-06 17:57:48','2022-07-06 18:04:08');
/*!40000 ALTER TABLE `productsitemsotheroptionsgroups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-07  1:17:43
