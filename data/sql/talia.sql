/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : talia

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2015-05-22 17:18:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `scope_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES ('1', 'test', 'test', 'test', 'test@test.com', '1');

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `level` int(11) NOT NULL,
  `experience` bigint(20) NOT NULL,
  `breed_id` int(11) NOT NULL,
  `gender` int(11) NOT NULL,
  `kamas` int(11) NOT NULL,
  `map_id` int(11) NOT NULL,
  `cell_id` int(11) NOT NULL,
  `orientation_id` int(11) NOT NULL,
  `color_1` varchar(255) NOT NULL,
  `color_2` varchar(255) NOT NULL,
  `color_3` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of characters
-- ----------------------------
INSERT INTO `characters` VALUES ('1', '1', 'Nightwolf', '1', '0', '1', '0', '0', '10354', '255', '1', '0', '0', '0');
INSERT INTO `characters` VALUES ('2', '1', 'Lightwolf', '1', '0', '1', '0', '0', '10354', '255', '1', '0', '0', '0');
