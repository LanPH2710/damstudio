-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: damstudio
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `roleId` int DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `accountStatus` int DEFAULT '1',
  `money` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userName` (`userName`),
  UNIQUE KEY `email` (`email`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'admin_user','password123','Vũ','Trịnh','admin@example.com','0327066228',0,1,'img_testing.jpg',1,0.00),(2,'marketing_user1','password123','Vũ','Trịnh Văn','marketing1@example.com','0327066225',0,2,'img_testing.jpg',1,0.00),(3,'marketing_user2','password123','Staff2','Marketing','marketing2@example.com','0123456781',0,2,'img_testing.jpg',1,0.00),(4,'sales_user1','password123','Staff1','Sales','sales1@example.com','0123456782',1,3,'img_testing.jpg',1,0.00),(5,'sales_user2','password123','Staff2','Sales','sales2@example.com','0123456783',0,3,'img_testing.jpg',1,0.00),(6,'customer_user1','password123','One','Customer','customer1@example.com','0123456784',1,4,'img_testing.jpg',1,0.00),(7,'customer_user2','password123','Two','Customer','customer2@example.com','0123456785',0,4,'img_testing.jpg',1,0.00),(8,'shipper_user1','password123','One','Shipper','shipper5@example.com','14254325234523',0,5,'img_testing.jpg',1,0.00);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addressuser`
--

DROP TABLE IF EXISTS `addressuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressuser` (
  `userId` int DEFAULT NULL,
  `addressId` int NOT NULL AUTO_INCREMENT,
  `province` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `ward` varchar(100) DEFAULT NULL,
  `addressDetail` varchar(200) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`addressId`),
  KEY `userId` (`userId`),
  CONSTRAINT `addressuser_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `account` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressuser`
--

