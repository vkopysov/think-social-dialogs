CREATE DATABASE  IF NOT EXISTS `think_social_db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `think_social_db`;
-- MySQL dump 10.13  Distrib 5.6.19, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: think_social_db
-- ------------------------------------------------------
-- Server version	5.5.52-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `admin_list`
--

DROP TABLE IF EXISTS `admin_list`;
/*!50001 DROP VIEW IF EXISTS `admin_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `admin_list` AS SELECT 
 1 AS `first_name`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,'family','2017-01-02 13:38:13',NULL,0),(2,'I','2017-01-02 13:38:13',NULL,0),(3,'friends','2017-01-02 13:38:13',NULL,0),(4,'pets','2017-01-02 13:38:13',NULL,0),(5,'car','2017-01-02 13:38:13',NULL,0),(6,'Друзья','2017-01-02 13:39:17',NULL,0),(7,'Путешествия','2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums_groups`
--

DROP TABLE IF EXISTS `albums_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) NOT NULL,
  `groups_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `album_id` (`album_id`),
  KEY `fk_albums_users_albums1_idx` (`album_id`),
  KEY `fk_albums_groups_groups1_idx` (`groups_id`),
  CONSTRAINT `fk_albums_groups_groups1` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_albums_users_albums10` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums_groups`
--

LOCK TABLES `albums_groups` WRITE;
/*!40000 ALTER TABLE `albums_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `albums_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums_photos`
--

DROP TABLE IF EXISTS `albums_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `status` enum('active','block') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`album_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `file_name` (`file_name`),
  KEY `fk_albums_photos_albums1_idx` (`album_id`),
  CONSTRAINT `fk_albums_photos_albums1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums_photos`
--

LOCK TABLES `albums_photos` WRITE;
/*!40000 ALTER TABLE `albums_photos` DISABLE KEYS */;
INSERT INTO `albums_photos` VALUES (1,6,'Sasha.JPG','Мой друг Саша','active','2017-01-02 13:39:17',NULL,0),(2,7,'mars1.jpg','Атмосфера Марса','active','2017-01-02 13:39:17',NULL,0),(3,7,'mars2.jpg','Марс','active','2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `albums_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums_photos_comments`
--

DROP TABLE IF EXISTS `albums_photos_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums_photos_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) NOT NULL,
  `albums_photos_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_id` (`comment_id`),
  KEY `fk_news_comments_comments1_idx` (`comment_id`),
  KEY `fk_albums_photos_comments_albums_photos1_idx` (`albums_photos_id`),
  CONSTRAINT `fk_albums_photos_comments_albums_photos1` FOREIGN KEY (`albums_photos_id`) REFERENCES `albums_photos` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_news_comments_comments10` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums_photos_comments`
--

LOCK TABLES `albums_photos_comments` WRITE;
/*!40000 ALTER TABLE `albums_photos_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `albums_photos_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums_users`
--

DROP TABLE IF EXISTS `albums_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `album_id` (`album_id`),
  KEY `fk_albums_users_users1_idx` (`user_id`),
  KEY `fk_albums_users_albums1_idx` (`album_id`),
  CONSTRAINT `fk_albums_users_albums1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_albums_users_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums_users`
--

LOCK TABLES `albums_users` WRITE;
/*!40000 ALTER TABLE `albums_users` DISABLE KEYS */;
INSERT INTO `albums_users` VALUES (1,1,1,'2017-01-02 13:38:13',NULL,0),(2,1,3,'2017-01-02 13:38:13',NULL,0),(3,1,5,'2017-01-02 13:38:13',NULL,0),(4,2,2,'2017-01-02 13:38:13',NULL,0),(5,2,4,'2017-01-02 13:38:13',NULL,0),(6,5,6,'2017-01-02 13:39:17',NULL,0),(7,5,7,'2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `albums_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_id_name` (`country_id`,`name`),
  KEY `fk_cities_countries1_idx` (`country_id`),
  CONSTRAINT `fk_cities_country_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,1,'Киев','2017-01-02 13:38:13',NULL,0),(2,1,'Харьков','2017-01-02 13:38:13',NULL,0),(3,2,'Москва','2017-01-02 13:38:13',NULL,0);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `status` enum('active','block') DEFAULT 'active',
  `published` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_comments_users1_idx` (`user_id`),
  CONSTRAINT `fk_comments_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complaints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `status` enum('considered','unconsidered') NOT NULL DEFAULT 'unconsidered',
  `published` timestamp NULL DEFAULT NULL,
  `complaints_types_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_comments_users1_idx` (`user_id`),
  KEY `fk_complaints_complaints_types1_idx` (`complaints_types_id`),
  CONSTRAINT `fk_comments_users10` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_complaints_complaints_types1` FOREIGN KEY (`complaints_types_id`) REFERENCES `complaints_types` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints`
--

LOCK TABLES `complaints` WRITE;
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaints_types`
--

DROP TABLE IF EXISTS `complaints_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complaints_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `table_name` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_name_UNIQUE` (`table_name`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints_types`
--

LOCK TABLES `complaints_types` WRITE;
/*!40000 ALTER TABLE `complaints_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `complaints_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Украина','2017-01-02 13:38:13',NULL,0),(2,'Россия','2017-01-02 13:38:13',NULL,0);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dialog_rooms`
--

DROP TABLE IF EXISTS `dialog_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dialog_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(90) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `unread_messages` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_dialog_rooms_users_idx` (`creator_id`),
  CONSTRAINT `fk_dialog_rooms_users` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dialog_rooms`
--

LOCK TABLES `dialog_rooms` WRITE;
/*!40000 ALTER TABLE `dialog_rooms` DISABLE KEYS */;
INSERT INTO `dialog_rooms` VALUES (73,'Simple',7,0),(74,'Multi',8,0);
/*!40000 ALTER TABLE `dialog_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `user_sender` int(11) NOT NULL,
  `user_receiver` int(11) NOT NULL,
  `status` enum('applied','unapplied') NOT NULL DEFAULT 'unapplied',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `sender_receiver` (`user_sender`,`user_receiver`),
  KEY `fk_table1_users1_idx` (`user_sender`),
  KEY `fk_table1_users2_idx` (`user_receiver`),
  CONSTRAINT `fk_table1_users1` FOREIGN KEY (`user_sender`) REFERENCES `users` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_table1_users2` FOREIGN KEY (`user_receiver`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (1,7,'unapplied','2017-01-02 13:38:15',NULL,0),(4,3,'applied','2017-01-02 13:38:15',NULL,0),(4,5,'unapplied','2017-01-02 13:39:17',NULL,0),(5,1,'applied','2017-01-02 13:38:15',NULL,0),(6,5,'unapplied','2017-01-02 13:39:17',NULL,0),(7,1,'unapplied','2017-01-02 13:38:15',NULL,0),(7,8,'applied','2017-01-13 01:06:48',NULL,0),(7,9,'applied','2017-01-02 13:38:15',NULL,0),(9,8,'applied','2017-01-25 05:41:45',NULL,0);
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` tinytext NOT NULL,
  `status` enum('active','block') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idusers_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Наш сад','Группа для любителей садоводства','active','2017-01-02 13:39:17',NULL,0),(2,'Готовим вкусно','Кулинарная группа','active','2017-01-02 13:39:17',NULL,0),(3,'Вышиваем вместе','Группа для истинных любителей художественной вышивки','active','2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_avatars`
--

DROP TABLE IF EXISTS `groups_avatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_avatars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(100) NOT NULL,
  `group_id` int(11) NOT NULL,
  `status` enum('active','block') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`),
  KEY `fk_groups_avatars_groups1_idx` (`group_id`),
  CONSTRAINT `fk_groups_avatars_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_avatars`
--

LOCK TABLES `groups_avatars` WRITE;
/*!40000 ALTER TABLE `groups_avatars` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_avatars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_news`
--

DROP TABLE IF EXISTS `groups_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `news_id` (`news_id`),
  KEY `fk_users_news_news1_idx` (`news_id`),
  KEY `fk_groups_news_groups1_idx` (`group_id`),
  CONSTRAINT `fk_groups_news_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_users_news_news10` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_news`
--

LOCK TABLES `groups_news` WRITE;
/*!40000 ALTER TABLE `groups_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) NOT NULL,
  `dialog_room_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`sender_id`),
  KEY `fk_messages_users1_idx` (`sender_id`),
  KEY `fk_messages_users2_idx` (`dialog_room_id`),
  CONSTRAINT `fk_messages_dialog_rooms` FOREIGN KEY (`dialog_room_id`) REFERENCES `dialog_rooms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_users1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,7,73,'Testing message','2017-01-25 06:32:10',NULL,0),(2,7,73,'Testing Message 2','2017-01-25 06:32:19',NULL,0),(3,8,73,'Hi, Vladimir','2017-01-25 06:33:30',NULL,0),(4,8,74,'Hello','2017-01-25 06:34:45',NULL,0),(5,7,74,'Hello, all\n','2017-01-25 06:35:03',NULL,0),(6,9,74,'8 800 555 35 35','2017-01-25 06:36:08',NULL,0);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `text` text NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `status` enum('active','block') NOT NULL DEFAULT 'active',
  `published` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'qwe','qwe123','qwe','active','2016-12-16 16:05:50','2017-01-02 13:38:14',NULL,0),(2,'asd','asd123','asd','active','2016-12-16 16:05:59','2017-01-02 13:38:14',NULL,0),(3,'2030: Высадка китайцев на Марс','Вы скажете, что это невозможно? Однако еще 20 лет назад мир и понятия не имел о \"китайском чуде\"...','chinese.jpeg','active','2017-01-02 13:39:17','2017-01-02 13:39:17',NULL,0),(4,'1 Сентября - День Знаний','Поздравляем всех школьников и студентов, а также их родителей и учителей, бабушек и дедушек, работников транспорта и остальное прогрессивное человечество','school_07.jpg','active','2016-08-31 21:00:00','2017-01-02 13:39:17',NULL,0),(5,'День народження Марко Вовчок','Марко́ Вовчо́к (справжнє ім\'я: Марія Олександрівна Вілінська, за першим чоловіком — Маркович, за другим чоловіком — Лобач-Жученко; * 10 (22) грудня 1833, маєток Єкатерининське Єлецького повіту[ru] Орловської губернії, тепер Липецька область РФ — † 28 липня (10 серпня) 1907, Нальчик, Росія) — українська письменниця, перекладачка. Дружина етнографа Опанаса Маркевича (Марковича). Мати публіциста Богдана Марковича. Троюрідна сестра російського літературного критика Д.І.Писарєва.\nБула знайома з Тарасом Шевченком, Пантелеймоном Кулішем, Миколою Костомаровим, Іваном Тургенєвим, Олександром Герценом, Жулем Верном. Її твори мали антикріпацьке спрямування. Також описувала історичне минуле України.','google_Vovchok.jpg','active','2015-12-21 22:00:00','2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_comments`
--

DROP TABLE IF EXISTS `news_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_id` (`comment_id`),
  KEY `fk_news_comments_news1_idx` (`news_id`),
  KEY `fk_news_comments_comments1_idx` (`comment_id`),
  CONSTRAINT `fk_news_comments_comments1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_news_comments_news1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_comments`
--

LOCK TABLES `news_comments` WRITE;
/*!40000 ALTER TABLE `news_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passwords`
--

DROP TABLE IF EXISTS `passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `passwords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_id_UNIQUE` (`user_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_passwords_users1_idx` (`user_id`),
  CONSTRAINT `fk_passwords_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passwords`
--

LOCK TABLES `passwords` WRITE;
/*!40000 ALTER TABLE `passwords` DISABLE KEYS */;
INSERT INTO `passwords` VALUES (1,1,'qwerty','2017-01-02 13:38:14',NULL,0),(2,2,'q1w2e3','2017-01-02 13:38:14',NULL,0),(3,3,'qwerty123','2017-01-02 13:38:14',NULL,0);
/*!40000 ALTER TABLE `passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phones`
--

DROP TABLE IF EXISTS `phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  KEY `fk_phones_users1_idx` (`user_id`),
  CONSTRAINT `fk_phones_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phones`
--

LOCK TABLES `phones` WRITE;
/*!40000 ALTER TABLE `phones` DISABLE KEYS */;
INSERT INTO `phones` VALUES (1,1,'0971231212','2017-01-02 13:38:14',NULL,0),(2,1,'0681231212','2017-01-02 13:38:14',NULL,0),(3,2,'0972341212','2017-01-02 13:38:14',NULL,0);
/*!40000 ALTER TABLE `phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipients`
--

DROP TABLE IF EXISTS `recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dialog_room_id` int(11) NOT NULL,
  `unread_counter` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_recipients_users_idx` (`user_id`),
  KEY `fk_recipients_dialog_rooms_idx` (`dialog_room_id`),
  CONSTRAINT `fk_recipients_dialog_rooms` FOREIGN KEY (`dialog_room_id`) REFERENCES `dialog_rooms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipients_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipients`
--

LOCK TABLES `recipients` WRITE;
/*!40000 ALTER TABLE `recipients` DISABLE KEYS */;
INSERT INTO `recipients` VALUES (1,7,73,0),(2,8,73,2),(3,8,74,2),(4,7,74,0),(5,9,74,2);
/*!40000 ALTER TABLE `recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` enum('user','admin') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','2017-01-02 13:38:14',NULL,0),(2,'user','2017-01-02 13:38:14',NULL,0);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `middle_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  `birthday` date NOT NULL,
  `sex` enum('male','female') NOT NULL,
  `status` enum('active','block') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(90) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idusers_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Вадим','Александрович','Малец','abc@bb.bb','1996-04-27','male','active','2017-01-02 13:38:14',NULL,0,''),(2,'Илья','Юрьевич','Морква','test@bb.eu','1996-04-28','female','active','2017-01-02 13:38:14',NULL,0,''),(3,'Петя','Петрович','Пупкин','petya@bb.ua','1996-01-12','male','block','2017-01-02 13:38:14',NULL,0,''),(4,'Вася','Васильевич','Васькин','vasya@bb.ru','1997-01-01','male','active','2017-01-02 13:38:14',NULL,0,''),(5,'Ирина','Александровна','Иркина','ira@bb.ru','1981-01-14','female','active','2017-01-02 13:38:14',NULL,0,''),(6,'Даша','Фёдоровна','Дашевна','dasha@bb.ru','1989-09-09','female','active','2017-01-02 13:38:14',NULL,0,''),(7,'Владимир','Игоревич','Копысов','test@email.com','1995-08-21','male','active','2017-01-09 07:47:13',NULL,0,'test'),(8,' Иван','Иванович','Иванов','test2@email.com','1990-01-11','male','active','2017-01-13 01:06:17',NULL,0,'test'),(9,'Петр','Петрович','Петров','test3@email.com','1980-02-02','male','active','2017-01-25 05:38:09',NULL,0,'test');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_avatars`
--

DROP TABLE IF EXISTS `users_avatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_avatars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `status` enum('active','block') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `fk_user_avatar_users1_idx` (`user_id`),
  CONSTRAINT `fk_user_avatar_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_avatars`
--

LOCK TABLES `users_avatars` WRITE;
/*!40000 ALTER TABLE `users_avatars` DISABLE KEYS */;
INSERT INTO `users_avatars` VALUES (1,5,'red.JPG','active','2017-01-02 13:39:17',NULL,0),(2,4,'zveropolis.jpeg','active','2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `users_avatars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_avatars_comments`
--

DROP TABLE IF EXISTS `users_avatars_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_avatars_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_avatar_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `comment_id` (`comment_id`),
  KEY `fk_users_avatars_comments_users_avatars1_idx` (`user_avatar_id`),
  KEY `fk_users_avatars_comments_comments1_idx` (`comment_id`),
  CONSTRAINT `fk_users_avatars_comments_comments1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_users_avatars_comments_users_avatars1` FOREIGN KEY (`user_avatar_id`) REFERENCES `users_avatars` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_avatars_comments`
--

LOCK TABLES `users_avatars_comments` WRITE;
/*!40000 ALTER TABLE `users_avatars_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_avatars_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_cities`
--

DROP TABLE IF EXISTS `users_cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_users_cities_1_idx` (`user_id`),
  KEY `fk_users_cities_1_idx1` (`city_id`),
  CONSTRAINT `fk_users_cities_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_users_idq_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_cities`
--

LOCK TABLES `users_cities` WRITE;
/*!40000 ALTER TABLE `users_cities` DISABLE KEYS */;
INSERT INTO `users_cities` VALUES (1,1,1,'2017-01-02 13:38:14',NULL,0),(2,2,1,'2017-01-02 13:38:14',NULL,0),(3,3,2,'2017-01-02 13:38:14',NULL,0),(4,5,2,'2017-01-02 13:39:17',NULL,0),(5,4,1,'2017-01-02 13:39:17',NULL,0),(6,6,3,'2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `users_cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `group_id_user_id` (`group_id`,`user_id`),
  KEY `fk_groups_news_groups1_idx` (`group_id`),
  KEY `fk_users_groups_users1_idx` (`user_id`),
  CONSTRAINT `fk_groups_news_groups10` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (1,1,5,'2017-01-02 13:39:17',NULL,0),(2,2,5,'2017-01-02 13:39:17',NULL,0),(3,3,5,'2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_news`
--

DROP TABLE IF EXISTS `users_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `news_id` (`news_id`),
  KEY `fk_users_news_news1_idx` (`news_id`),
  KEY `fk_users_news_users1_idx` (`user_id`),
  CONSTRAINT `fk_users_news_news1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_users_news_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_news`
--

LOCK TABLES `users_news` WRITE;
/*!40000 ALTER TABLE `users_news` DISABLE KEYS */;
INSERT INTO `users_news` VALUES (1,1,1,'2017-01-02 13:38:14',NULL,0),(2,2,1,'2017-01-02 13:38:14',NULL,0),(3,3,5,'2017-01-02 13:39:17',NULL,0),(4,4,5,'2017-01-02 13:39:17',NULL,0),(5,5,5,'2017-01-02 13:39:17',NULL,0);
/*!40000 ALTER TABLE `users_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `user_id_role_id` (`user_id`,`role_id`),
  KEY `fk_users_roles_users_idx` (`user_id`),
  KEY `fk_users_roles_roles1_idx` (`role_id`),
  CONSTRAINT `fk_users_roles_roles1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `fk_users_roles_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (4,1,2,'2017-01-02 13:38:14',NULL,0),(5,2,2,'2017-01-02 13:38:14',NULL,0),(6,3,2,'2017-01-02 13:38:14',NULL,0),(7,4,2,'2017-01-02 13:38:14',NULL,0),(8,5,2,'2017-01-02 13:38:14',NULL,0),(9,6,2,'2017-01-02 13:38:14',NULL,0),(10,7,2,'2017-01-09 07:47:13',NULL,0),(11,8,2,'2017-01-13 01:06:17',NULL,0),(12,9,2,'2017-01-25 05:38:09',NULL,0);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `admin_list`
--

/*!50001 DROP VIEW IF EXISTS `admin_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `admin_list` AS select `u`.`first_name` AS `first_name`,`r`.`name` AS `name` from ((`users` `u` join `users_roles` `ur` on((`u`.`id` = `ur`.`user_id`))) join `roles` `r` on((`ur`.`role_id` = `r`.`id`))) where (`r`.`name` = 'admin') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-25  1:38:33
