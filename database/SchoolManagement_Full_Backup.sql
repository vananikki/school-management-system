-- MySQL dump 10.13  Distrib 9.6.0, for Win64 (x86_64)
--
-- Host: localhost    Database: SchoolManagement
-- ------------------------------------------------------
-- Server version	9.6.0

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
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `ClassID` int NOT NULL,
  `ClassName` varchar(50) NOT NULL,
  `TeacherID` int DEFAULT NULL,
  PRIMARY KEY (`ClassID`),
  KEY `TeacherID` (`TeacherID`),
  CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`TeacherID`) REFERENCES `teachers` (`TeacherID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (101,'DS66A',11204567),(102,'DS66B',11204567),(103,'AI66A',11208912),(104,'AI66B',11203344),(105,'DS67A',11204567),(106,'DS67B',11207788),(107,'DS67C',11205566),(108,'AI67A',11203344),(109,'AI67B',11208912),(110,'AI67C',11207788);
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classstats`
--

DROP TABLE IF EXISTS `classstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classstats` (
  `ClassID` int NOT NULL,
  `AverageGPA` decimal(4,2) DEFAULT '0.00',
  `TotalRecords` int DEFAULT '0',
  PRIMARY KEY (`ClassID`),
  CONSTRAINT `classstats_ibfk_1` FOREIGN KEY (`ClassID`) REFERENCES `classes` (`ClassID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classstats`
--

LOCK TABLES `classstats` WRITE;
/*!40000 ALTER TABLE `classstats` DISABLE KEYS */;
INSERT INTO `classstats` VALUES (101,0.00,0),(102,0.00,0),(103,0.00,0),(104,0.00,0),(105,7.96,8),(106,0.00,0),(107,0.00,0),(108,0.00,0),(109,6.19,7),(110,0.00,0);
/*!40000 ALTER TABLE `classstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `GradeID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int DEFAULT NULL,
  `SubjectID` int DEFAULT NULL,
  `Score` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`GradeID`),
  KEY `StudentID` (`StudentID`),
  KEY `SubjectID` (`SubjectID`),
  KEY `idx_GradeScore` (`Score`),
  CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`),
  CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`SubjectID`) REFERENCES `subjects` (`SubjectID`),
  CONSTRAINT `grades_chk_1` CHECK (((`Score` >= 0) and (`Score` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (1,11247118,1,8.50),(2,11247118,2,7.00),(3,11247118,3,9.20),(4,11247118,4,8.80),(5,11247118,5,7.50),(6,11247118,6,8.00),(7,11247121,1,3.20),(8,11247121,2,5.00),(9,11247121,3,4.50),(10,11247121,4,2.80),(11,11247121,5,6.00),(12,11247121,6,5.20),(13,11247125,1,9.50),(14,11247125,2,9.00),(15,11247125,3,9.50),(16,11247125,4,9.00),(17,11247125,5,9.80),(18,11247125,6,9.10),(19,11247123,1,10.00),(20,11247123,2,9.80),(21,11247123,3,10.00),(22,11247123,4,10.00),(23,11247123,5,9.50),(24,11247123,6,10.00),(25,11247130,1,9.50),(26,11247130,2,8.20),(27,11247130,3,6.80),(28,11247130,4,7.50),(29,11247130,5,6.00),(30,11247130,6,7.70),(31,11247137,1,6.50),(32,11247137,2,4.20),(33,11247137,3,8.00),(34,11247137,4,7.20),(35,11247137,5,5.80),(36,11247137,6,7.50),(37,11247140,1,8.20),(38,11247140,2,7.50),(39,11247140,3,6.20),(40,11247140,4,9.50),(41,11247140,5,8.80),(42,11247140,6,2.00),(43,11247141,1,9.00),(44,11247141,2,6.50),(45,11247141,3,8.80),(46,11247141,4,7.50),(47,11247141,5,9.20),(48,11247141,6,9.50),(49,11247146,1,5.50),(50,11247146,2,6.20),(51,11247146,3,7.00),(52,11247146,4,3.80),(53,11247146,5,5.50),(54,11247146,6,6.80),(55,11247147,1,7.80),(56,11247147,2,8.50),(57,11247147,3,5.50),(58,11247147,4,8.00),(59,11247147,5,7.50),(60,11247147,6,8.20),(61,11247146,1,8.50),(62,11247130,6,9.00),(63,11247130,6,9.00);
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_UpdateClassPerformance` AFTER INSERT ON `grades` FOR EACH ROW BEGIN
    -- Lấy ClassID của sinh viên vừa được nhập điểm
    DECLARE v_ClassID INT;
    SELECT ClassID INTO v_ClassID FROM Students WHERE StudentID = NEW.StudentID;

    -- Tự động cập nhật lại điểm trung bình và số lượng đầu điểm của lớp đó
    UPDATE ClassStats
    SET AverageGPA = (
        SELECT AVG(g.Score) 
        FROM Grades g 
        JOIN Students s ON g.StudentID = s.StudentID 
        WHERE s.ClassID = v_ClassID
    ),
    TotalRecords = (
        SELECT COUNT(*) 
        FROM Grades g 
        JOIN Students s ON g.StudentID = s.StudentID 
        WHERE s.ClassID = v_ClassID
    )
    WHERE ClassID = v_ClassID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `StudentID` int NOT NULL,
  `StudentName` varchar(100) NOT NULL,
  `BirthDate` date DEFAULT NULL,
  `ClassID` int DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`StudentID`),
  KEY `ClassID` (`ClassID`),
  KEY `idx_StudentName` (`StudentName`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`ClassID`) REFERENCES `classes` (`ClassID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (11247118,'Nguyễn Hoàng Thiên An','2006-05-15',102,'Quận Hai Bà Trưng, Hà Nội'),(11247121,'Bùi Duy Anh','2006-08-22',102,'Quận Đống Đa, Hà Nội'),(11247123,'Đinh Vân Anh','2006-11-30',104,'Quận Ba Đình, Hà Nội'),(11247125,'Dương Minh Anh','2006-01-10',103,'Quận Cầu Giấy, Hà Nội'),(11247130,'Nguyễn Hồng Anh','2006-03-12',108,'Quận Thanh Xuân, Hà Nội'),(11247137,'Phạm Thùy Anh','2006-07-19',106,'Quận Hoàn Kiếm, Hà Nội'),(11247140,'Trần Đinh Quang Anh','2006-12-05',107,'Quận Long Biên, Hà Nội'),(11247141,'Vũ Thị Phương Anh','2006-09-14',108,'Quận Tây Hồ, Hà Nội'),(11247146,'Nguyễn Minh Chiến','2006-02-28',109,'Quận Nam Từ Liêm, Hà Nội'),(11247147,'Bùi Đăng Cường','2006-04-20',110,'Quận Hà Đông, Hà Nội');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `SubjectID` int NOT NULL,
  `SubjectName` varchar(100) NOT NULL,
  PRIMARY KEY (`SubjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,'Information Security'),(2,'Mathematics for Data Science and AI'),(3,'Data Analysis with Python'),(4,'Introduction to Databases'),(5,'Monetary and Financial Theory'),(6,'Cloud Computing');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `TeacherID` int NOT NULL,
  `TeacherName` varchar(100) NOT NULL,
  `Subject` varchar(255) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`TeacherID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `idx_TeacherName` (`TeacherName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (11203344,'Lê Thị Hòa','Mathematics for Data Science and AI','le_hoa@st.neu.edu.vn'),(11204567,'Nguyễn Văn Hùng','Introduction to Databases & Data Analysis with Python','nguyen_hung@st.neu.edu.vn'),(11205566,'Phạm Anh Tuấn','Monetary and Financial Theory','pham_tuan@st.neu.edu.vn'),(11207788,'Hoàng Trung Kiên','Cloud Computing','hoang_kien@st.neu.edu.vn'),(11208912,'Trần Minh Tâm','Information Security','tran_tam@st.neu.edu.vn');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_classrosters`
--

DROP TABLE IF EXISTS `v_classrosters`;
/*!50001 DROP VIEW IF EXISTS `v_classrosters`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_classrosters` AS SELECT 
 1 AS `ClassName`,
 1 AS `StudentID`,
 1 AS `StudentName`,
 1 AS `BirthDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_subjectperformance`
--

DROP TABLE IF EXISTS `v_subjectperformance`;
/*!50001 DROP VIEW IF EXISTS `v_subjectperformance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_subjectperformance` AS SELECT 
 1 AS `SubjectName`,
 1 AS `AverageScore`,
 1 AS `LowestScore`,
 1 AS `HighestScore`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_topstudents`
--

DROP TABLE IF EXISTS `v_topstudents`;
/*!50001 DROP VIEW IF EXISTS `v_topstudents`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_topstudents` AS SELECT 
 1 AS `StudentID`,
 1 AS `StudentName`,
 1 AS `GPA`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_classrosters`
--

/*!50001 DROP VIEW IF EXISTS `v_classrosters`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_classrosters` AS select `c`.`ClassName` AS `ClassName`,`s`.`StudentID` AS `StudentID`,`s`.`StudentName` AS `StudentName`,`s`.`BirthDate` AS `BirthDate` from (`students` `s` join `classes` `c` on((`s`.`ClassID` = `c`.`ClassID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_subjectperformance`
--

/*!50001 DROP VIEW IF EXISTS `v_subjectperformance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_subjectperformance` AS select `sub`.`SubjectName` AS `SubjectName`,round(avg(`g`.`Score`),2) AS `AverageScore`,min(`g`.`Score`) AS `LowestScore`,max(`g`.`Score`) AS `HighestScore` from (`subjects` `sub` join `grades` `g` on((`sub`.`SubjectID` = `g`.`SubjectID`))) group by `sub`.`SubjectID`,`sub`.`SubjectName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_topstudents`
--

/*!50001 DROP VIEW IF EXISTS `v_topstudents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_topstudents` AS select `s`.`StudentID` AS `StudentID`,`s`.`StudentName` AS `StudentName`,round(avg(`g`.`Score`),2) AS `GPA` from (`students` `s` join `grades` `g` on((`s`.`StudentID` = `g`.`StudentID`))) group by `s`.`StudentID`,`s`.`StudentName` having (`GPA` >= 8.0) order by `GPA` desc */;
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

-- Dump completed on 2026-05-02 22:51:54
