-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: saah_medilearn
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_cible` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enregistrement_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_adresse` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` json DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,9,'LOGIN','users','9','192.168.1.10','Mozilla/5.0 Windows Chrome/120.0','{\"methode\": \"email\", \"resultat\": \"succes\"}','2026-04-19 09:32:15'),(2,9,'PAIEMENT','paiements','1','192.168.1.10','Mozilla/5.0 Windows Chrome/120.0','{\"statut\": \"valide\", \"methode\": \"carte\", \"montant\": 149.0}','2026-04-19 09:32:15'),(3,9,'ACCES_MEDIA','media','1','192.168.1.10','Mozilla/5.0 Windows Chrome/120.0','{\"type\": \"video\", \"module_id\": 1, \"duree_visionnage\": 3600}','2026-04-19 09:32:15'),(4,9,'CERTIFICAT_EMIS','certificats','1','192.168.1.10','Mozilla/5.0 Windows Chrome/120.0','{\"numero\": \"CERT-2026-0001-SAAH-MEDILEARN\", \"formation_id\": 2}','2026-04-19 09:32:15'),(5,10,'LOGIN','users','10','192.168.1.11','Mozilla/5.0 Windows Firefox/121.0','{\"methode\": \"email\", \"resultat\": \"succes\"}','2026-04-19 09:32:15');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Cardiologie','Formations en maladies cardiovasculaires','cardiologie','2026-04-19 08:47:50','2026-04-19 08:47:50'),(2,'Urgences médicales','Gestes et protocoles d urgence','urgences-medicales','2026-04-19 08:47:50','2026-04-19 08:47:50'),(3,'Pharmacologie','Médicaments interactions et dosages','pharmacologie','2026-04-19 08:47:50','2026-04-19 08:47:50'),(4,'Chirurgie','Techniques chirurgicales et bloc opératoire','chirurgie','2026-04-19 08:47:50','2026-04-19 08:47:50'),(5,'Pédiatrie','Soins et pathologies de l enfant','pediatrie','2026-04-19 08:47:50','2026-04-19 08:47:50');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificats`
--

