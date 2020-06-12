-- MariaDB dump 10.17  Distrib 10.5.3-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: suamil_db
-- ------------------------------------------------------
-- Server version	10.5.3-MariaDB

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
-- Table structure for table `membership`
--

DROP TABLE IF EXISTS `membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membership` (
  `id` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `pass` varchar(30) NOT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `mobile` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `zip` varchar(30) NOT NULL,
  `addr` varchar(30) NOT NULL,
  `joinDate` datetime DEFAULT current_timestamp(),
  `authority` varchar(30) DEFAULT 'normal',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership`
--

LOCK TABLES `membership` WRITE;
/*!40000 ALTER TABLE `membership` DISABLE KEYS */;
INSERT INTO `membership` VALUES ('','','','--','--','@','-',' ','2020-05-29 11:26:40','normal'),('adsadsasd','adsadsa','adsads','asd-dsa-asd','dsa-ads-ads','ads@dreamwiz.com','ads','das asdasd','2020-05-29 20:01:49','normal'),('asd','asdasd','','--','--','@','',' ','2020-05-29 20:06:08','normal'),('asdasd','','','--','--','@','-',' ','2020-05-29 11:25:40','normal'),('asdsad','','','--','--','@','-',' ','2020-05-29 11:25:11','normal'),('dasd','asdsadsa','sadsad','dsa-sad-asda','dsa-dsa-dsad','sadsa@paran.com','sadsa-dada','sadsa dsadsadsad','2020-05-29 11:03:34','normal'),('hi123','정상혁','a1234','02-5555-6666','010-1234-5678','wjdtkdgur95@gmail.com','06294','서울 강남구 언주로30길 26 52층','2020-05-31 16:32:53','normal'),('hihi','상구','1234','02-2252-9595','010-7599-8311','gur9595@naver.com','04726','서울 성동구 금호산10길 16-3 3층','2020-05-29 14:57:19','admin'),('hits','태식이','a1234','02-2222-3333','010-5555-6666','hits@naver.com','14743','경기 부천시 송내동 303-5 55층','2020-06-04 15:34:17','normal'),('hong1','홍길동','1234','02-5555-5555','010-2222-2222','hong1@naver.com','1111-2222','아이티벤처타워','2020-05-28 16:54:10','normal'),('sadsadsa','','','--','--','@','-',' ','2020-05-29 11:35:28','normal'),('sddssd','','','--','--','@','-',' ','2020-05-29 11:34:40','normal'),('test1','test1','test1','testesttest','testesttest','test1@','test1-test1','test1 test1','2020-05-28 17:01:36','normal'),('test10','test10','test10','tes-test-test','tes-test-test','test10@','test10-test10','test10 test10','2020-05-28 17:39:57','normal'),('test2','test2','test2','testesttest','testesttest','test2@','test2-test2','test2 test2','2020-05-28 17:05:38','normal'),('test3','test3','test2','testesttest','testesttest','test2@','test2-test2','test2 test2','2020-05-28 17:08:00','normal'),('test4','test3','test2','testesttest','testesttest','test2@','test2-test2','test2 test2','2020-05-28 17:10:07','normal'),('test5','test5','test5','testesttest','testesttest','test5@','test5-test5','test5 test5','2020-05-28 17:10:55','normal'),('test6','test6','test6','testesttest','testesttest','test6@','test6-test6','test6 test6','2020-05-28 17:16:41','normal'),('test7','test7','test7','testesttest','testesttest','test7@','test7-test7','test7 test7','2020-05-28 17:17:16','normal'),('test8','test8','test8','testesttest','testesttest','test8@','test8-test8','test8 test8','2020-05-28 17:17:50','normal'),('test9','test9','test9','testesttest','testesttest','test9@','test9-test9','test9 test9','2020-05-28 17:21:36','normal'),('test99','test99','test99','tes-test-test','tes-test-test','test99@sayclub.com','test99-test99','test99 test99','2020-05-29 11:11:15','normal');
/*!40000 ALTER TABLE `membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multi_board`
--

DROP TABLE IF EXISTS `multi_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multi_board` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `postdate` datetime DEFAULT current_timestamp(),
  `id` varchar(30) NOT NULL,
  `visitcount` mediumint(10) NOT NULL DEFAULT 0,
  `bname` varchar(10) NOT NULL DEFAULT 'freeboard',
  `img` varchar(100) DEFAULT NULL,
  `ofile` varchar(100) DEFAULT NULL,
  `sfile` varchar(100) DEFAULT NULL,
  `attachedfile` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `fk_multiboard_membership` (`id`),
  CONSTRAINT `fk_multiboard_membership` FOREIGN KEY (`id`) REFERENCES `membership` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multi_board`
--

LOCK TABLES `multi_board` WRITE;
/*!40000 ALTER TABLE `multi_board` DISABLE KEYS */;
INSERT INTO `multi_board` VALUES (1,'제목입니다1','내용입니다1','2020-06-01 16:20:53','hihi',0,'freeboard',NULL,NULL,NULL,NULL),(2,'제목입니다2','내용입니다2','2020-06-01 16:20:56','hihi',0,'freeboard',NULL,NULL,NULL,NULL),(3,'제목입니다3','내용입니다3','2020-06-01 16:20:58','hihi',1,'freeboard',NULL,NULL,NULL,NULL),(4,'제목입니다4','내용입니다4','2020-06-01 16:21:00','hihi',5,'freeboard',NULL,NULL,NULL,NULL),(5,'제목입니다5','내용입니다5','2020-06-01 16:21:04','hihi',8,'freeboard',NULL,NULL,NULL,NULL),(6,'테스트중','테스트중','2020-06-01 17:02:18','hihi',1,'freeboard',NULL,NULL,NULL,NULL),(7,'테스트중2','테스트중2','2020-06-01 17:04:43','hihi',3,'freeboard',NULL,NULL,NULL,NULL),(10,'테스트좀','테스트좀\r\nㅇ아아아ㅏ아아아아\r\nㅏ아아ㅏ아아아아아\r\n아아아아ㅏ아앙\r\n아아아ㅏ아앙\r\n아아아아ㅏ아아아아아ㅏ\r\n','2020-06-01 17:09:29','hihi',1,'freeboard',NULL,NULL,NULL,NULL),(13,'test13 수정','test13 수정','2020-06-01 17:43:17','hihi',20,'freeboard',NULL,NULL,NULL,NULL),(14,'하이요','하이요','2020-06-01 18:00:38','hi123',10,'freeboard',NULL,NULL,NULL,NULL),(16,'하이요  수정','하이요 수정','2020-06-02 18:04:19','hihi',0,'freeboard',NULL,NULL,NULL,NULL),(17,'테스트중22','테스트중22','2020-06-02 18:05:43','hihi',1,'freeboard',NULL,NULL,NULL,NULL),(18,'테스트중223','테스트중223','2020-06-02 18:07:34','hihi',2,'freeboard',NULL,NULL,NULL,NULL),(19,'하이요  수정 ','수정 ','2020-06-02 18:09:35','hi123',10,'freeboard',NULL,NULL,NULL,NULL),(20,'여긴 공지사항1','내용없음1','2020-06-02 19:25:01','hihi',0,'notice',NULL,NULL,NULL,NULL),(22,'여긴 공지사항3','내용없음3','2020-06-02 19:25:11','hihi',0,'notice',NULL,NULL,NULL,NULL),(24,'여긴 공지사항5','내용없음5','2020-06-02 19:25:15','hihi',9,'notice',NULL,NULL,NULL,NULL),(31,'자유게시판 게시물','자유게시판 게시물','2020-06-02 19:38:08','hihi',2,'freeboard',NULL,NULL,NULL,NULL),(32,'공지사항 게시물','공지사항 게시물','2020-06-02 19:38:22','hihi',10,'notice',NULL,NULL,NULL,NULL),(33,'글쓰기 테스트','테스트중','2020-06-03 11:49:45','hihi',79,'freeboard',NULL,NULL,NULL,NULL),(36,'첨부2 수정 수정','수정 수정 첨부2','2020-06-03 17:52:46','hihi',17,'info',NULL,'존잘_은석.png','2020_06_03_20_50_42_802.png',NULL),(37,'하이 독래','하이 독래','2020-06-03 20:27:08','hihi',7,'info',NULL,'존잘_은석.png','2020_06_03_20_59_20_512.png',NULL),(38,'testtest','testtest','2020-06-03 22:03:06','hihi',3,'info',NULL,'KakaoTalk_20200514_162336503.png','2020_06_03_22_3_6_678.png',NULL),(40,'testtestest','testesest','2020-06-03 22:14:38','hihi',0,'photo',NULL,NULL,NULL,NULL),(41,'testestes','testtestests','2020-06-03 22:18:35','hihi',2,'photo','KakaoTalk_20200514_162336503.png',NULL,NULL,NULL),(42,'이미지 테스트','이미지 테스트','2020-06-04 11:53:00','hihi',1,'photo','존잘_은석.png',NULL,NULL,NULL),(43,'덕덕','덕덕덕','2020-06-04 12:03:34','hihi',0,'photo','KakaoTalk_20200514_162336503.png',NULL,NULL,NULL),(44,'귀요미 덕','덕덕','2020-06-04 12:03:52','hihi',0,'photo','졸귀_독래.png',NULL,NULL,NULL),(45,'은서기','은서기 ㅎㅇ','2020-06-04 12:04:10','hihi',1,'photo','존잘_은석.png',NULL,NULL,NULL),(46,'안녕','안녕 ㅎㅇ','2020-06-04 12:04:36','hihi',0,'photo','졸귀_독래.png',NULL,NULL,NULL),(47,'구웃','구웃','2020-06-04 12:04:48','hihi',0,'photo','KakaoTalk_20200514_162336503.png',NULL,NULL,NULL),(48,'마지막 수정','수정 마지막','2020-06-04 12:05:00','hihi',11,'photo','졸귀_독래.png',NULL,NULL,NULL),(49,'곱창 먹구싶다','먹자먹자','2020-06-04 12:58:30','hihi',5,'photo','곱창.jpg',NULL,NULL,NULL),(77,'여긴 직원자료1','내용없음1','2020-06-05 16:21:03','hihi',0,'staff',NULL,NULL,NULL,NULL),(78,'여긴 직원자료2','내용없음2','2020-06-05 16:21:05','hi123',0,'staff',NULL,NULL,NULL,NULL),(79,'여긴 직원자료3','내용없음3','2020-06-05 16:21:07','hihi',1,'staff',NULL,NULL,NULL,NULL),(80,'여긴 직원자료4','내용없음4','2020-06-05 16:21:08','hi123',1,'staff',NULL,NULL,NULL,NULL),(82,'여긴 보호자자료1','내용없음1','2020-06-05 16:21:13','hihi',0,'bohoja',NULL,NULL,NULL,NULL),(83,'여긴 보호자자료2','내용없음2','2020-06-05 16:21:14','hi123',1,'bohoja',NULL,NULL,NULL,NULL),(84,'여긴 보호자자료3','내용없음3','2020-06-05 16:21:16','hihi',0,'bohoja',NULL,NULL,NULL,NULL),(85,'여긴 보호자자료4','내용없음4','2020-06-05 16:21:18','hi123',3,'bohoja',NULL,NULL,NULL,NULL),(86,'여긴 보호자자료5','수정 내용없음5','2020-06-05 16:21:20','hihi',8,'bohoja',NULL,NULL,NULL,'KakaoTalk_20200514_16233650321.png'),(90,'test 수정 수정 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','수정 수정 test','2020-06-07 20:31:29','hihi',9,'freeboard',NULL,NULL,NULL,NULL),(91,'test 수정','수정 test','2020-06-07 20:31:35','hihi',4,'notice',NULL,NULL,NULL,NULL),(92,'가즈아','응 안가 tt55 ㅎㅇ','2020-06-07 20:52:30','hihi',12,'photo','졸귀_독래.png',NULL,NULL,NULL),(93,'한번더','기기기','2020-06-07 20:53:21','hihi',9,'photo','곱창.jpg',NULL,NULL,NULL),(94,'test 수 go','test 수 go','2020-06-07 20:58:39','hihi',13,'info',NULL,'곱창.jpg','2020_06_07_23_2_25_362.jpg',NULL);
/*!40000 ALTER TABLE `multi_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_form`
--

DROP TABLE IF EXISTS `request_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_form` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `addr` varchar(100) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `cleanType` varchar(30) DEFAULT NULL,
  `cleanArea` varchar(30) DEFAULT NULL,
  `hopeDate` date NOT NULL,
  `regiType` varchar(30) DEFAULT NULL,
  `note` varchar(50) DEFAULT NULL,
  `regiDate` datetime DEFAULT current_timestamp(),
  `id` varchar(50) NOT NULL,
  `disorder` varchar(50) DEFAULT NULL,
  `disorderType` varchar(50) DEFAULT NULL,
  `bojanggu` varchar(50) DEFAULT NULL,
  `bojangguName` varchar(50) DEFAULT NULL,
  `adminTel` varchar(50) DEFAULT NULL,
  `cake` varchar(50) DEFAULT NULL,
  `cookie` varchar(50) DEFAULT NULL,
  `bname` varchar(50) NOT NULL,
  PRIMARY KEY (`num`),
  KEY `fk_request_form_membership` (`id`),
  CONSTRAINT `fk_request_form_membership` FOREIGN KEY (`id`) REFERENCES `membership` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_form`
--

LOCK TABLES `request_form` WRITE;
/*!40000 ALTER TABLE `request_form` DISABLE KEYS */;
INSERT INTO `request_form` VALUES (2,'apple','미국','02-2222-5555','010-9999-8888','apple@naver.com','분리수거','200평','2080-11-27','예약신청','없음','2020-06-06 18:19:17','hi123','','','','','','','',''),(3,'apple','미국','02-2222-5555','010-9999-8888','apple@naver.com','분리수거','200평','2080-11-27','예약신청','없음','2020-06-06 18:21:23','hi123','','','','','','','',''),(4,'apple','미국','02-2222-5555','010-9999-8888','apple@naver.com','분리수거','200평','2080-11-27','예약신청','없음','2020-06-06 18:21:24','hi123','','','','','','','',''),(5,'apple','미국','02-2222-5555','010-9999-8888','apple@naver.com','분리수거','200평','2080-11-27','예약신청','없음','2020-06-06 18:21:25','hi123','','','','','','','',''),(6,'apple','미국','02-2222-5555','010-9999-8888','apple@naver.com','분리수거','200평','2080-11-27','예약신청','없음','2020-06-06 18:21:26','hi123','','','','','','','',''),(7,'kosmo','월드메르디앙2차 403호','02-2222-3333','010-5555-6666','wjdtkdgur95@gmail.com','물청소','300평','2020-06-15','예약신청','없어요','2020-06-06 19:31:14','hi123','','','','','','','',''),(8,'kosmo','월드메르디앙2차 403호','010-8888-9999','010-5555-5555','wjdtkdgur95@gmail.com','물청소','100평','2020-05-26','예약신청','sadsada','2020-06-06 21:58:48','hi123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'clean'),(9,'kosmo',NULL,NULL,NULL,'wjdtkdgur95@gmail.com',NULL,NULL,'2020-06-22','예약신청','dsadsad','2020-06-06 22:05:47','hi123','유','sadsa','유','dsada','010-2222-2222','dsa','dsad','leaning'),(10,'kosmo',NULL,NULL,NULL,'wjdtkdgur95@gmail.com',NULL,NULL,'2020-06-22','예약신청','dsadsa','2020-06-06 22:07:32','hi123','유','dsad','유','asdsa','010-0000-0000','dsads','dsadas','leaning'),(11,'kosmo',NULL,NULL,NULL,'wjdtkdgur95@gmail.com',NULL,NULL,'2020-06-25','예약신청','없음','2020-06-06 22:13:56','hi123','유','없음','유','없음','010-8888-9999','참여','참여','leaning'),(12,'kosmo','월드메르디앙2차 403호','010-8888-9999','010-8888-8888','wjdtkdgur95@gmail.com','덕래청소','100평','2020-06-25','예약신청','sdsd','2020-06-06 22:18:42','hi123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'clean'),(13,'kosmo',NULL,NULL,NULL,'wjdtkdgur95@gmail.com',NULL,NULL,'2020-08-15','예약신청','하이','2020-06-06 22:34:04','hi123','유','','유','굳','010-8888-8888','참여','참여','leaning'),(14,'kosmo','월드메르디앙2차 403호','010-2222-2222','010-8888-9999','wjdtkdgur95@gmail.com','물청소','500평','2020-02-22','예약신청','하잉','2020-06-06 22:35:47','hi123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'clean'),(15,'kosmo',NULL,NULL,NULL,'wjdtkdgur95@gmail.com',NULL,NULL,'2020-06-25','예약신청','없음','2020-06-08 01:30:51','hihi','유','눈리신','유','윌슨','010-8888-9999','할래','안해','leaning'),(16,'kosmo',NULL,'010-2222-3333',NULL,'wjdtkdgur95@gmail.com',NULL,NULL,'2020-08-25','예약신청','x','2020-06-08 01:38:45','hihi','유','눈리신','유','마리아','010-5555-6666','안해','해','leaning'),(17,'kosmo','월드매르디앙2차 413호','010-9999-5555','010-8888-9999','wjdtkdgur95@gmail.com','사람제거','5000평','2020-06-25','예약신청','x','2020-06-08 01:41:39','hihi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'clean');
/*!40000 ALTER TABLE `request_form` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08  9:49:41
