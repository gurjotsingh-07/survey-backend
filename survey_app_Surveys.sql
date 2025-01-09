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
-- Table structure for table `Surveys`
--

DROP TABLE IF EXISTS `Surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Surveys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `status` enum('DRAFT','ACTIVE','CLOSED') DEFAULT 'DRAFT',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total_responses` int DEFAULT '0',
  `total_people_sent` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `surveys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Surveys`
--

LOCK TABLES `Surveys` WRITE;
/*!40000 ALTER TABLE `Surveys` DISABLE KEYS */;
INSERT INTO `Surveys` VALUES (5,1,'Customer Satisfaction Survey','A survey to gather feedback on customer satisfaction.','ACTIVE','2025-01-02 22:31:14','2025-02-02 22:31:14','2024-12-31 21:41:49','2025-01-03 03:32:31',1,0),(6,1,'string','string','DRAFT','2024-12-31 17:04:57','2024-12-31 17:04:57','2024-12-31 22:05:07','2024-12-31 22:05:07',0,0),(8,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 00:37:27','2025-01-01 00:37:27',0,0),(9,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 00:48:56','2025-01-01 00:48:56',0,0),(10,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 00:49:26','2025-01-01 00:49:26',0,0),(11,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 00:50:39','2025-01-01 00:50:39',0,0),(12,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 00:51:15','2025-01-01 00:51:15',0,0),(13,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 00:51:33','2025-01-01 00:51:33',0,0),(14,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 00:51:53','2025-01-01 00:51:53',0,0),(15,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 01:00:00','2025-01-01 01:00:00',0,0),(16,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 01:04:48','2025-01-01 01:04:48',0,0),(17,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 01:45:27','2025-01-01 01:45:27',0,0),(18,1,'new survey','just checking','DRAFT','2024-12-31 19:33:24','2024-12-31 19:33:24','2025-01-01 01:46:05','2025-01-01 01:46:05',0,0),(21,1,'string','string','DRAFT','2024-12-31 20:46:14','2024-12-31 20:46:14','2025-01-01 01:50:30','2025-01-01 01:50:30',0,0),(22,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-01 01:51:24','2025-01-01 01:51:24',0,0),(23,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-01 01:52:05','2025-01-01 01:52:05',0,0),(24,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-01 01:56:28','2025-01-01 01:56:28',0,0),(25,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-01 01:56:54','2025-01-01 01:56:54',0,0),(26,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-01 01:57:42','2025-01-01 01:57:42',0,0),(27,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-01 01:58:24','2025-01-01 01:58:24',0,0),(28,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-01 02:01:43','2025-01-01 02:01:43',0,0),(31,1,'string','string','DRAFT','2025-01-08 01:08:47','2025-01-08 01:08:47','2025-01-08 06:18:24','2025-01-08 06:18:24',0,0),(32,1,'string','string','DRAFT','2025-01-08 01:18:33','2025-01-08 01:18:33','2025-01-08 06:18:38','2025-01-08 06:18:38',0,0),(33,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-08 08:35:42','2025-01-08 08:35:42',0,0),(34,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-08 08:35:45','2025-01-08 08:35:45',0,0),(35,1,'Customer Satisfaction Survey','We value your feedback','DRAFT','2024-12-31 12:00:00','2024-12-31 13:00:00','2025-01-08 08:36:27','2025-01-08 08:36:27',0,0),(36,1,'Customer Satisfaction Survey newww','A survey to gather feedback on customer satisfaction.','ACTIVE','2025-01-02 22:31:14','2025-02-02 22:31:14','2025-01-08 10:41:30','2025-01-08 10:41:30',0,0);
/*!40000 ALTER TABLE `Surveys` ENABLE KEYS */;
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
