/*
 Navicat Premium Data Transfer

 Source Server         : Local Dev
 Source Server Type    : MySQL
 Source Server Version : 100505
 Source Host           : localhost:3306
 Source Schema         : komunal_test

 Target Server Type    : MySQL
 Target Server Version : 100505
 File Encoding         : 65001

 Date: 24/10/2020 13:59:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for color
-- ----------------------------
DROP TABLE IF EXISTS `color`;
CREATE TABLE `color` (
  `id` char(6) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `idprev` char(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of color
-- ----------------------------
BEGIN;
INSERT INTO `color` VALUES ('X1Z76E', 'Silver', NULL);
INSERT INTO `color` VALUES ('X2P78J', 'Copper', 'X1Z76E');
INSERT INTO `color` VALUES ('X3H097', 'Iron', 'X2P78J');
INSERT INTO `color` VALUES ('Y1UH56', 'Gold', NULL);
INSERT INTO `color` VALUES ('Y2CRT3', 'Bronze', 'Y1UH56');
COMMIT;

-- ----------------------------
-- Table structure for holiday
-- ----------------------------
DROP TABLE IF EXISTS `holiday`;
CREATE TABLE `holiday` (
  `id` int(11) NOT NULL,
  `holiday_name` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of holiday
-- ----------------------------
BEGIN;
INSERT INTO `holiday` VALUES (1, 'Idul Fitri', '2020-11-03');
INSERT INTO `holiday` VALUES (2, 'Idul Fitri', '2020-11-04');
INSERT INTO `holiday` VALUES (3, 'Idul Fitri', '2020-11-09');
COMMIT;

-- ----------------------------
-- Procedure structure for findColorRelation
-- ----------------------------
DROP PROCEDURE IF EXISTS `findColorRelation`;
delimiter ;;
CREATE PROCEDURE `findColorRelation`(IN input_id CHAR(6))
BEGIN

	WITH RECURSIVE color_relation (id, color, idprev) as (
		SELECT a.* FROM color a
			WHERE id = input_id
		UNION ALL
		SELECT b.* FROM color b
			INNER JOIN color_relation on b.id = color_relation.idprev
	)
	
	SELECT * FROM color_relation
		ORDER BY color_relation.id ASC;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for findNextWorkingDay
-- ----------------------------
DROP PROCEDURE IF EXISTS `findNextWorkingDay`;
delimiter ;;
CREATE PROCEDURE `findNextWorkingDay`(IN datetime DATETIME,
	IN total_day INT,
	OUT nextWorkingDay DATETIME)
BEGIN

  DECLARE dayOfWeek INT DEFAULT 0;
	DECLARE holidayCount INT DEFAULT 0;
	
	SET max_sp_recursion_depth=255;
	
	SELECT DATE_ADD(datetime, INTERVAL 1 DAY) INTO nextWorkingDay;
	SELECT DAYOFWEEK(nextWorkingDay) INTO dayOfWeek;
	
	IF dayOfWeek = 7 THEN
		SELECT DATE_ADD(nextWorkingDay, INTERVAL 2 DAY) INTO nextWorkingDay;
	END IF;

	IF dayOfWeek = 1 THEN
		SELECT DATE_ADD(nextWorkingDay, INTERVAL 1 DAY) INTO nextWorkingDay;
	END IF;
	
	IF EXISTS(
		SELECT table_name 
    FROM INFORMATION_SCHEMA.TABLES
		WHERE table_name LIKE 'holiday'
	) THEN
		 SELECT count(*) from holiday where date = nextWorkingDay INTO holidayCount;
	END IF;
	
	IF (holidayCount = 0) THEN
		SET total_day = total_day - 1;
	END IF;
	
	IF (holidayCount > 0) OR (total_day > 0) THEN
		CALL findNextWorkingDay(nextWorkingDay, total_day, nextWorkingDay);
	END IF;
	
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
