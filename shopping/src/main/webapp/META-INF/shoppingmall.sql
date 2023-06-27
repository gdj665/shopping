-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.19-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- shoppingmall 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `shoppingmall` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `shoppingmall`;

-- 테이블 shoppingmall.address 구조 내보내기
CREATE TABLE IF NOT EXISTS `address` (
  `address_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `recently_use_date` datetime NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`address_no`),
  KEY `FK_address_id_list` (`id`),
  CONSTRAINT `FK_address_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='배송지 주소 테이블';

-- 테이블 데이터 shoppingmall.address:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;

-- 테이블 shoppingmall.answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `answer` (
  `a_no` int(11) NOT NULL AUTO_INCREMENT,
  `q_no` int(11) NOT NULL,
  `id` varchar(50) NOT NULL,
  `a_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`a_no`) USING BTREE,
  KEY `FK__member_answer` (`id`) USING BTREE,
  KEY `FK__inquiry` (`q_no`) USING BTREE,
  CONSTRAINT `FK_answer_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_answer_question` FOREIGN KEY (`q_no`) REFERENCES `question` (`q_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='문의 답변 테이블';

-- 테이블 데이터 shoppingmall.answer:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` (`a_no`, `q_no`, `id`, `a_content`, `createdate`, `updatedate`) VALUES
	(23, 16, 'admin', '뭐', '2023-06-20 14:31:50', '2023-06-20 14:31:50'),
	(24, 17, 'admin', '왜', '2023-06-20 14:31:53', '2023-06-20 14:31:53');
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;

-- 테이블 shoppingmall.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `product_no` int(11) NOT NULL,
  `cart_cnt` int(11) NOT NULL,
  `checked` enum('Y','N') NOT NULL DEFAULT 'Y',
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`cart_no`) USING BTREE,
  KEY `FK_bucket_member` (`id`) USING BTREE,
  KEY `FK_cart_product` (`product_no`),
  CONSTRAINT `FK_cart_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_cart_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='장바구니 테이블';

-- 테이블 데이터 shoppingmall.cart:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_no`, `id`, `product_no`, `cart_cnt`, `checked`, `createdate`, `updatedate`) VALUES
	(131, 'admin', 1, 1, 'Y', '2023-06-20 15:03:12', '2023-06-20 15:03:12'),
	(142, 'admin', 18, 1, 'Y', '2023-06-22 17:07:06', '2023-06-22 17:07:06');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

-- 테이블 shoppingmall.category 구조 내보내기
CREATE TABLE IF NOT EXISTS `category` (
  `category_no` int(11) NOT NULL AUTO_INCREMENT,
  `category_main_name` varchar(50) NOT NULL,
  `category_sub_name` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`category_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='제품분류(음반,앨범,노래종류 등등)';

-- 테이블 데이터 shoppingmall.category:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_no`, `category_main_name`, `category_sub_name`, `createdate`, `updatedate`) VALUES
	(1, '한국', '싱글', '2023-05-31 14:13:28', '2023-05-31 14:13:29'),
	(2, '한국', '정규', '2023-06-12 15:50:58', '2023-06-12 15:50:58'),
	(3, '일본', '싱글', '2023-06-12 15:51:05', '2023-06-12 15:51:06'),
	(4, '일본', '정규', '2023-06-12 15:51:17', '2023-06-12 15:51:17'),
	(5, '미국', '싱글', '2023-06-12 15:51:24', '2023-06-12 15:51:25'),
	(6, '미국', '정규', '2023-06-12 15:51:34', '2023-06-12 15:51:35'),
	(7, '한국', 'ep', '2023-06-12 15:51:43', '2023-06-12 15:51:44'),
	(8, '일본', 'ep', '2023-06-12 15:51:53', '2023-06-12 15:51:54'),
	(9, '미국', 'ep', '2023-06-12 15:52:01', '2023-06-12 15:52:01');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- 테이블 shoppingmall.customer 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer` (
  `id` varchar(50) NOT NULL,
  `cstm_name` varchar(50) NOT NULL,
  `cstm_address` varchar(50) NOT NULL,
  `cstm_email` varchar(50) NOT NULL,
  `cstm_birth` date NOT NULL,
  `cstm_gender` enum('M','F') NOT NULL,
  `cstm_rank` enum('Bronze','Silver','Gold') DEFAULT 'Bronze',
  `cstm_point` int(11) NOT NULL DEFAULT 0,
  `cstm_last_login` datetime NOT NULL,
  `cstm_phone` varchar(50) NOT NULL,
  `cstm_agree` enum('Y','N') NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `FK_customer_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='고객 관리 테이블';

-- 테이블 데이터 shoppingmall.customer:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` (`id`, `cstm_name`, `cstm_address`, `cstm_email`, `cstm_birth`, `cstm_gender`, `cstm_rank`, `cstm_point`, `cstm_last_login`, `cstm_phone`, `cstm_agree`, `createdate`, `updatedate`) VALUES
	('qwer', 'dlwotjd', '서울 노원구 수락산로 12,105동 1401호', 'sdlfj@alsdfjl', '2023-06-28', 'M', 'Bronze', 0, '2023-06-26 16:40:00', '01071099520', 'Y', '2023-06-23 12:13:43', '2023-06-23 12:13:43'),
	('test', 'user1', '서울', 'test@gmail.com', '2017-06-15', 'M', 'Gold', 734, '2023-06-24 20:28:39', '01012345678', 'Y', '2023-06-15 09:39:25', '2023-06-15 09:39:26'),
	('test1', 'wwww', '서울 동작구 양녕로 153-9,몰라', 'qwer@asff', '2023-06-08', 'M', 'Bronze', 0, '2023-06-23 12:28:37', '01015935764', 'Y', '2023-06-23 12:28:30', '2023-06-23 12:28:30'),
	('test2', 'user2', '대구', 'test2@naver.com', '2008-06-15', 'F', 'Bronze', 0, '2023-06-15 09:39:57', '01032062356', 'Y', '2023-06-15 09:39:58', '2023-06-15 09:39:59');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

-- 테이블 shoppingmall.discount 구조 내보내기
CREATE TABLE IF NOT EXISTS `discount` (
  `discount_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `discount_begin` date NOT NULL,
  `discount_end` date NOT NULL,
  `discount_rate` double NOT NULL DEFAULT 0,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`discount_no`) USING BTREE,
  KEY `FK_discount_product` (`product_no`),
  CONSTRAINT `FK_discount_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='상품 할인 관련 테이블';

-- 테이블 데이터 shoppingmall.discount:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` (`discount_no`, `product_no`, `discount_begin`, `discount_end`, `discount_rate`, `createdate`, `updatedate`) VALUES
	(2, 1, '2023-06-05', '2023-06-29', 0.2, '2023-06-15 17:28:47', '2023-06-15 17:28:47'),
	(3, 2, '2023-06-04', '2023-06-14', 0.22, '2023-06-15 17:29:04', '2023-06-15 17:29:04'),
	(4, 3, '2023-06-22', '2023-06-22', 0.22, '2023-06-22 14:20:56', '2023-06-22 14:20:56');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;

-- 테이블 shoppingmall.employees 구조 내보내기
CREATE TABLE IF NOT EXISTS `employees` (
  `id` varchar(50) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_level` int(11) NOT NULL COMMENT '1:조회,수정, 2:삭제,추가, 3:어드민관리',
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `FK_employees_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='사이트 관리자 테이블';

-- 테이블 데이터 shoppingmall.employees:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` (`id`, `emp_name`, `emp_level`, `createdate`, `updatedate`) VALUES
	('admin', 'admin', 2, '2023-06-15 09:36:44', '2023-06-15 09:36:45'),
	('admin2', 'admin2', 1, '2023-06-15 09:36:51', '2023-06-15 09:36:52');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;

-- 테이블 shoppingmall.id_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `id_list` (
  `id` varchar(50) NOT NULL,
  `last_pw` varchar(50) NOT NULL,
  `active` int(11) NOT NULL COMMENT '0.관리자 1:고객사용중 2:고객휴면 3.고객탈퇴',
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='기본적인 회원가입시에 저장되는 아이디 테이블';

-- 테이블 데이터 shoppingmall.id_list:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `id_list` DISABLE KEYS */;
INSERT INTO `id_list` (`id`, `last_pw`, `active`, `createdate`) VALUES
	('admin', '*A4B6157319038724E3560894F7F932C8886EBFCF', 1, '2023-05-31 12:46:00'),
	('admin2', '*A4B6157319038724E3560894F7F932C8886EBFCF', 1, '2023-06-15 09:34:21'),
	('qwer', '*A4B6157319038724E3560894F7F932C8886EBFCF', 1, '2023-06-23 12:13:43'),
	('test', '*A4B6157319038724E3560894F7F932C8886EBFCF', 1, '2023-05-30 14:16:48'),
	('test1', '*A4B6157319038724E3560894F7F932C8886EBFCF', 1, '2023-06-23 12:28:30'),
	('test2', '*A4B6157319038724E3560894F7F932C8886EBFCF', 1, '2023-06-07 17:07:07');
/*!40000 ALTER TABLE `id_list` ENABLE KEYS */;

-- 테이블 shoppingmall.one_answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `one_answer` (
  `oa_no` int(11) NOT NULL AUTO_INCREMENT,
  `oq_no` int(11) NOT NULL,
  `id` varchar(50) NOT NULL,
  `oa_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  `checked` int(11) NOT NULL,
  PRIMARY KEY (`oa_no`),
  KEY `FK_one_answer_one_question` (`oq_no`),
  CONSTRAINT `FK_one_answer_one_question` FOREIGN KEY (`oq_no`) REFERENCES `one_question` (`oq_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='1대1 문의 답변 테이블';

-- 테이블 데이터 shoppingmall.one_answer:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `one_answer` DISABLE KEYS */;
INSERT INTO `one_answer` (`oa_no`, `oq_no`, `id`, `oa_content`, `createdate`, `updatedate`, `checked`) VALUES
	(23, 11, 'admin', '123', '2023-06-22 17:31:06', '2023-06-22 17:31:06', 1);
/*!40000 ALTER TABLE `one_answer` ENABLE KEYS */;

-- 테이블 shoppingmall.one_question 구조 내보내기
CREATE TABLE IF NOT EXISTS `one_question` (
  `oq_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `oq_title` varchar(50) NOT NULL,
  `oq_content` text NOT NULL,
  `checked` enum('Y','N') NOT NULL DEFAULT 'N',
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`oq_no`),
  KEY `FK__id_list` (`id`),
  CONSTRAINT `FK__id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='기타1대1문의 테이블';

-- 테이블 데이터 shoppingmall.one_question:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `one_question` DISABLE KEYS */;
INSERT INTO `one_question` (`oq_no`, `id`, `oq_title`, `oq_content`, `checked`, `createdate`, `updatedate`) VALUES
	(11, 'test', '123', '123', 'Y', '2023-06-22 17:29:52', '2023-06-22 17:29:52');
/*!40000 ALTER TABLE `one_question` ENABLE KEYS */;

-- 테이블 shoppingmall.orders 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders` (
  `order_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `order_status` int(11) NOT NULL DEFAULT 0 COMMENT '0:결제미완료 1:결제완료 2:결제취소 3:배송중 4:구매확정',
  `order_price` int(11) NOT NULL,
  `order_point_use` int(11) NOT NULL DEFAULT 0,
  `address` varchar(50) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`order_no`),
  KEY `FK__member` (`id`) USING BTREE,
  CONSTRAINT `FK_orders_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='주문 테이블';

-- 테이블 데이터 shoppingmall.orders:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`order_no`, `id`, `order_status`, `order_price`, `order_point_use`, `address`, `createdate`, `updatedate`) VALUES
	(94, 'test', 2, 126000, 0, '서울', '2023-06-15 10:59:13', '2023-06-15 10:59:13'),
	(95, 'test', 2, 20000, 1260, '서울', '2023-06-15 11:32:33', '2023-06-15 11:32:33'),
	(96, 'test', 1, 139500, 0, '서울', '2023-06-23 09:51:03', '2023-06-23 09:51:03'),
	(97, 'test', 1, 52300, 3352, '서울', '2023-06-23 17:28:11', '2023-06-23 17:28:11');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- 테이블 shoppingmall.orders_cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders_cart` (
  `orders_cart_no` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL,
  `cart_no` int(11) NOT NULL,
  PRIMARY KEY (`orders_cart_no`),
  KEY `FK__orders` (`order_no`),
  KEY `FK__cart` (`cart_no`),
  CONSTRAINT `FK__cart` FOREIGN KEY (`cart_no`) REFERENCES `cart` (`cart_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK__orders` FOREIGN KEY (`order_no`) REFERENCES `orders` (`order_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='주문_장바구니 테이블';

-- 테이블 데이터 shoppingmall.orders_cart:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `orders_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_cart` ENABLE KEYS */;

-- 테이블 shoppingmall.orders_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders_history` (
  `orders_history_no` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL,
  `product_no` int(11) NOT NULL,
  `order_cnt` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`orders_history_no`),
  KEY `FK_order_history_orders` (`order_no`),
  KEY `FK_order_history_product` (`product_no`),
  CONSTRAINT `FK_order_history_orders` FOREIGN KEY (`order_no`) REFERENCES `orders` (`order_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order_history_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shoppingmall.orders_history:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `orders_history` DISABLE KEYS */;
INSERT INTO `orders_history` (`orders_history_no`, `order_no`, `product_no`, `order_cnt`, `createdate`) VALUES
	(101, 94, 1, 3, '2023-06-15 11:02:34'),
	(102, 94, 18, 2, '2023-06-15 11:02:34'),
	(103, 94, 11, 2, '2023-06-15 11:02:34'),
	(104, 94, 3, 1, '2023-06-15 11:02:34'),
	(105, 95, 3, 1, '2023-06-15 11:02:34'),
	(106, 96, 13, 31, '2023-06-23 09:51:05'),
	(107, 97, 25, 1, '2023-06-23 17:28:19'),
	(108, 97, 28, 1, '2023-06-23 17:28:19'),
	(109, 97, 30, 1, '2023-06-23 17:28:19');
/*!40000 ALTER TABLE `orders_history` ENABLE KEYS */;

-- 테이블 shoppingmall.point_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `point_history` (
  `point_no` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL,
  `point_pm` enum('+','-') NOT NULL,
  `point` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`point_no`) USING BTREE,
  KEY `FK_point_history_orders` (`order_no`),
  CONSTRAINT `FK_point_history_orders` FOREIGN KEY (`order_no`) REFERENCES `orders` (`order_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='쇼핑몰 포인트 증감 테이블';

-- 테이블 데이터 shoppingmall.point_history:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `point_history` DISABLE KEYS */;
INSERT INTO `point_history` (`point_no`, `order_no`, `point_pm`, `point`, `createdate`) VALUES
	(66, 94, '+', 1260, '2023-06-15 11:02:34'),
	(67, 94, '-', 0, '2023-06-15 11:02:34'),
	(68, 96, '+', 2092, '2023-06-23 09:51:05'),
	(69, 96, '-', 0, '2023-06-23 09:51:05'),
	(70, 97, '+', 734, '2023-06-23 17:28:19'),
	(71, 97, '-', 3352, '2023-06-23 17:28:19');
/*!40000 ALTER TABLE `point_history` ENABLE KEYS */;

-- 테이블 shoppingmall.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `product_no` int(11) NOT NULL AUTO_INCREMENT,
  `category_no` int(11) NOT NULL DEFAULT 0,
  `product_name` varchar(50) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_status` enum('1','2','3') NOT NULL DEFAULT '1' COMMENT '1_판매중, 2_품절 3_단종',
  `product_stock` int(11) NOT NULL,
  `product_info` text NOT NULL,
  `product_singer` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`product_no`),
  KEY `FK_product_category` (`category_no`) USING BTREE,
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_no`) REFERENCES `category` (`category_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='상품 정보 테이블';

-- 테이블 데이터 shoppingmall.product:~28 rows (대략적) 내보내기
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`product_no`, `category_no`, `product_name`, `product_price`, `product_status`, `product_stock`, `product_info`, `product_singer`, `createdate`, `updatedate`) VALUES
	(1, 3, '최애의아이', 1000, '1', 97, '최애의 아이 노래', '요아소비', '2023-05-31 14:14:34', '2023-05-31 14:14:35'),
	(2, 3, '칸나 커버곡', 2000, '1', 200, '아이리 칸나 노래', '아이리 칸나', '2023-05-31 14:15:09', '2023-05-31 14:15:10'),
	(3, 3, '유니 커버곡', 3000, '1', 299, '아야츠노 유니 노래', '아야츠노 유니', '2023-06-01 14:43:16', '2023-06-01 14:43:17'),
	(4, 1, '이세돌 1집', 4000, '1', 400, '이세계 아이돌 1집 노래', '이세계 아이돌', '2023-06-01 21:54:22', '2023-06-01 21:54:22'),
	(5, 2, '징버거 커버곡', 5000, '1', 500, '징버거 노래', '징버거', '2023-06-01 21:55:03', '2023-06-01 21:55:03'),
	(6, 2, '아이네 커버곡', 6000, '1', 150, '아이네 노래', '아이네', '2023-06-15 09:45:09', '2023-06-15 09:45:09'),
	(7, 2, '주르르 커버곡', 7000, '1', 200, '주르르 노래', '주르르', '2023-06-15 09:45:30', '2023-06-15 09:45:31'),
	(8, 2, '고세구 커버곡', 8000, '1', 250, '고세구 노래', '고세구', '2023-06-15 09:46:35', '2023-06-15 09:46:36'),
	(9, 2, '비챤 커버곡', 9000, '1', 300, '비챤 노래', '비챤', '2023-06-15 09:47:20', '2023-06-15 09:47:21'),
	(10, 2, '릴파 커버곡', 10000, '1', 350, '릴파 노래', '릴파', '2023-06-15 09:48:03', '2023-06-15 09:48:03'),
	(11, 4, '아이묭 노래 모음', 15000, '2', 498, '아이묭 노래 모음', '아이묭', '2023-06-15 09:50:00', '2023-06-22 14:39:42'),
	(12, 4, '요네즈 켄시 노래 모음', 20000, '1', 300, '요네즈 켄시 노래 모음', '요네즈 켄시', '2023-06-15 09:50:35', '2023-06-15 09:50:35'),
	(13, 1, '이세돌 2집', 4500, '1', 489, '이세계 아이돌 2집 노래', '이세계 아이돌', '2023-06-15 09:51:22', '2023-06-22 15:41:10'),
	(18, 4, '길티크라운', 45000, '1', 157, '길티크라운 OP, ED', 'Egoist', '2023-06-15 10:01:35', '2023-06-22 16:47:42'),
	(19, 3, '히게단 싱글', 12000, '1', 300, 'Pretender', '히게단', '2023-06-15 10:09:29', '2023-06-23 11:42:29'),
	(20, 3, '스즈메의 문단속', 30000, '3', 200, '스즈메의 문단속 OST', 'RADWIMPS', '2023-06-19 15:38:39', '2023-06-22 14:26:50'),
	(25, 6, 'CHARLIE', 22900, '1', 299, '멀티 플래티넘 히트메이커 Charlie Puth 세 번째 정규앨범 [CHARLIE] 발매!\r\n<br>\r\n<br>\r\n‘Light Switch’<br>\r\n‘That’s Hilarious’<br>\r\n‘Left and Right (Feat. Jung Kook of BTS)’<br>\r\n‘Smells Like Me’<br>\r\n‘I Don’t Think That I Like Her’등 수록!<br>\r\n<br>\r\n데뷔앨범 [Nine Track Mind]와 정규 2집 [Voicenotes]로 현재까지 많은 사랑을 받고 있는 멀티 플래티넘 싱어송라이터 겸 프로듀서 Charlie Puth가 정규 3집 [CHARLIE]를 공개한다.<br>\r\n자신의 이름을 내건 이번 앨범은 개인적으로 뜻깊은 앨범이 될 것이라고 시사해 온 바 있다. 선공개 싱글 ‘That’s Hilarious’와 방탄소년단 정국과 함께한 ‘Left and Right (Feat. Jung Kook of BTS)’가 현재 한국에서 폭발적인 사랑을 받고 있는 팝 트랙으로 손꼽히고 있다.\r\n', 'Charlie Puth', '2023-06-23 09:29:39', '2023-06-23 09:38:11'),
	(26, 6, 'Voicenotes', 20100, '1', 300, '초대형 신인의 지위를 넘어 전 세계가 사랑하는 팝 스타로 올라선 감각적인 싱어송라이터\r\nCharlie Puth 찰리 푸스 - Voicenotes<br>\r\n<br>\r\n재기 발랄한 송라이팅, 한층 성숙해진 목소리, 다채로운 장르 소화력이 만든 두 번째 챕터!<br>\r\n<br>\r\n빌보드 Top 5 싱글 \'Attention\', UK Top 10 싱글 \'How Long\' 포함, 아티스트의 다양한 매력을 만날 수 있는 13 트랙!<br>\r\n<br>\r\n켈라니(Kehlani), 보이즈 투 맨(Boyz ll Men), 제임스 테일러(James Taylor)로 완성된 화려한 피쳐링 라인업<br>\r\n<br>\r\n팔세토 보컬이 전하는 중독성 강한 선율 “Attention”<br>\r\n<br>\r\n감각적인 송라이팅이 낳은 유려한 선율 “How Long”<br>\r\n<br>\r\n레트로 사운드, 켈라니와의 콜래보레이션! “Done For Me (Feat. Kehlani)”<br>\r\n<br>\r\n성장한 찰리 푸스의 면모를 만날 수 있는 두 번째 정규앨범 <br>[Voicenotes]!', 'Charlie Puth', '2023-06-23 10:03:49', '2023-06-23 10:03:49'),
	(27, 6, 'BALLADS 1', 24800, '1', 3000, '다재다능 몽상가, 진화하는 아티스트 Joji의 데뷔앨범 [BALLADS 1]!<br>\r\n <br>\r\n1992년생, 26세. 다양한 이름으로 활동한 George Miller의 현재는 Joji라는 뮤지션이다. 그의 데뷔앨범 [BALLADS 1]은 변화라는 주제에 전념한 발라드 컬렉션. 그간의 솔로곡과 협업 싱글에서는 랩-싱 스타일을 추구했지만 새 앨범에서는 개인의 삶과 상상력을 토대로 한 다른 관점을 발라드라는 매개체로 조명하고 있다. 삶과 사랑, 그 사이의 모든 것을 둘러싼 현실의 이야기, 굉장히 내성적인 소리를 내는 12개의 트랙은 Clams Casino, Shlohmo, D33J, Trippie Redd와 같은 협력자를 만나 완벽하게 구현됐다. 트랩, 포크, 일렉트로니카, R&B를 버무린 모던 발라드 앨범.<br>', 'Joji', '2023-06-23 10:26:08', '2023-06-23 10:28:30'),
	(28, 5, 'Unhloy', 2000, '1', 2999, '더 이상 \'Stay with me\' 시절의 샘 스미스가 아니다. 그들은 1집 시절 만들어진 자신에 대한 고정관념을 과격히 깨부수길 원한다. 일렉트로닉 음악을 발표하는 등 파격 행보를 걷더니 이번엔 수위가 한층 높다. 사운드와 가사 양면에서 지금까지 발표한 곡들 중 가장 도발적이다. 어둡고 금속성 강한 소리를 사용했으며 불경함 속에서 환희를 느끼는 분위기를 연출했다. 가장 그들답지 않은 시도지만 뮤지션으로서의 만족도는 높았다고 한다. "가장 창의적인 시도를 한 곡이다. 정말 재미있게 만들었다"고 말했다. 미국 LA 선셋 스트립의 클럽 바디 샵에서 영감을 받아 만들었다고 한다. 가사에도 "바디 샵"이 등장한다.', 'Sam Smith, Kim Petras', '2023-06-23 10:34:44', '2023-06-23 10:34:44'),
	(29, 9, 'exiit', 24800, '1', 20, ' ', 'Kanii', '2023-06-23 10:39:44', '2023-06-23 10:39:44'),
	(30, 6, 'Gag Order', 27400, '1', 299, 'KESHA / GAG ORDER<br>\r\n<br>\r\n전세계 토탈 세일즈 1,400만장, 스트리밍 회수 약 70억회!<br>\r\n걸 크러쉬의 아이콘 Ke$ha(케샤)의 3년만의 새 앨범 [Gag Order]<br>\r\n릭 루빈이 프로듀서를 맡은 앨범으로 그녀의 사상, 그녀의 영혼의 내면을 나타내는 앨범이다.<br>\r\n\'Only Love Can Save Us Now\' , \'Fine Line\' , \'Eat The Acid\'등 총 13곡 수록.<br>\r\n<br>\r\n***미성년자 청취불가***', 'Kesha', '2023-06-23 10:43:30', '2023-06-23 10:43:30'),
	(31, 6, '- (Deluxe)', 26500, '1', 300, '세계적인 싱어송라이터 Ed Sheeran<br>\r\n마지막 수학 기호 앨범 [-] 발매<br>\r\n<br>\r\n세계적인 싱어송라이터 에드 시런 (Ed Sheeran)이 정규 앨범 [-] (Subtract)를 발매한다.<br>\r\n에드 시런은 새 앨범 [-]로 수학 기호 앨범의 여정을 마무리할 것임을 알렸다.<br>\r\n이번 앨범이 자신의 싱어송라이터의 뿌리를 되짚어 보는 앨범이자, 가장 개인적인 슬픔과 희망을 배경으로 쓰인 앨범이 될 것이라 전했으며, 앨범을 통해 에드 시런이 가진 가장 연약하고 솔직한 모습을 확인할 수 있을 것이다.', 'Ed Sheeran', '2023-06-23 10:50:07', '2023-06-23 10:50:07'),
	(32, 5, 'Life Goes On (feat. Luke Combs)', 3000, '1', 200, ' ', 'Ed Sheeran', '2023-06-23 10:54:49', '2023-06-23 10:54:49'),
	(33, 6, 'Unorthodox Jukebox', 16500, '1', 200, '《Unorthodox Jukebox》는 미국의 싱어송라이터 브루노 마스의 두 번째 스튜디오 음반이다. 2012년 12월 7일 애틀랜틱 레코드에 의해 발매되었다. 그것은 마스의 데뷔 음반인 《Doo-Wops & Hooligans》 의 후속작의 역할을 한다. 이 음반은 처음에 그의 이전 작품보다 더 "에너지 넘치게" 계획되었지만, 결국 레게 록, 디스코, 솔 음악과 같은 광범위한 스타일을 선보이게 되었다.<br>\r\n<br>\r\n마스는 이 음반 전체를 공동 작곡했고 몇몇 과거 협력자들과 함께 작업했으며, 새로운 프로듀서들과 게스트 보컬리스트를 영입하지 않았다. 서정적으로, 《Unorthodox Jukebox》는 그의 이전 소재보다 더 노골적인 가사와 주제를 통합하면서 관계에 대한 주제를 중심으로 전개된다. 2012년 12월 4일, 《Unorthodox Jukebox》는 발매 일주일 전부터 전곡을 들을 수 있게 되었다. 《Unorthodox Jukebox》에 대한 비판적인 반응은 대체로 호의적이었고, 많은 평론가들은 마스의 작품을 그의 이전 음반의 것과 비교했고, 다른 사람들은 가사가 얕다고 여겼다.<br>\r\n<br>\r\n첫 주 192,000장의 판매고를 올리며 미국 빌보드 200에서 2위로 데뷔했고, 이후 1위를 차지했다. 이 음반은 호주, 캐나다, 스위스, 영국에서도 1위에 올랐다. 이 음반은 2012년 마스에서 가장 빨리 팔린 음반이 되었고, 2013년 호주에서 세 번째로 많이 팔린 음반이 되었다. 국제 음반 산업 협회는 《Unorthodox Jukebox》가 2013년 세계적으로 4번째로 많이 팔린 음반으로 2016년 3월 기준으로 320만 장, 600만 장을 판매했다고 발표했다.\r\n《Unorthodox Jukebox》는 제56회 그래미 어워드에서 최우수 팝 보컬 앨범상을 수상했다. 이 음반의 시사회는 리드 싱글인 〈Locked Out of Heaven〉이 발표되어 전 세계적으로 상업적인 호평을 받으며 6주 연속 미국 빌보드 핫 100 노래 차트에서 1위를 차지하면서 시작되었다. 그 후, 2013년에 네 개의 싱글 이 출시되었고, 각각 미국에서 큰 성공을 거두며 중간 정도의 성공을 거두었다. 《Unorthodox Jukebox》는 The Moonshine Jungle Tour 를 통해 더욱 홍보되었다.', 'Bruno Mars', '2023-06-23 11:08:47', '2023-06-23 11:08:47'),
	(34, 5, 'Love\'s Train', 3000, '1', 200, ' ', 'Bruno Mars, Anderson .Paak, Silk Sonic', '2023-06-23 11:11:39', '2023-06-23 11:11:39'),
	(35, 5, 'Skate', 2500, '1', 30, ' ', 'Bruno Mars, Anderson .Paak, Silk Sonic', '2023-06-23 11:13:12', '2023-06-23 11:13:12'),
	(36, 6, 'An Evening With Silk Sonic', 23000, '1', 200, '80년대 모타운 사운드를 재현해낸<br>\r\nBruno Mars와 Anderson .Paak의 프로젝트 Silk Sonic<br>\r\n첫 정규 앨범 [An Evening With Silk Sonic]!<br>\r\n<br>\r\n2017년 Bruno Mars의 [24K Magic] 유럽 투어 오프닝을 맡았던 Anderson .Paak. 총합 15개의 그래미 수상에 빛나는 이 두 아티스트는 투어 도중 장난삼아 했던 연주 세션의 기억을 발판 삼아 다시 한번 스튜디오에 모였다. 하나의 아이디어는 또 다른 아이디어를 탄생시키며 결국 한 장의 온전한 앨범으로 성장했고, 동료 뮤지션인 Bootsy Collins의 의견에 따라 자신들의 프로젝트를 Silk Sonic으로 명명했다.<br>\r\n<br>\r\n이 프로젝트를 세상에 알린 첫 트랙 \'Leave The Door Open\'은 빌보드 싱글차트 1위를 차지하는 기록을 세웠고, 그래미와 BET 어워즈 등에서 보여준 독보적인 퍼포먼스는 전 세계 음악 팬들의 관심을 끌어모았다.<br>\r\n<br>\r\n이들의 첫 합작 앨범 [An Evening With Silk Sonic]은 선 공개된 트랙 \'Leave The Door Open\', \'Skate\', \'Smokin Out The Window\' 외에 \'Blast Off\' 등의 신곡이 추가된 총 9개의 트랙이 수록되어 있다.', 'Bruno Mars, Anderson .Paak, Silk Sonic', '2023-06-23 11:15:55', '2023-06-23 11:17:24');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- 테이블 shoppingmall.product_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_img` (
  `product_no` int(11) NOT NULL,
  `product_ori_filename` varchar(50) NOT NULL,
  `product_save_filename` varchar(50) NOT NULL,
  `product_filetype` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`product_no`),
  CONSTRAINT `FK_ product_img_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='제품 이미지 테이블';

-- 테이블 데이터 shoppingmall.product_img:~28 rows (대략적) 내보내기
/*!40000 ALTER TABLE `product_img` DISABLE KEYS */;
INSERT INTO `product_img` (`product_no`, `product_ori_filename`, `product_save_filename`, `product_filetype`, `createdate`, `updatedate`) VALUES
	(1, '최애의아이.jpg', '최애의아이.jpg', 'image/jpg', '2023-06-15 10:13:28', '2023-06-15 10:13:29'),
	(2, '아이리칸나.jpg', '아이리칸나.jpg', 'image/jpeg', '2023-06-15 10:23:06', '2023-06-15 10:23:07'),
	(3, '아야츠노유니.jpg', '아야츠노유니.jpg', 'image/jpeg', '2023-06-15 10:26:08', '2023-06-15 10:26:09'),
	(4, '이세계아이돌1.jpg', '이세계아이돌1.jpg', 'image/jpeg', '2023-06-15 10:30:12', '2023-06-15 10:30:12'),
	(5, '징버거.jpg', '징버거.jpg', 'image/jpeg', '2023-06-15 10:46:37', '2023-06-15 10:46:38'),
	(6, '아이네.jpg', '아이네.jpg', 'image/jpeg', '2023-06-15 10:46:21', '2023-06-15 10:46:21'),
	(7, '주르르.jpg', '주르르.jpg', 'image/jpeg', '2023-06-15 10:45:54', '2023-06-15 10:45:55'),
	(8, '고세구.jpg', '고세구.jpg', 'image/jpeg', '2023-06-15 10:45:26', '2023-06-15 10:45:27'),
	(9, '비챤.jpg', '비챤.jpg', 'image/jpeg', '2023-06-15 10:45:40', '2023-06-15 10:45:40'),
	(10, '릴파.jpg', '릴파.jpg', 'image/jpeg', '2023-06-15 10:46:08', '2023-06-15 10:46:08'),
	(11, '아이묭.jpg', '아이묭.jpg', 'image/jpeg', '2023-06-15 10:34:27', '2023-06-15 10:34:27'),
	(12, '요네즈켄시.jpg', '요네즈켄시.jpg', 'image/jpeg', '2023-06-15 10:36:50', '2023-06-15 10:36:51'),
	(13, '이세계아이돌2.jpg', '이세계아이돌2.jpg', 'image/jpeg', '2023-06-15 10:31:24', '2023-06-15 10:31:24'),
	(18, '길티크라운.jpg', '길티크라운4.jpg', 'image/jpeg', '2023-06-15 10:01:35', '2023-06-15 10:01:35'),
	(19, '히게단.jpg', '히게단.jpg', 'image/jpeg', '2023-06-15 10:09:29', '2023-06-23 11:42:29'),
	(20, 'suzume.jpg', 'suzume.jpg', 'image/jpeg', '2023-06-19 15:38:39', '2023-06-19 15:38:39'),
	(25, 'Charlie Puth - CHARLIE.jpg', 'Charlie Puth - CHARLIE1.jpg', 'image/jpeg', '2023-06-23 09:29:39', '2023-06-23 09:33:46'),
	(26, 'Charlie Puth - Voicenotes.jpg', 'Charlie Puth - Voicenotes.jpg', 'image/jpeg', '2023-06-23 10:03:49', '2023-06-23 10:03:49'),
	(27, 'Joji-BALLADS 1.jpg', 'Joji-BALLADS 1.jpg', 'image/jpeg', '2023-06-23 10:26:08', '2023-06-23 10:26:08'),
	(28, 'Sam Smith-unholy.jpg', 'Sam Smith-unholy.jpg', 'image/jpeg', '2023-06-23 10:34:44', '2023-06-23 10:34:44'),
	(29, 'Kanii-exiit.jpg', 'Kanii-exiit.jpg', 'image/jpeg', '2023-06-23 10:39:44', '2023-06-23 10:39:44'),
	(30, 'Kesha-Gag Order.jpg', 'Kesha-Gag Order.jpg', 'image/jpeg', '2023-06-23 10:43:30', '2023-06-23 10:43:30'),
	(31, 'Ed Sheeran-- (Deluxe).jpg', 'Ed Sheeran-- (Deluxe).jpg', 'image/jpeg', '2023-06-23 10:50:07', '2023-06-23 10:50:07'),
	(32, 'Ed Sheeran-Life Goes On (feat. Luke Combs).jpg', 'Ed Sheeran-Life Goes On (feat. Luke Combs).jpg', 'image/jpeg', '2023-06-23 10:54:49', '2023-06-23 10:54:49'),
	(33, 'Bruno Mars-Unorthodox Jukebox.jpg', 'Bruno Mars-Unorthodox Jukebox.jpg', 'image/jpeg', '2023-06-23 11:08:47', '2023-06-23 11:08:47'),
	(34, 'Bruno Mars-Love\'s Train.jpg', 'Bruno Mars-Love\'s Train.jpg', 'image/jpeg', '2023-06-23 11:11:39', '2023-06-23 11:11:39'),
	(35, 'Bruno Mars-Skate.jpg', 'Bruno Mars-Skate.jpg', 'image/jpeg', '2023-06-23 11:13:12', '2023-06-23 11:13:12'),
	(36, 'Bruno Mars-An Evening With Silk Sonic.jpg', 'Bruno Mars-An Evening With Silk Sonic.jpg', 'image/jpeg', '2023-06-23 11:15:55', '2023-06-23 11:15:55');
/*!40000 ALTER TABLE `product_img` ENABLE KEYS */;

-- 테이블 shoppingmall.product_track 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_track` (
  `product_track_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `track_no` int(11) NOT NULL,
  `track_title` varchar(500) DEFAULT NULL,
  `track_time` int(11) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`product_track_no`),
  KEY `FK_product_track_product` (`product_no`),
  CONSTRAINT `FK_product_track_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shoppingmall.product_track:~132 rows (대략적) 내보내기
/*!40000 ALTER TABLE `product_track` DISABLE KEYS */;
INSERT INTO `product_track` (`product_track_no`, `product_no`, `track_no`, `track_title`, `track_time`, `createdate`, `updatedate`) VALUES
	(30, 18, 1, 'My Dearest', 238, '2023-06-15 10:03:42', '2023-06-22 16:47:42'),
	(31, 18, 2, 'Departures: ~당신에게 보내는 사랑의 노래~', 249, '2023-06-15 10:03:42', '2023-06-22 16:47:42'),
	(32, 18, 3, 'The Everlasting Guilty Crown', 223, '2023-06-15 10:03:42', '2023-06-22 16:47:42'),
	(33, 18, 4, '고백/우리들의 발자취', 269, '2023-06-15 10:03:42', '2023-06-22 16:47:42'),
	(34, 19, 1, 'Pretender', 265, '2023-06-15 10:09:41', '2023-06-23 11:42:29'),
	(35, 1, 1, 'IDOL', 214, '2023-06-15 10:12:53', '2023-06-15 10:12:54'),
	(36, 2, 1, 'ADDICT!ON', 224, '2023-06-15 10:22:40', '2023-06-15 10:22:41'),
	(37, 3, 1, '긍지높은 아이돌', 236, '2023-06-15 10:25:45', '2023-06-15 10:25:46'),
	(38, 4, 1, 'RE : WIND', 210, '2023-06-15 10:29:31', '2023-06-15 10:29:32'),
	(39, 13, 1, '겨울봄', 192, '2023-06-15 10:31:49', '2023-06-22 15:41:10'),
	(40, 11, 1, '사랑을 전하고 싶다든가', 200, '2023-06-15 10:33:09', '2023-06-22 14:39:42'),
	(41, 11, 2, '마리골드', 198, '2023-06-15 10:33:22', '2023-06-22 14:39:42'),
	(42, 11, 3, '너는 록을 듣지 않아', 210, '2023-06-15 10:33:35', '2023-06-22 14:39:42'),
	(43, 12, 1, 'Lemon', 182, '2023-06-15 10:35:44', '2023-06-15 10:35:45'),
	(44, 12, 2, 'Kick back', 192, '2023-06-15 10:35:59', '2023-06-15 10:36:00'),
	(45, 12, 3, '피스 사인', 235, '2023-06-15 10:36:24', '2023-06-15 10:36:25'),
	(46, 9, 1, 'DAYBREAK FRONTLINE', 232, '2023-06-15 10:39:33', '2023-06-15 10:39:34'),
	(47, 9, 2, '사랑은 은하수 다방에서', 232, '2023-06-15 10:39:49', '2023-06-15 10:39:50'),
	(48, 9, 3, '로키', 210, '2023-06-15 10:40:19', '2023-06-15 10:40:20'),
	(49, 8, 1, '팬 서비스', 235, '2023-06-15 10:40:46', '2023-06-15 10:40:47'),
	(50, 8, 2, '긍지높은 아이돌', 221, '2023-06-15 10:40:59', '2023-06-15 10:40:59'),
	(51, 6, 1, '신호등', 232, '2023-06-15 10:41:13', '2023-06-15 10:41:13'),
	(52, 6, 2, 'Mash Up', 220, '2023-06-15 10:41:24', '2023-06-15 10:41:28'),
	(53, 6, 3, '부엉이', 210, '2023-06-15 10:41:39', '2023-06-15 10:41:39'),
	(54, 5, 1, 'Tom Boy', 192, '2023-06-15 10:41:58', '2023-06-15 10:41:58'),
	(55, 5, 2, '강풍올백', 220, '2023-06-15 10:42:16', '2023-06-15 10:42:18'),
	(56, 7, 1, '귀여워서 미안해', 210, '2023-06-15 10:42:45', '2023-06-15 10:42:46'),
	(57, 7, 2, 'SCIENTIST', 180, '2023-06-15 10:43:09', '2023-06-15 10:43:09'),
	(58, 10, 1, 'Promise', 222, '2023-06-15 10:43:49', '2023-06-15 10:43:50'),
	(59, 10, 2, '불꽃', 210, '2023-06-15 10:44:02', '2023-06-15 10:44:02'),
	(60, 10, 3, '마지막 재회', 240, '2023-06-15 10:44:16', '2023-06-15 10:44:17'),
	(67, 20, 1, 'suzume', 200, '2023-06-19 15:39:54', '2023-06-22 14:26:50'),
	(69, 25, 1, 'That\'s Hilarious', 145, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(70, 25, 2, 'Charlie Be Quiet!', 129, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(71, 25, 3, 'Light Switch', 188, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(72, 25, 4, 'There’s A First Time For Everything', 137, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(73, 25, 5, 'Smells Like Me', 205, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(74, 25, 6, 'Left and Right(feat. Jung Kook)', 155, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(75, 25, 7, 'Loser', 205, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(76, 25, 8, 'When You’re Sad I’m Sad', 175, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(77, 25, 9, 'Marks On My Neck', 139, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(78, 25, 10, 'Tears On My Piano', 182, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(79, 25, 11, 'I Don’t Think That I Like Her', 189, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(80, 25, 12, 'No More Drama', 141, '2023-06-23 09:32:26', '2023-06-23 09:38:11'),
	(81, 26, 1, 'The Way I Am', 187, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(82, 26, 2, 'Attention', 209, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(83, 26, 3, 'LA Girls', 198, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(84, 26, 4, 'How Long', 201, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(85, 26, 5, 'Done for Me(feat. Kehlani(켈라니))', 181, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(86, 26, 6, 'Patient', 191, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(87, 26, 7, 'If You Leave Me Now(feat. Boyz II Men(보이즈 투 맨))', 244, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(88, 26, 8, 'BOY', 264, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(89, 26, 9, 'Slow It Down', 191, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(90, 26, 10, 'Change(feat. James Taylor)', 218, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(91, 26, 11, 'Somebody Told Me', 217, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(92, 26, 12, 'Empty Cups', 171, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(93, 26, 13, 'Through It All', 207, '2023-06-23 10:07:22', '2023-06-23 10:07:22'),
	(94, 27, 1, 'ATTENTION', 129, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(95, 27, 2, 'SLOW DANCING IN THE DARK', 210, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(96, 27, 3, 'TEST DRIVE', 180, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(97, 27, 4, 'WANTED U', 252, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(98, 27, 5, 'CAN\'T GET OVER YOU (feat. Clams Casino)', 108, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(99, 27, 6, 'YEAH RIGHT', 175, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(100, 27, 7, 'WHY AM I STILL IN LA (feat. Shlohmo & D33J)', 200, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(101, 27, 8, 'NO FUN', 169, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(102, 27, 9, 'COME THRU', 154, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(103, 27, 10, 'R.I.P. (feat. Trippie Redd)', 159, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(104, 27, 11, 'XNXX', 148, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(105, 27, 12, 'I\'LL SEE YOU IN 40', 254, '2023-06-23 10:28:11', '2023-06-23 10:28:30'),
	(106, 28, 1, 'Unholy', 217, '2023-06-23 10:34:54', '2023-06-23 10:34:54'),
	(107, 29, 1, 'Five', 134, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(108, 29, 2, 'Heart Racing', 157, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(109, 29, 3, 'Invasion', 144, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(110, 29, 4, 'Plastic Heart', 167, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(111, 29, 5, 'I Know', 153, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(112, 29, 6, 'Clumsy Dancer', 197, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(113, 29, 7, 'I Know (PR1SVX Edit)', 134, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(114, 29, 8, 'Go (Xtayalive 2)', 107, '2023-06-23 10:41:08', '2023-06-23 10:41:08'),
	(115, 30, 1, 'Something To Believe In', 210, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(116, 30, 2, 'Eat The Acid', 243, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(117, 30, 3, 'Living In My Head', 187, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(118, 30, 4, 'Fine Line', 207, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(119, 30, 5, 'Only Love Can Save Us Now', 155, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(120, 30, 6, 'All I Need Is You', 182, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(121, 30, 7, 'The Drama', 264, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(122, 30, 8, 'Ram Dass Interlude', 75, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(123, 30, 9, 'Too Far Gone', 137, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(124, 30, 10, 'Peace & Quiet', 178, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(125, 30, 11, 'Only Love Reprise', 76, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(126, 30, 12, 'Hate Me Harder', 169, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(127, 30, 13, 'Happy', 263, '2023-06-23 10:45:19', '2023-06-23 10:45:19'),
	(128, 31, 1, 'Boat', 186, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(129, 31, 2, 'Salt Water', 240, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(130, 31, 3, 'Eyes Closed', 195, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(131, 31, 4, 'Life Goes On', 211, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(132, 31, 5, 'Dusty', 223, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(133, 31, 6, 'End Of Youth', 232, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(134, 31, 7, 'Colourblind', 210, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(135, 31, 8, 'Curtains', 225, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(136, 31, 9, 'Borderline', 238, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(137, 31, 10, 'Spark', 215, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(138, 31, 11, 'Vega', 179, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(139, 31, 12, 'Sycamore', 171, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(140, 31, 13, 'No Strings', 175, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(141, 31, 14, 'The Hills of Aberfeldy', 196, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(142, 31, 15, 'Wildflowers (Bonus Track)', 179, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(143, 31, 16, 'Stoned (Bonus Track)', 198, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(144, 31, 17, 'Toughest (Bonus Track)', 214, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(145, 31, 18, 'Moving (Bonus Track)', 216, '2023-06-23 10:52:54', '2023-06-23 10:52:54'),
	(146, 32, 1, 'Life Goes On (feat. Luke Combs)', 211, '2023-06-23 10:55:48', '2023-06-23 10:55:48'),
	(147, 33, 1, 'Young Girls', 229, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(148, 33, 2, 'Locked out of Heaven', 234, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(149, 33, 3, 'Gorilla', 245, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(150, 33, 4, 'Treasure', 179, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(151, 33, 5, 'Moonshine', 229, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(152, 33, 6, 'When I Was Your Man', 214, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(153, 33, 7, 'Natalie', 226, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(154, 33, 8, 'Show Me', 208, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(155, 33, 9, 'Money Make Her Smile', 204, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(156, 33, 10, 'If I Knew', 133, '2023-06-23 11:09:59', '2023-06-23 11:09:59'),
	(157, 34, 1, 'Love\'s Train', 308, '2023-06-23 11:12:07', '2023-06-23 11:12:07'),
	(158, 35, 1, 'Skate', 204, '2023-06-23 11:13:29', '2023-06-23 11:13:29'),
	(159, 36, 1, 'Silk Sonic Intro', 64, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(160, 36, 2, 'Leave The Door Open', 243, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(161, 36, 3, 'Fly As Me', 220, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(162, 36, 4, 'After Last Night (with Thundercat & Bootsy Collins)(feat. Thundercat, Bootsy Collins)', 250, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(163, 36, 5, 'Smokin Out The Window', 198, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(164, 36, 6, 'Put On A Smile', 256, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(165, 36, 7, '777', 166, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(166, 36, 8, 'Skate', 204, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(167, 36, 9, 'Love\'s Train', 308, '2023-06-23 11:17:12', '2023-06-23 11:17:24'),
	(168, 36, 10, 'Blast Off', 265, '2023-06-23 11:17:12', '2023-06-23 11:17:24');
/*!40000 ALTER TABLE `product_track` ENABLE KEYS */;

-- 테이블 shoppingmall.pw_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `pw_history` (
  `pw_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `pw` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`pw_no`) USING BTREE,
  KEY `FK_pw_record_id_list` (`id`),
  CONSTRAINT `FK_pw_record_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='비밀번호 이력 저장 테이블 최대 3개까지 저장';

-- 테이블 데이터 shoppingmall.pw_history:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pw_history` DISABLE KEYS */;
INSERT INTO `pw_history` (`pw_no`, `id`, `pw`, `createdate`) VALUES
	(4, 'qwer', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-06-23 12:13:43'),
	(5, 'test1', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-06-23 12:28:30');
/*!40000 ALTER TABLE `pw_history` ENABLE KEYS */;

-- 테이블 shoppingmall.question 구조 내보내기
CREATE TABLE IF NOT EXISTS `question` (
  `q_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `id` varchar(50) NOT NULL,
  `q_content` text NOT NULL,
  `checked` enum('Y','N') NOT NULL DEFAULT 'N',
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`q_no`) USING BTREE,
  KEY `FK__member_inquiry` (`id`) USING BTREE,
  KEY `FK_inquiry_product` (`product_no`),
  CONSTRAINT `FK_inquiry_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_inquiry_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='제품 문의 테이블';

-- 테이블 데이터 shoppingmall.question:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` (`q_no`, `product_no`, `id`, `q_content`, `checked`, `createdate`, `updatedate`) VALUES
	(16, 1, 'test', 'sdfsfsdf', 'Y', '2023-06-15 11:03:39', '2023-06-15 11:03:39'),
	(17, 1, 'test', '얌마', 'Y', '2023-06-20 14:31:18', '2023-06-20 14:31:18');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;

-- 테이블 shoppingmall.review 구조 내보내기
CREATE TABLE IF NOT EXISTS `review` (
  `review_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `product_no` int(11) NOT NULL,
  `review_title` varchar(50) NOT NULL,
  `review_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`review_no`),
  KEY `FK_review_id_list` (`id`),
  KEY `FK_review_product` (`product_no`),
  CONSTRAINT `FK_review_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_review_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='구매후기 테이블';

-- 테이블 데이터 shoppingmall.review:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` (`review_no`, `id`, `product_no`, `review_title`, `review_content`, `createdate`, `updatedate`) VALUES
	(4, 'test', 1, '졸잼', '개꿀잼', '2023-06-19 16:38:42', '2023-06-19 16:38:42'),
	(5, 'test', 1, '꿀잼띠', '앙 꿀잼띠', '2023-06-19 17:10:32', '2023-06-19 17:10:32'),
	(6, 'test', 1, '123', '123', '2023-06-19 17:11:30', '2023-06-19 17:11:30'),
	(7, 'test', 1, '123', '123123', '2023-06-19 17:12:43', '2023-06-19 17:12:43'),
	(17, 'test', 1, 'test', 'test', '2023-06-20 14:08:15', '2023-06-20 14:28:48'),
	(18, 'test', 13, '111', '111', '2023-06-23 09:54:07', '2023-06-23 10:00:24');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;

-- 테이블 shoppingmall.review_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `review_img` (
  `review_img_no` int(11) NOT NULL AUTO_INCREMENT,
  `review_no` int(11) NOT NULL,
  `review_ori_filename` varchar(50) NOT NULL,
  `review_save_filename` varchar(50) NOT NULL,
  `review_filetype` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`review_img_no`),
  KEY `FK_review_img_order` (`review_no`) USING BTREE,
  CONSTRAINT `FK_review_img_review` FOREIGN KEY (`review_no`) REFERENCES `review` (`review_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='후기 이미지 테이블';

-- 테이블 데이터 shoppingmall.review_img:~8 rows (대략적) 내보내기
/*!40000 ALTER TABLE `review_img` DISABLE KEYS */;
INSERT INTO `review_img` (`review_img_no`, `review_no`, `review_ori_filename`, `review_save_filename`, `review_filetype`, `createdate`, `updatedate`) VALUES
	(11, 17, 'suzume.jpg', 'suzume.jpg', 'image/jpeg', '2023-06-20 14:08:15', '2023-06-20 14:08:15'),
	(12, 17, 'sign.jpg', 'sign.jpg', 'image/jpeg', '2023-06-20 14:08:15', '2023-06-20 14:08:15'),
	(13, 17, 'sign_jimin.jpg', 'sign_jimin.jpg', 'image/jpeg', '2023-06-20 14:08:15', '2023-06-20 14:08:15'),
	(14, 17, 'sign_jin.jpg', 'sign_jin.jpg', 'image/jpeg', '2023-06-20 14:08:15', '2023-06-20 14:08:15'),
	(15, 17, 'sign_rm.jpg', 'sign_rm.jpg', 'image/jpeg', '2023-06-20 14:08:15', '2023-06-20 14:08:15'),
	(16, 17, 'rm.jpg', 'rm.jpg', 'image/jpeg', '2023-06-20 14:25:11', '2023-06-20 14:25:11'),
	(17, 18, 'Charlie Puth - Voicenotes.jpg', 'Charlie Puth - Voicenotes1.jpg', 'image/jpeg', '2023-06-23 09:55:22', '2023-06-23 09:55:22'),
	(18, 18, 'Charlie Puth - Voicenotes.jpg', 'Charlie Puth - Voicenotes2.jpg', 'image/jpeg', '2023-06-23 10:00:03', '2023-06-23 10:00:03');
/*!40000 ALTER TABLE `review_img` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
