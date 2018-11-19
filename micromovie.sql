/*
Navicat MySQL Data Transfer

Source Server         : em
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : movie

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2018-11-19 16:48:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `is_super` smallint(6) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `role_id` (`role_id`),
  KEY `ix_admin_addtime` (`addtime`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', 'pbkdf2:sha256:50000$MiqsiHpN$3860cf54927298096247aa60f1ef5c6f3447f0034319d49b22ae37c7d9cc9dd0', '0', '1', '2018-11-14 00:25:58');
INSERT INTO `admin` VALUES ('2', 'eminjan', 'pbkdf2:sha256:50000$yijVTYvS$3683605cebfb005a5afb84e5ab941b29b3301f8529fdb427c66f944f8396349a', '0', '1', '2018-11-16 11:05:37');
INSERT INTO `admin` VALUES ('3', 'admin2', 'pbkdf2:sha256:50000$QZO9dsIq$d03c18448e8c56c77a220bb689538b40ebf6d55806cba3dc6efa8343ff941984', '1', '1', '2018-11-17 00:33:19');

-- ----------------------------
-- Table structure for adminlog
-- ----------------------------
DROP TABLE IF EXISTS `adminlog`;
CREATE TABLE `adminlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_adminlog_addtime` (`addtime`),
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES ('1', '1', '127.0.0.1', '2018-11-14 11:08:46');
INSERT INTO `adminlog` VALUES ('2', '2', '127.0.0.1', '2018-11-16 14:05:04');
INSERT INTO `adminlog` VALUES ('3', '2', '127.0.0.1', '2018-11-16 14:05:09');
INSERT INTO `adminlog` VALUES ('4', '2', '127.0.0.1', '2018-11-16 14:05:12');
INSERT INTO `adminlog` VALUES ('5', '2', '127.0.0.1', '2018-11-16 14:05:16');
INSERT INTO `adminlog` VALUES ('6', '2', '127.0.0.1', '2018-11-16 14:05:23');
INSERT INTO `adminlog` VALUES ('7', '2', '127.0.0.1', '2018-11-16 14:05:27');
INSERT INTO `adminlog` VALUES ('8', '2', '127.0.0.1', '2018-11-16 14:05:30');
INSERT INTO `adminlog` VALUES ('9', '2', '127.0.0.1', '2018-11-16 14:05:34');
INSERT INTO `adminlog` VALUES ('10', '2', '127.0.0.1', '2018-11-16 14:05:38');
INSERT INTO `adminlog` VALUES ('11', '2', '127.0.0.1', '2018-11-16 14:05:41');
INSERT INTO `adminlog` VALUES ('12', '2', '127.0.0.1', '2018-11-16 14:05:45');
INSERT INTO `adminlog` VALUES ('13', '2', '127.0.0.1', '2018-11-16 14:05:49');
INSERT INTO `adminlog` VALUES ('14', '2', '127.0.0.1', '2018-11-17 14:52:33');
INSERT INTO `adminlog` VALUES ('15', '2', '127.0.0.1', '2018-11-17 14:54:11');
INSERT INTO `adminlog` VALUES ('16', '2', '127.0.0.1', '2018-11-17 15:13:27');
INSERT INTO `adminlog` VALUES ('17', '2', '127.0.0.1', '2018-11-18 21:31:51');
INSERT INTO `adminlog` VALUES ('18', '2', '127.0.0.1', '2018-11-19 10:34:50');
INSERT INTO `adminlog` VALUES ('19', '2', '127.0.0.1', '2018-11-19 10:34:53');
INSERT INTO `adminlog` VALUES ('20', '2', '127.0.0.1', '2018-11-19 16:29:34');
INSERT INTO `adminlog` VALUES ('21', '2', '127.0.0.1', '2018-11-19 16:30:48');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`),
  KEY `ix_auth_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES ('1', '添加标签', '/admin/tag/add/', '2018-11-16 15:13:21');
INSERT INTO `auth` VALUES ('2', '编辑标签', '/admin/tag/edit/<int:id>/', '2018-11-16 15:14:07');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_comment_addtime` (`addtime`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('10', '好看', '3', '1', '2018-11-16 00:35:31');
INSERT INTO `comment` VALUES ('11', '不错', '4', '2', '2018-11-16 00:35:46');
INSERT INTO `comment` VALUES ('12', '无奈', '3', '1', '2018-11-16 00:35:46');
INSERT INTO `comment` VALUES ('13', '难看', '3', '2', '2018-11-16 00:35:46');
INSERT INTO `comment` VALUES ('15', '给力', '3', '2', '2018-11-16 00:35:47');
INSERT INTO `comment` VALUES ('16', '无感', '3', '1', '2018-11-16 00:35:47');
INSERT INTO `comment` VALUES ('17', '乏味', '4', '2', '2018-11-16 00:35:47');
INSERT INTO `comment` VALUES ('18', '<p>好看</p>', '3', '3', '2018-11-19 15:12:22');

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `info` text,
  `logo` varchar(255) DEFAULT NULL,
  `star` smallint(6) DEFAULT NULL,
  `playnum` bigint(20) DEFAULT NULL,
  `commentnum` bigint(20) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `release_time` date DEFAULT NULL,
  `length` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `url` (`url`),
  UNIQUE KEY `logo` (`logo`),
  KEY `tag_id` (`tag_id`),
  KEY `ix_movie_addtime` (`addtime`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES ('3', '变形金刚3', '20181115102117335d12d74fa04a239a455e1492aca8be.mp4', '变形金刚3', '20181115102117f078ae1d537c40baa7f855ce215b1459.png', '3', '21', '1', '1', '美国', '2016-08-05', '1', '2018-11-15 10:21:17');
INSERT INTO `movie` VALUES ('4', '金刚狼3', '20181115110429eb02dc5457724df69d1fa3b2d449a58a.mp4', '金刚狼3', '201811151104294e8bd908690e4a478ebdde10a7ed683b.png', '2', '1', '0', '2', '日本', '2016-08-20', '2', '2018-11-15 11:00:26');

-- ----------------------------
-- Table structure for moviecol
-- ----------------------------
DROP TABLE IF EXISTS `moviecol`;
CREATE TABLE `moviecol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_moviecol_addtime` (`addtime`),
  CONSTRAINT `moviecol_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `moviecol_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of moviecol
-- ----------------------------
INSERT INTO `moviecol` VALUES ('1', '3', '1', '2018-11-16 10:00:56');
INSERT INTO `moviecol` VALUES ('2', '4', '1', '2018-11-16 10:00:56');
INSERT INTO `moviecol` VALUES ('3', '3', '2', '2018-11-16 10:00:56');
INSERT INTO `moviecol` VALUES ('5', '3', '3', '2018-11-19 15:11:43');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `reason` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_oplog_addtime` (`addtime`),
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of oplog
-- ----------------------------
INSERT INTO `oplog` VALUES ('1', '2', '127.0.0.1', '添加标签456', '2018-11-16 13:49:51');
INSERT INTO `oplog` VALUES ('2', '2', '127.0.0.1', '添加标签abc', '2018-11-16 13:49:56');
INSERT INTO `oplog` VALUES ('3', '2', '127.0.0.1', '添加标签def', '2018-11-16 13:50:02');

-- ----------------------------
-- Table structure for preview
-- ----------------------------
DROP TABLE IF EXISTS `preview`;
CREATE TABLE `preview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `logo` (`logo`),
  KEY `ix_preview_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of preview
-- ----------------------------
INSERT INTO `preview` VALUES ('1', '变形金刚3', '201811182132306c615131a3b74e79a9eec895670531c8.png', '2018-11-18 21:32:31');
INSERT INTO `preview` VALUES ('2', '金刚狼3', '2018111821350125c70a3e97bd4e588d5675df5850f598.png', '2018-11-18 21:35:02');
INSERT INTO `preview` VALUES ('3', '毒液', '2018111821351892ca5ba5d0564ca39c73a06fffe05b66.png', '2018-11-18 21:35:19');
INSERT INTO `preview` VALUES ('4', '钢铁侠', '20181119103532dff911be992e48a0b37b80467599792b.png', '2018-11-19 10:35:32');
INSERT INTO `preview` VALUES ('5', '复仇者联盟', '20181119103549a26cd2d8009c4095a8b58f4464377fdc.png', '2018-11-19 10:35:49');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `auths` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_role_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', '', '2018-11-14 00:25:57');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_tag_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('1', '科幻', '2018-11-14 12:39:19');
INSERT INTO `tag` VALUES ('2', '动作', '2018-11-14 13:35:43');
INSERT INTO `tag` VALUES ('8', '爱情', '2018-11-14 14:05:19');
INSERT INTO `tag` VALUES ('9', '123', '2018-11-16 13:49:02');
INSERT INTO `tag` VALUES ('10', '456', '2018-11-16 13:49:51');
INSERT INTO `tag` VALUES ('11', 'abc', '2018-11-16 13:49:56');
INSERT INTO `tag` VALUES ('12', 'def', '2018-11-16 13:50:02');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `info` text,
  `face` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `face` (`face`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_user_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '虎', '123441', '1234@123.com', '13812345678', '虎', '1f241.png', '2018-11-16 00:30:50', '132ea60139974a63a2ea961d1ab4c83e');
INSERT INTO `user` VALUES ('2', '狗', '123442', '1233@123.com', '13812345677', '狗', '1f242.png', '2018-11-16 00:32:50', '08ad94a6d1ec48b7a1b70467b5803324');
INSERT INTO `user` VALUES ('3', 'arken', 'pbkdf2:sha256:50000$MpjiqQ42$213e809f939d7b929e67871a606500c81a6ebca85162358c7e1456456a883e03', 'eminjan123@123.com', '15327648069', 'EMinjan', '20181117182806de01c68ee3c64bd084975caacee80c0d.png', '2018-11-17 16:13:14', '24221e1f432e48179ebfc1f0f2f67fdc');
INSERT INTO `user` VALUES ('4', 'em', 'pbkdf2:sha256:50000$Hit8b6nF$f50056e088f7d8941efdc15e939eaf5b9bc94791cf62819aa502931b1b56cbbf', '12345@123.com', '15327648068', null, null, '2018-11-17 16:24:09', '6a87dd3dec0d44ff93bfc5ce5517c7ce');
INSERT INTO `user` VALUES ('5', 'python', 'pbkdf2:sha256:50000$0ReaJVHh$bcb74d4188af250270e959687cde4aafc020aa8457a426ce50eed6bca0a2213b', '12345567@123.com', '15327648060', null, null, '2018-11-19 16:29:08', '0f7f185c857f48a1aad9891cfcc0e8ce');

-- ----------------------------
-- Table structure for userlog
-- ----------------------------
DROP TABLE IF EXISTS `userlog`;
CREATE TABLE `userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_userlog_addtime` (`addtime`),
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of userlog
-- ----------------------------
INSERT INTO `userlog` VALUES ('1', '1', '192.168.9.1', '2018-11-16 14:21:31');
INSERT INTO `userlog` VALUES ('2', '2', '192.168.9.2', '2018-11-16 14:21:31');
INSERT INTO `userlog` VALUES ('3', '3', '127.0.0.1', '2018-11-17 17:15:07');
INSERT INTO `userlog` VALUES ('4', '3', '127.0.0.1', '2018-11-17 17:27:37');
INSERT INTO `userlog` VALUES ('5', '3', '127.0.0.1', '2018-11-18 19:58:34');
INSERT INTO `userlog` VALUES ('6', '3', '127.0.0.1', '2018-11-18 20:06:10');
INSERT INTO `userlog` VALUES ('7', '3', '127.0.0.1', '2018-11-18 20:07:20');
INSERT INTO `userlog` VALUES ('8', '3', '127.0.0.1', '2018-11-19 14:14:01');
INSERT INTO `userlog` VALUES ('9', '3', '127.0.0.1', '2018-11-19 14:26:41');
INSERT INTO `userlog` VALUES ('10', '3', '127.0.0.1', '2018-11-19 14:31:08');
INSERT INTO `userlog` VALUES ('11', '3', '127.0.0.1', '2018-11-19 14:31:44');
