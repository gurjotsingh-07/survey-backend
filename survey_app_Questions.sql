-- MySQL dump 10.13  Distrib 8.0.40, for macos14 (x86_64)
--
-- Host: localhost    Database: survey_app
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `survey_id` int NOT NULL,
  `text` text NOT NULL,
  `type` enum('TEXT','CHECKBOX','RADIO','DROPDOWN') NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `Surveys` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Questions`
--

LOCK TABLES `Questions` WRITE;
/*!40000 ALTER TABLE `Questions` DISABLE KEYS */;
INSERT INTO `Questions` VALUES (1,5,'How satisfied are you with our product?','TEXT',1,'2024-12-31 21:41:49','2024-12-31 21:41:49'),(2,5,'What features would you like to see in future updates?','TEXT',0,'2024-12-31 21:41:49','2024-12-31 21:41:49'),(3,5,'Would you recommend our product to others?','RADIO',1,'2024-12-31 21:41:49','2024-12-31 21:41:49'),(4,6,'string','TEXT',1,'2024-12-31 22:05:07','2024-12-31 22:05:07'),(6,8,'How satisfied are you with our product?','RADIO',1,'2025-01-01 00:37:27','2025-01-01 00:37:27'),(7,9,'How satisfied are you with our product?','RADIO',1,'2025-01-01 00:48:56','2025-01-01 00:48:56'),(8,10,'How satisfied are you with our product?','RADIO',1,'2025-01-01 00:49:26','2025-01-01 00:49:26'),(9,11,'How satisfied are you with our product?','RADIO',1,'2025-01-01 00:50:39','2025-01-01 00:50:39'),(10,12,'How satisfied are you with our product?','RADIO',1,'2025-01-01 00:51:15','2025-01-01 00:51:15'),(11,13,'How satisfied are you with our product?','RADIO',1,'2025-01-01 00:51:33','2025-01-01 00:51:33'),(12,14,'How satisfied are you with our product?','RADIO',1,'2025-01-01 00:51:53','2025-01-01 00:51:53'),(13,15,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:00:00','2025-01-01 01:00:00'),(14,16,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:04:48','2025-01-01 01:04:48'),(15,17,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:45:27','2025-01-01 01:45:27'),(16,18,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:46:05','2025-01-01 01:46:05'),(17,21,'string','TEXT',1,'2025-01-01 01:50:30','2025-01-01 01:50:30'),(18,22,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:51:24','2025-01-01 01:51:24'),(19,22,'What features would you like to see in future updates?','TEXT',0,'2025-01-01 01:51:24','2025-01-01 01:51:24'),(20,23,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:52:05','2025-01-01 01:52:05'),(21,23,'What features would you like to see in future updates?','TEXT',0,'2025-01-01 01:52:05','2025-01-01 01:52:05'),(22,24,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:56:28','2025-01-01 01:56:28'),(23,24,'What features would you like to see in future updates?','TEXT',0,'2025-01-01 01:56:28','2025-01-01 01:56:28'),(24,25,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:56:54','2025-01-01 01:56:54'),(25,25,'What features would you like to see in future updates?','TEXT',0,'2025-01-01 01:56:54','2025-01-01 01:56:54'),(26,26,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:57:42','2025-01-01 01:57:42'),(27,26,'What features would you like to see in future updates?','TEXT',0,'2025-01-01 01:57:42','2025-01-01 01:57:42'),(28,27,'How satisfied are you with our product?','RADIO',1,'2025-01-01 01:58:24','2025-01-01 01:58:24'),(29,27,'What features would you like to see in future updates?','TEXT',0,'2025-01-01 01:58:24','2025-01-01 01:58:24'),(30,28,'How satisfied are you with our product?','RADIO',1,'2025-01-01 02:01:43','2025-01-01 02:01:43'),(31,28,'What features would you like to see in future updates?','TEXT',0,'2025-01-01 02:01:43','2025-01-01 02:01:43'),(32,31,'string','TEXT',1,'2025-01-08 06:18:24','2025-01-08 06:18:24'),(33,32,'string','TEXT',1,'2025-01-08 06:18:38','2025-01-08 06:18:38'),(34,33,'How satisfied are you with our product?','RADIO',1,'2025-01-08 08:35:42','2025-01-08 08:35:42'),(35,33,'What features would you like to see in future updates?','TEXT',0,'2025-01-08 08:35:42','2025-01-08 08:35:42'),(36,34,'How satisfied are you with our product?','RADIO',1,'2025-01-08 08:35:45','2025-01-08 08:35:45'),(37,34,'What features would you like to see in future updates?','TEXT',0,'2025-01-08 08:35:45','2025-01-08 08:35:45'),(38,35,'How satisfied are you with our product?','RADIO',1,'2025-01-08 08:36:27','2025-01-08 08:36:27'),(39,35,'What features would you like to see in future updates?','TEXT',0,'2025-01-08 08:36:27','2025-01-08 08:36:27'),(40,36,'How satisfied are you with our product?','TEXT',1,'2025-01-08 10:41:30','2025-01-08 10:41:30'),(41,36,'What features would you like to see in future updates?','TEXT',0,'2025-01-08 10:41:30','2025-01-08 10:41:30'),(42,36,'Would you recommend our product to others?','RADIO',1,'2025-01-08 10:41:30','2025-01-08 10:41:30');
/*!40000 ALTER TABLE `Questions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-09 11:07:10
