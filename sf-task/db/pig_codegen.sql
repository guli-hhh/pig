/*
Navicat MySQL Data Transfer

Source Server         : 192.168.7.151_3308_docker
Source Server Version : 80020
Source Host           : 192.168.7.151:3308
Source Database       : pig_codegen

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2020-09-28 16:30:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gen_datasource_conf
-- ----------------------------
DROP TABLE IF EXISTS `gen_datasource_conf`;
CREATE TABLE `gen_datasource_conf` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新',
  `del_flag` char(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源表';

-- ----------------------------
-- Records of gen_datasource_conf
-- ----------------------------
INSERT INTO `gen_datasource_conf` VALUES ('9', '任务管理', 'jdbc:mysql://pig-mysql:3306/pig_task?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true', 'root', 'HM1lUmuNQ4ERT7eqDri+eA==', '2020-09-04 16:28:17', '2020-09-28 16:11:30', '1');

-- ----------------------------
-- Table structure for gen_form_conf
-- ----------------------------
DROP TABLE IF EXISTS `gen_form_conf`;
CREATE TABLE `gen_form_conf` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `table_name` varchar(64) DEFAULT NULL,
  `form_info` json NOT NULL COMMENT '表单信息',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` char(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `table_name` (`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='表单配置';

-- ----------------------------
-- Records of gen_form_conf
-- ----------------------------
