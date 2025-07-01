CREATE DATABASE  IF NOT EXISTS `simpsonsentence` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `simpsonsentence`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: simpsonsentence
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `capitulos`
--

DROP TABLE IF EXISTS `capitulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capitulos` (
  `id_capitulos` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `episodio` int DEFAULT NULL,
  `temporada` int DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `sinopsis` varchar(999) DEFAULT NULL,
  `frases_id` int NOT NULL,
  PRIMARY KEY (`id_capitulos`),
  KEY `fk_capitulos_frases1_idx` (`frases_id`),
  CONSTRAINT `fk_capitulos_frases1` FOREIGN KEY (`frases_id`) REFERENCES `frases` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capitulos`
--

LOCK TABLES `capitulos` WRITE;
/*!40000 ALTER TABLE `capitulos` DISABLE KEYS */;
INSERT INTO `capitulos` VALUES (1,'inventado',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `capitulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frases`
--

DROP TABLE IF EXISTS `frases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `texto` varchar(250) NOT NULL,
  `marca_tiempo` datetime DEFAULT NULL,
  `descripcion` varchar(999) DEFAULT NULL,
  `fk_id_personajes` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_frases_personajes1_idx1` (`fk_id_personajes`),
  CONSTRAINT `fk_frases_personajes1` FOREIGN KEY (`fk_id_personajes`) REFERENCES `personajes` (`id_personajes`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frases`
--

LOCK TABLES `frases` WRITE;
/*!40000 ALTER TABLE `frases` DISABLE KEYS */;
INSERT INTO `frases` VALUES (1,'D\'oh!','2000-10-22 00:00:00','Queja de Homer',1),(2,'Excelente',NULL,'Tiene que ir acompañada con un gesto de manos',5),(3,'¡Ay, caramba!',NULL,'Grito sorpresa celebre de Bart',4),(10,'No conquistas nada con una ensada',NULL,'Estupenda frase',2),(11,'Multiplicate por cero',NULL,'Insulto de Bart',4),(12,'No conquistas nada con una ensalada',NULL,'Respuesta a la insistencia de Bart',3),(13,'¡Sí, voy a trabajar, liando porros!',NULL,'frase de un desconocido de la calle',6),(14,'¡Sí, voy a trabajar, liando porros!',NULL,'frase de un desconocido de la calle',6);
/*!40000 ALTER TABLE `frases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personajes`
--

DROP TABLE IF EXISTS `personajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personajes` (
  `id_personajes` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `ocupacion` varchar(45) DEFAULT NULL,
  `descripcion` varchar(999) DEFAULT NULL,
  PRIMARY KEY (`id_personajes`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personajes`
--

LOCK TABLES `personajes` WRITE;
/*!40000 ALTER TABLE `personajes` DISABLE KEYS */;
INSERT INTO `personajes` VALUES (1,'Homer','Simpson','Funcionario','Padre'),(2,'Marge','Simpson','Ama de casa','Madre'),(3,'Lisa','Simpson','Estudiante','Hija'),(4,'Bart','Simpson','Estudiante','Hijo'),(5,'Montgomery','Burns','Jefe','Jefe'),(6,'Desconocido',NULL,NULL,'Aleatorio');
/*!40000 ALTER TABLE `personajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personajes_has_capitulos`
--

DROP TABLE IF EXISTS `personajes_has_capitulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personajes_has_capitulos` (
  `fk_id_personajes` int NOT NULL,
  `fk_id_capitulos` int NOT NULL,
  PRIMARY KEY (`fk_id_personajes`,`fk_id_capitulos`),
  KEY `fk_personajes_has_capitulos_capitulos1_idx` (`fk_id_capitulos`),
  KEY `fk_personajes_has_capitulos_personajes1_idx` (`fk_id_personajes`),
  CONSTRAINT `fk_personajes_has_capitulos_capitulos1` FOREIGN KEY (`fk_id_capitulos`) REFERENCES `capitulos` (`id_capitulos`),
  CONSTRAINT `fk_personajes_has_capitulos_personajes1` FOREIGN KEY (`fk_id_personajes`) REFERENCES `personajes` (`id_personajes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personajes_has_capitulos`
--

LOCK TABLES `personajes_has_capitulos` WRITE;
/*!40000 ALTER TABLE `personajes_has_capitulos` DISABLE KEYS */;
/*!40000 ALTER TABLE `personajes_has_capitulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'simpsonsentence'
--

--
-- Dumping routines for database 'simpsonsentence'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01 14:26:12
