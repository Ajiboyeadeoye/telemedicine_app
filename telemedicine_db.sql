-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_db
-- ------------------------------------------------------
-- Server version	8.0.39

-- CREATE database telemedicine_db;
-- USE telemedicine_db;

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

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(50) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `gender` varchar(30) NOT NULL,
  `address` varchar(30) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=946 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'Ajiboye','Sue','ajiboyeadeoye25@yahoo.com','$argon2id$v=19$m=65536,t=2,p=1$Gxk8jd+fVUNLOwHfONxT5A$4VPzzUl7R1+y9S1fi8AfUeWEH8WX5E8UTuCh/RjH50Y
','+2348166805269','1960-01-01','Male','University of Ibadan'),(2,'Bode','Thomas','adewalethomas75@yahoo.com','$argon2id$v=19$m=65536,t=2,p=1$Gxk8jd+fVUNLOwHfONxT5A$4VPzzUl7R1+y9S1fi8AfUeWEH8WX5E8UTuCh/RjH50Y
','+234817777777','1990-01-01','Female','No 9, Taiwo road Ikorodu');
/*!40101 SET character_set_client = @saved_cs_client */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
   `last_name` varchar(50) NOT NULL,
   `specialization` varchar(80) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `schedule` varchar(50) NOT NULL,
PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=946 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Sally','Sue','Pediatrics','sallysue@healthcare.org','5551211001','2023-02-07, 7:00am'),
(2,'Mike','Myers','Pediatrics','mikemyers@healthcare.org','5551211002','1993-05-02, 3:30pm'),
(3,'Jordan','Michael','Pediatrics','jordanmichael@healthcare.org','5551211003','1993-06-24, 8:00am'),
(4,'Ted','Texas','Pediatrics','tedtexas@healthcare.org','5551211004','1993-12-23, 9:00am'),
(5,'Ala','Bama','Pediatrics','alabama@healthcare.org','5551211005','1995-01-10, 6:30am');
/*!40101 SET character_set_client = @saved_cs_client */;
UNLOCK TABLES;


--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_date` datetime NOT NULL,
  `appointment_time` time NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id_idx` (`patient_id`),
  KEY `doctor_id_idx` (`doctor_id`),
  CONSTRAINT `pat_id` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `doc_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=721 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1, 1, 1, '2024-02-04', '9:00am', 'scheduled'), (2, 2, 3, '2024-02-04', '8:00am', 'canceled'),
(3, 3, 4, '2024-02-04', '7:00am', 'completed');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(155) NOT NULL,
  `role` varchar(50),
  PRIMARY KEY (`admin_id`)
  ) ENGINE=InnoDB AUTO_INCREMENT=721 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `admin` VALUES (1, 'superadmin_user', '$2b$12$e/2XIHsJCVhXltpZzFHdHePvRloTNUh7rv/rn7.vZL9F9I0EljWl2', 'superadmin'),
(2, 'admin_user', '$2b$12$XgUFCu.m7Yq5FwN8Qz8XGe3ZPFL63uyL7DmDxs9FMyDFkR7q23n1G', 'admin'),
(3, 'mod_user', '$2b$12$Kt1FkQsOp5V7YPULcuREkOvPmbACtsWfw7nFxxBZgeIvVO7eA/qIK', 'moderator');
/*!40101 SET character_set_client = @saved_cs_client */;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-15 18:13:46