DROP TABLE IF EXISTS `certificats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `formation_id` int unsigned NOT NULL,
  `hash_signature` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_certificat` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_emission` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_expiration` timestamp NULL DEFAULT NULL,
  `est_valide` tinyint(1) DEFAULT '1',
  `url_pdf_s3` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoque_le` datetime DEFAULT NULL,
  `raison_revocation` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_certificat` (`numero_certificat`),
  KEY `fk_user_id_certificats` (`user_id`),
  KEY `fk_formation_id_certificats` (`formation_id`),
  CONSTRAINT `fk_formation_id_certificats` FOREIGN KEY (`formation_id`) REFERENCES `formations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_certificats` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificats`
--

LOCK TABLES `certificats` WRITE;
/*!40000 ALTER TABLE `certificats` DISABLE KEYS */;
INSERT INTO `certificats` VALUES (1,9,2,'sha256_rsa_WINNIE_FORMATION2_a3f8c2d1e4b7a9f0c3d6e8b2a5f1c4d7e0b3a6f2c5d8e1b4a7f0c3d6e9b2a5f8','CERT-2026-0001-SAAH-MEDILEARN','2026-04-19 09:25:21',NULL,1,'s3://saah-medilearn/certificats/CERT-2026-0001.pdf',NULL,NULL);
/*!40000 ALTER TABLE `certificats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formations`
--

DROP TABLE IF EXISTS `formations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `prix` decimal(8,2) NOT NULL DEFAULT '0.00',
  `duree_heure` decimal(5,1) NOT NULL DEFAULT '0.0',
  `niveau` enum('debutant','intermediaire','avance','expert') COLLATE utf8mb4_unicode_ci NOT NULL,
  `formateur_id` int unsigned NOT NULL,
  `categorie_id` int unsigned NOT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `thumbnail_url` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_formation_formateur` (`formateur_id`),
  KEY `fk_formation_categorie` (`categorie_id`),
  CONSTRAINT `fk_formation_categorie` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_formation_formateur` FOREIGN KEY (`formateur_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formations`
--

LOCK TABLES `formations` WRITE;
/*!40000 ALTER TABLE `formations` DISABLE KEYS */;
INSERT INTO `formations` VALUES (1,'Insuffisance cardiaque ? diagnostic et prise en charge','Formation certifiante de niveau avancé sur l insuffisance cardiaque chronique et aigue.',149.00,8.0,'avance',7,1,1,NULL,'2026-04-19 07:04:17','2026-04-19 07:04:17'),(2,'Gestes d urgence vitaux ? RCP et défibrillation','Protocoles BLS et ALS, utilisation du défibrillateur automatique.',89.00,4.0,'intermediaire',8,2,1,NULL,'2026-04-19 07:04:17','2026-04-19 07:04:17'),(3,'Interactions médicamenteuses courantes','Identifier et prévenir les interactions dangereuses en pratique clinique.',69.00,3.0,'debutant',7,3,1,NULL,'2026-04-19 07:04:17','2026-04-19 07:04:17');
/*!40000 ALTER TABLE `formations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscriptions`
--

DROP TABLE IF EXISTS `inscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscriptions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `formation_id` int unsigned NOT NULL,
  `statut` enum('en_cours','complete','abandonne','expire') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_cours',
  `progression` tinyint NOT NULL DEFAULT '0',
  `date_inscription` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_completion` datetime DEFAULT NULL,
  `date_expiration` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_formation` (`user_id`,`formation_id`),
  KEY `fk_formations_inscriptions` (`formation_id`),
  CONSTRAINT `fk_formations_inscriptions` FOREIGN KEY (`formation_id`) REFERENCES `formations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_inscriptions` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscriptions`
--

LOCK TABLES `inscriptions` WRITE;
/*!40000 ALTER TABLE `inscriptions` DISABLE KEYS */;
INSERT INTO `inscriptions` VALUES (1,9,1,'en_cours',45,'2026-04-19 09:15:45',NULL,NULL),(2,9,2,'complete',100,'2026-04-19 09:15:45',NULL,NULL),(3,10,3,'en_cours',20,'2026-04-19 09:15:45',NULL,NULL);
/*!40000 ALTER TABLE `inscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int unsigned NOT NULL,
  `type` enum('video','pdf','quiz','audio') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pdf',
  `titre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url_s3` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taille_mb` decimal(6,1) DEFAULT NULL,
  `duree_secondes` int DEFAULT NULL,
  `ordre` smallint NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_media_modules` (`module_id`),
  CONSTRAINT `fk_media_modules` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,'video','Introduction vidéo','s3://saah-medilearn/formations/1/modules/1/intro.mp4',NULL,NULL,1,'2026-04-19 07:11:41'),(2,1,'pdf','Support de cours','s3://saah-medilearn/formations/1/modules/1/support.pdf',NULL,NULL,2,'2026-04-19 07:11:41'),(3,2,'video','Diagnostic en pratique','s3://saah-medilearn/formations/1/modules/2/diagnostic.mp4',NULL,NULL,1,'2026-04-19 07:11:41'),(4,3,'video','Gestes RCP','s3://saah-medilearn/formations/2/modules/3/rcp.mp4',NULL,NULL,1,'2026-04-19 07:11:41'),(5,4,'video','Démo défibrillateur','s3://saah-medilearn/formations/2/modules/4/defib.mp4',NULL,NULL,1,'2026-04-19 07:11:41'),(6,4,'pdf','Fiche technique','s3://saah-medilearn/formations/2/modules/4/fiche.pdf',NULL,NULL,2,'2026-04-19 07:11:41'),(7,5,'pdf','Guide interactions','s3://saah-medilearn/formations/3/modules/5/guide.pdf',NULL,NULL,1,'2026-04-19 07:11:41'),(8,6,'video','Cas cliniques vidéo','s3://saah-medilearn/formations/3/modules/6/cas.mp4',NULL,NULL,1,'2026-04-19 07:11:41');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `formation_id` int unsigned NOT NULL,
  `titre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ordre` smallint NOT NULL DEFAULT '0',
  `duree_minutes` smallint NOT NULL DEFAULT '0',
  `is_gratuit` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_modules_formations` (`formation_id`),
  CONSTRAINT `fk_modules_formations` FOREIGN KEY (`formation_id`) REFERENCES `formations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,1,'Introduction et physiopathologie',NULL,1,60,1,'2026-04-19 07:08:15'),(2,1,'Diagnostic et traitement',NULL,2,90,0,'2026-04-19 07:08:15'),(3,2,'Bases de la réanimation cardiopulmonaire',NULL,1,45,1,'2026-04-19 07:08:15'),(4,2,'Utilisation du défibrillateur',NULL,2,60,0,'2026-04-19 07:08:15'),(5,3,'Mécanismes des interactions',NULL,1,40,1,'2026-04-19 07:08:15'),(6,3,'Cas cliniques pratiques',NULL,2,50,0,'2026-04-19 07:08:15');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paiements`
--

DROP TABLE IF EXISTS `paiements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paiements` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `formation_id` int unsigned NOT NULL,
  `montant` decimal(8,2) NOT NULL,
  `devise` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EUR',
  `statut` enum('en_attente','valide','echoue','rembourse') COLLATE utf8mb4_unicode_ci DEFAULT 'en_attente',
  `transaction_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `methode` enum('carte','virement','paypal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_paiement` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_user_id_paiements` (`user_id`),
  KEY `fk_formations_paiements` (`formation_id`),
  CONSTRAINT `fk_formations_paiements` FOREIGN KEY (`formation_id`) REFERENCES `formations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_paiements` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paiements`
--

LOCK TABLES `paiements` WRITE;
/*!40000 ALTER TABLE `paiements` DISABLE KEYS */;
INSERT INTO `paiements` VALUES (1,9,1,149.00,'EUR','valide','tok_visa_4242_WINNIE_F1','carte','192.168.1.10','2026-04-19 07:23:06','2026-04-19 07:23:06'),(2,9,2,89.00,'EUR','valide','tok_visa_4242_WINNIE_F2','carte','192.168.1.10','2026-04-19 07:23:06','2026-04-19 07:23:06'),(3,10,3,69.00,'EUR','valide','tok_paypal_MAKOU_F3','paypal','192.168.1.11','2026-04-19 07:23:06','2026-04-19 07:23:06');
/*!40000 ALTER TABLE `paiements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progression_modules`
--

DROP TABLE IF EXISTS `progression_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progression_modules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `module_id` int unsigned NOT NULL,
  `complete` tinyint(1) NOT NULL DEFAULT '0',
  `temps_passe` int NOT NULL DEFAULT '0',
  `derniere_vue` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_module` (`user_id`,`module_id`),
  KEY `fk_module_id_progression_modules` (`module_id`),
  CONSTRAINT `fk_module_id_progression_modules` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_progression_modules` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progression_modules`
--

LOCK TABLES `progression_modules` WRITE;
/*!40000 ALTER TABLE `progression_modules` DISABLE KEYS */;
INSERT INTO `progression_modules` VALUES (1,9,1,1,3600,'2026-04-18 10:00:00'),(2,9,2,0,1800,'2026-04-18 11:00:00'),(3,9,3,1,2700,'2026-04-15 14:00:00'),(4,9,4,1,3600,'2026-04-15 16:00:00'),(5,10,5,0,900,'2026-04-17 09:00:00');
/*!40000 ALTER TABLE `progression_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('apprenant','formateur','admin','compliance') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'apprenant',
  `nom` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rpps_number` varbinary(255) DEFAULT NULL,
  `specialite` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'admin@saah-medilearn.fr','$argon2id$v=19$m=65536,t=3,p=4$PLACEHOLDER_ADMIN','admin','Saah','Admin',NULL,NULL,NULL,1,NULL,'2026-04-19 07:01:56','2026-04-19 07:01:56'),(7,'formateur1@saah-medilearn.fr','$argon2id$v=19$m=65536,t=3,p=4$PLACEHOLDER_F1','formateur','Jerome','Oriane',NULL,'Cardiologie',NULL,1,NULL,'2026-04-19 07:01:56','2026-04-19 07:01:56'),(8,'formateur2@saah-medilearn.fr','$argon2id$v=19$m=65536,t=3,p=4$PLACEHOLDER_F2','formateur','Emma','Sandrine',NULL,'Urgences',NULL,1,NULL,'2026-04-19 07:01:56','2026-04-19 07:01:56'),(9,'apprenant1@saah-medilearn.fr','$argon2id$v=19$m=65536,t=3,p=4$PLACEHOLDER_A1','apprenant','Dorothée','Winnie',NULL,'Médecine générale',NULL,1,NULL,'2026-04-19 07:01:56','2026-04-19 07:01:56'),(10,'apprenant2@saah-medilearn.fr','$argon2id$v=19$m=65536,t=3,p=4$PLACEHOLDER_A2','apprenant','Makou','Carrelle',NULL,'Infirmière',NULL,1,NULL,'2026-04-19 07:01:56','2026-04-19 07:01:56');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-19  9:52:24