LOCK TABLES `addressuser` WRITE;
/*!40000 ALTER TABLE `addressuser` DISABLE KEYS */;
INSERT INTO `addressuser` VALUES (1,1,'Hà Nội','Ba Đình','Trúc Bạch','Số 390','Trịnh Vũ','admin@example.com','0327066228'),(2,2,'Hà Nội','Đống Đa','Láng Hạ','Số 123','Trịnh Văn Vũ','marketing1@example.com','0327066225'),(3,3,'Hà Nội','Cầu Giấy','Dịch Vọng','Số 45','Marketing Staff2','marketing2@example.com','0123456781'),(4,4,'Hồ Chí Minh','Quận 1','Bến Nghé','12 Nguyễn Huệ','Sales Staff1','sales1@example.com','0123456782'),(5,5,'Hồ Chí Minh','Quận 3','Phường 7','56 Võ Văn Tần','Sales Staff2','sales2@example.com','0123456783'),(6,6,'Đà Nẵng','Hải Châu','Thạch Thang','89 Bạch Đằng','Customer One','customer1@example.com','0123456784'),(7,7,'Đà Nẵng','Thanh Khê','An Khê','77 Điện Biên Phủ','Customer Two','customer2@example.com','0123456785'),(8,8,'Cần Thơ','Ninh Kiều','An Cư','22 Trần Hưng Đạo','Shipper One','shipper5@example.com','14254325234523');
/*!40000 ALTER TABLE `addressuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `brandId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `brandStatus` int DEFAULT '1',
  PRIMARY KEY (`brandId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Sự tích',1),(2,'Truyền thuyết',1);
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cartId` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `productId` varchar(6) DEFAULT NULL,
  `sizeId` int DEFAULT NULL,
  `colorId` int DEFAULT NULL,
  `cartQuantity` int DEFAULT '1',
  PRIMARY KEY (`cartId`),
  KEY `userId` (`userId`),
  KEY `productId` (`productId`),
  KEY `sizeId` (`sizeId`),
  KEY `colorId` (`colorId`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `account` (`userId`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `cart_ibfk_3` FOREIGN KEY (`sizeId`) REFERENCES `size` (`sizeId`),
  CONSTRAINT `cart_ibfk_4` FOREIGN KEY (`colorId`) REFERENCES `color` (`colorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color`
--

DROP TABLE IF EXISTS `color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color` (
  `colorId` int NOT NULL AUTO_INCREMENT,
  `colorName` varchar(50) NOT NULL,
  `colorStatus` int DEFAULT '1',
  PRIMARY KEY (`colorId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color`
--

LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */;
INSERT INTO `color` VALUES (1,'Đen',1),(2,'Trắng',0);
/*!40000 ALTER TABLE `color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_product`
--

DROP TABLE IF EXISTS `detail_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail_product` (
  `productId` varchar(6) NOT NULL,
  `sizeId` int NOT NULL,
  `colorId` int NOT NULL,
  `imageId` int DEFAULT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`productId`,`sizeId`,`colorId`),
  KEY `sizeId` (`sizeId`),
  KEY `colorId` (`colorId`),
  KEY `imageId` (`imageId`),
  CONSTRAINT `detail_product_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `detail_product_ibfk_2` FOREIGN KEY (`sizeId`) REFERENCES `size` (`sizeId`),
  CONSTRAINT `detail_product_ibfk_3` FOREIGN KEY (`colorId`) REFERENCES `color` (`colorId`),
  CONSTRAINT `detail_product_ibfk_4` FOREIGN KEY (`imageId`) REFERENCES `productimage` (`imageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_product`
--

LOCK TABLES `detail_product` WRITE;
/*!40000 ALTER TABLE `detail_product` DISABLE KEYS */;
INSERT INTO `detail_product` VALUES ('ST0001',1,1,1,10),('ST0001',1,2,1,10),('ST0001',2,1,1,10),('ST0001',2,2,1,10),('ST0001',3,1,1,10),('ST0001',3,2,1,10),('ST0001',4,1,1,10),('ST0001',4,2,1,10),('ST0001',5,1,1,10),('ST0001',5,2,1,10),('ST0001',6,1,1,10),('ST0001',6,2,1,10),('TT0001',1,1,1,10),('TT0001',1,2,1,10),('TT0001',2,1,1,10),('TT0001',2,2,1,10),('TT0001',3,1,1,10),('TT0001',3,2,1,10),('TT0001',4,1,1,10),('TT0001',4,2,1,10),('TT0001',5,1,1,10),('TT0001',5,2,1,10),('TT0001',6,1,1,10),('TT0001',6,2,1,10);
/*!40000 ALTER TABLE `detail_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_product`
--

DROP TABLE IF EXISTS `favorite_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite_product` (
  `userId` int NOT NULL,
  `productId` varchar(6) NOT NULL,
  PRIMARY KEY (`userId`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `favorite_product_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `account` (`userId`),
  CONSTRAINT `favorite_product_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_product`
--

LOCK TABLES `favorite_product` WRITE;
/*!40000 ALTER TABLE `favorite_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedbackId` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `productId` varchar(6) DEFAULT NULL,
  `feedbackInfo` text,
  `feedbackTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `feedbackImg` varchar(500) DEFAULT NULL,
  `feedbackRate` int DEFAULT NULL,
  `status` int DEFAULT '1',
  PRIMARY KEY (`feedbackId`),
  KEY `userId` (`userId`),
  KEY `productId` (`productId`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `account` (`userId`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,2,'ST0001','Sản phẩm tốt, chất lượng vượt mong đợi.','2025-06-10 10:30:00','img_testing.jpg',5,1),(2,3,'ST0001','Màu sắc đẹp, mặc vừa vặn.','2025-06-11 12:00:00',NULL,4,1),(3,5,'TT0001','Chất vải mềm mịn, giá hợp lý.','2025-06-12 09:45:00',NULL,5,1),(4,6,'TT0001','Không giống ảnh, hơi thất vọng.','2025-06-12 14:15:00',NULL,2,1),(5,4,'ST0001','Giao hàng nhanh, đóng gói cẩn thận.','2025-06-13 08:20:00',NULL,4,1),(6,5,'ST0001','Form áo đẹp, nhưng chất vải mỏng.','2025-06-13 13:00:00',NULL,3,1),(7,7,'TT0001','Thiết kế sáng tạo, đáng tiền.','2025-06-14 11:30:00',NULL,5,1),(8,7,'TT0001','Chất lượng ổn, sẽ ủng hộ tiếp.','2025-06-14 15:00:00',NULL,4,1);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `orderDeliverCode` varchar(10) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `orderName` varchar(255) DEFAULT NULL,
  `orderEmail` varchar(255) DEFAULT NULL,
  `orderPhone` varchar(20) DEFAULT NULL,
  `totalPrice` decimal(15,2) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `orderStatus` int DEFAULT NULL,
  `payMethod` int DEFAULT NULL,
  `voucherId` int DEFAULT NULL,
  `shipId` int DEFAULT NULL,
  `createDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `shippingAddress` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `userId` (`userId`),
  KEY `orderStatus` (`orderStatus`),
  KEY `voucherId` (`voucherId`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `account` (`userId`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`orderStatus`) REFERENCES `orderstatus` (`statusId`),
  CONSTRAINT `order_ibfk_3` FOREIGN KEY (`voucherId`) REFERENCES `voucher` (`voucherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetail`
--

DROP TABLE IF EXISTS `orderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetail` (
  `orderDetailId` int NOT NULL AUTO_INCREMENT,
  `orderId` int DEFAULT NULL,
  `productId` varchar(6) DEFAULT NULL,
  `sizeId` int DEFAULT NULL,
  `colorId` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `isFeedback` int DEFAULT NULL,
  PRIMARY KEY (`orderDetailId`),
  KEY `orderId` (`orderId`),
  KEY `productId` (`productId`),
  KEY `sizeId` (`sizeId`),
  KEY `colorId` (`colorId`),
  CONSTRAINT `orderdetail_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `order` (`orderId`),
  CONSTRAINT `orderdetail_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `orderdetail_ibfk_3` FOREIGN KEY (`sizeId`) REFERENCES `size` (`sizeId`),
  CONSTRAINT `orderdetail_ibfk_4` FOREIGN KEY (`colorId`) REFERENCES `color` (`colorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetail`
--

LOCK TABLES `orderdetail` WRITE;
/*!40000 ALTER TABLE `orderdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderstatus`
--

DROP TABLE IF EXISTS `orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderstatus` (
  `statusId` int NOT NULL AUTO_INCREMENT,
  `statusName` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`statusId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderstatus`
--

LOCK TABLES `orderstatus` WRITE;
/*!40000 ALTER TABLE `orderstatus` DISABLE KEYS */;
INSERT INTO `orderstatus` VALUES (1,'Pending','Đơn hàng đang chờ xử lý'),(2,'Confirmed','Đơn hàng đã được xác nhận'),(3,'Shipped','Đơn hàng đã được giao đi'),(4,'Delivered','Đơn hàng đã được giao đến tay khách hàng'),(5,'Cancelled','Đơn hàng đã bị huỷ'),(6,'On Hold','Đơn hàng đang bị tạm hoãn');
/*!40000 ALTER TABLE `orderstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productId` varchar(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `description` text,
  `VAT` decimal(5,2) DEFAULT '0.00',
  `brandId` int DEFAULT NULL,
  `styleId` int DEFAULT NULL,
  `productStatus` int DEFAULT '1',
  PRIMARY KEY (`productId`),
  KEY `brandId` (`brandId`),
  KEY `styleId` (`styleId`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`brandId`) REFERENCES `brand` (`brandId`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`styleId`) REFERENCES `style` (`styleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('ST0001','Áo Sự tích Hồ Gươm',200000.00,'Nổi bật với hình in lấy cảm hứng từ truyền thuyết Hồ Gươm, chiếc áo được làm từ chất liệu cotton 100% mềm mại, thoáng mát, giúp người mặc cảm thấy dễ chịu trong mọi hoạt động. Thiết kế đơn giản, dễ phối với nhiều phong cách khác nhau, phù hợp để mặc hằng ngày hoặc đi chơi.',0.00,2,1,1),('TT0001','Áo Sơn Tinh Thủy Tinh',200000.00,'Áo thun in họa tiết Sơn Tinh – Thủy Tinh độc đáo, mang đậm màu sắc văn hóa Việt Nam. Chất liệu cotton cao cấp 100%, thấm hút mồ hôi tốt và giữ form áo bền đẹp sau nhiều lần giặt. Phù hợp cho cả nam và nữ, dễ dàng phối cùng quần jeans hoặc chân váy cho phong cách năng động, hiện đại.',0.00,1,1,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productimage`
--

DROP TABLE IF EXISTS `productimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productimage` (
  `imageId` int NOT NULL AUTO_INCREMENT,
  `imageUrl` varchar(1000) NOT NULL,
  PRIMARY KEY (`imageId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productimage`
--

LOCK TABLES `productimage` WRITE;
/*!40000 ALTER TABLE `productimage` DISABLE KEYS */;
INSERT INTO `productimage` VALUES (1,'avatar-trang-4.jpg');
/*!40000 ALTER TABLE `productimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `roleId` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) NOT NULL,
  `roleStatus` int DEFAULT '1',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'admin',1),(2,'marketing',1),(3,'sale',1),(4,'customer',1),(5,'shipper',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `size` (
  `sizeId` int NOT NULL AUTO_INCREMENT,
  `sizeName` varchar(25) NOT NULL,
  `heightMin` int DEFAULT NULL,
  `heightMax` int DEFAULT NULL,
  `weightMin` int DEFAULT NULL,
  `weightMax` int DEFAULT NULL,
  `sizeStatus` int DEFAULT '1',
  PRIMARY KEY (`sizeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size`
--

LOCK TABLES `size` WRITE;
/*!40000 ALTER TABLE `size` DISABLE KEYS */;
INSERT INTO `size` VALUES (1,'S',158,165,48,55,1),(2,'M',160,170,60,68,1),(3,'L',165,175,65,75,1),(4,'XL',170,180,75,85,1),(5,'XXL',175,185,85,95,1),(6,'XXXL',180,190,85,95,1);
/*!40000 ALTER TABLE `size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `style`
--

DROP TABLE IF EXISTS `style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `style` (
  `styleId` int NOT NULL AUTO_INCREMENT,
  `styleName` varchar(255) NOT NULL,
  `styleStatus` int DEFAULT '1',
  PRIMARY KEY (`styleId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `style`
--

LOCK TABLES `style` WRITE;
/*!40000 ALTER TABLE `style` DISABLE KEYS */;
INSERT INTO `style` VALUES (1,'T-Shirt',1);
/*!40000 ALTER TABLE `style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_voucher`
--

DROP TABLE IF EXISTS `user_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_voucher` (
  `userId` int NOT NULL,
  `voucherId` int NOT NULL,
  `isUsed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`userId`,`voucherId`),
  KEY `voucherId` (`voucherId`),
  CONSTRAINT `user_voucher_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `account` (`userId`),
  CONSTRAINT `user_voucher_ibfk_2` FOREIGN KEY (`voucherId`) REFERENCES `voucher` (`voucherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_voucher`
--

LOCK TABLES `user_voucher` WRITE;
/*!40000 ALTER TABLE `user_voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher` (
  `voucherId` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discountType` enum('percent','amount') DEFAULT 'percent',
  `discountValue` decimal(10,2) DEFAULT NULL,
  `minOrderValue` decimal(10,2) DEFAULT NULL,
  `maxDiscountValue` decimal(10,2) DEFAULT NULL,
  `totalQuantity` int DEFAULT NULL,
  `usedQuantity` int DEFAULT '0',
  `isActive` tinyint(1) DEFAULT '1',
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  PRIMARY KEY (`voucherId`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (1,'HEHEHE10','Giảm 10% cho đơn từ 200k','percent',10.00,200000.00,50000.00,100,0,1,'2025-06-01 00:00:00','2025-06-30 00:00:00'),(2,'FREESHIP50','Giảm 50k cho đơn từ 300k','amount',50000.00,300000.00,50000.00,200,0,1,'2025-06-01 00:00:00','2025-06-20 00:00:00');
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-12 10:55:11
