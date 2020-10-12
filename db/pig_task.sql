
DROP DATABASE IF EXISTS `pig_task`;

CREATE DATABASE  `pig_task` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `pig_task`;

-- ----------------------------
-- Table structure for data_source
-- ----------------------------
DROP TABLE IF EXISTS `data_source`;
CREATE TABLE `data_source` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '数据源名称',
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属平台id',
  `url` varchar(255) NOT NULL COMMENT '数据源链接',
  `username` varchar(64) NOT NULL COMMENT '数据源用户名',
  `password` varchar(64) NOT NULL COMMENT '数据源密码',
  `driver_class` varchar(64) NOT NULL COMMENT '数据源驱动类',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modified_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='数据源表';

-- ----------------------------
-- Records of data_source
-- ----------------------------
INSERT INTO `data_source` VALUES ('1', '本地3.0数据库', 'JAVA_ENERGY', 'jdbc:mysql://192.168.7.151:3306/enplatform_park?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&rewriteBatchedStatements=true&serverTimezone=Asia/Shanghai', 'sa', 'sa-123456', 'com.mysql.jdbc.Driver', '2020-09-09 15:14:26', '2020-09-25 08:43:15');
INSERT INTO `data_source` VALUES ('3', '华师数据源', 'JAVA_ENERGY', 'jdbc:mysql:..', 'root', '123456', 'com.driver', '2020-09-23 10:19:01', '2020-09-23 10:19:35');

-- ----------------------------
-- Table structure for handler
-- ----------------------------
DROP TABLE IF EXISTS `handler`;
CREATE TABLE `handler` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `handler_name` varchar(255) DEFAULT NULL COMMENT '处理器名称',
  `handler_class` varchar(255) DEFAULT NULL COMMENT '处理器执行类',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modified_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='处理器表';

-- ----------------------------
-- Records of handler
-- ----------------------------
INSERT INTO `handler` VALUES ('5', '电表在线检测', 'com.sf.alarm.client.task.AmMonitorTask', '2020-09-08 17:18:29', '2020-09-24 10:25:34');
INSERT INTO `handler` VALUES ('6', '短信发送', 'com.sf.cloud.task.task.job.SmsTask', '2020-09-16 10:31:58', '2020-09-16 10:31:58');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_name` varchar(100) NOT NULL COMMENT '项目',
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '平台id',
  `handler_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '处理器',
  `message` varchar(200) NOT NULL COMMENT '报警内容',
  `state` varchar(10) DEFAULT 'NOT_SEND' COMMENT '任务状态',
  `level` int DEFAULT NULL COMMENT '消息等级(预留)',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modified_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='消息表';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('3', '公司平台', 'JAVA_ENERGY', '电表在线检测', '(公司平台最近电表离线)位置: 盛帆工业园..1号楼集中器, 4201466500, 离线数量: 81, 总数量: 81。', 'NOT_SEND', null, null, '2020-10-02 17:23:16', '2020-09-27 17:23:16');
INSERT INTO `message` VALUES ('4', '公司平台', 'JAVA_ENERGY', '电表在线检测', '(公司平台最近电表离线)位置: 盛帆工业园..11号楼(电表）, 4202087E00 , 离线数量: 91, 总数量: 91。', 'NOT_SEND', null, null, '2020-10-10 17:23:16', '2020-09-27 17:23:16');
INSERT INTO `message` VALUES ('5', '公司平台', 'JAVA_ENERGY', '电表在线检测', '(公司平台最近电表离线)位置: 盛帆工业园..5号楼5楼网关, 2301546B00 , 离线数量: 61, 总数量: 61。', 'NOT_SEND', null, null, '2020-09-27 17:23:17', '2020-09-27 17:23:17');

-- ----------------------------
-- Table structure for platform
-- ----------------------------
DROP TABLE IF EXISTS `platform`;
CREATE TABLE `platform` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `platform_name` varchar(255) DEFAULT NULL COMMENT '平台名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modified_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='平台表';

-- ----------------------------
-- Records of platform
-- ----------------------------
INSERT INTO `platform` VALUES ('1', 'java节能平台', '2020-09-09 00:00:00', '2020-09-09 00:00:00');
INSERT INTO `platform` VALUES ('2', '能源易支付', '2020-09-09 10:56:14', '2020-09-09 10:56:14');
INSERT INTO `platform` VALUES ('5', 'cloud', '2020-09-16 10:31:47', '2020-09-16 10:31:47');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '项目名称',
  `role_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modified_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='项目分组表';

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('2', '公司平台', '5,1', '2020-09-09 00:00:00', '2020-10-09 15:29:53');
INSERT INTO `project` VALUES ('3', '财大1', '', '2020-09-09 08:17:19', '2020-09-28 16:06:50');
INSERT INTO `project` VALUES ('4', '决策平台', '1', '2020-09-16 10:31:29', '2020-10-08 17:20:57');

-- ----------------------------
-- Table structure for sms_count
-- ----------------------------
DROP TABLE IF EXISTS `sms_count`;
CREATE TABLE `sms_count` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `remain` int NOT NULL COMMENT '剩余短信数量',
  `has_send` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='短信配置表';

-- ----------------------------
-- Records of sms_count
-- ----------------------------
INSERT INTO `sms_count` VALUES ('6', '200', '0');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '任务名称',
  `state` varchar(10) DEFAULT 'STOPPED' COMMENT '任务状态',
  `local_task` tinyint(1) NOT NULL COMMENT '是否本地任务',
  `project_id` int NOT NULL COMMENT '项目id',
  `handler_id` int NOT NULL COMMENT '处理器id',
  `previous_fire_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  `next_fire_time` datetime DEFAULT NULL COMMENT '下次执行时间',
  `cron` varchar(64) NOT NULL COMMENT 'cron表达式',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modified_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='任务表';

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('1', '测试', 'STOPPED', '0', '2', '5', '2020-09-27 17:25:41', '2020-09-30 16:09:29', '3/5 * * * * ? *', '', '2020-09-14 11:27:53', '2020-09-30 16:09:24');
INSERT INTO `task` VALUES ('3', '短信发送', 'START', '1', '4', '6', '2020-09-30 16:09:03', '2020-10-10 17:43:43', '3/5 * * * * ? *', '', '2020-09-16 10:32:35', '2020-10-10 17:43:40');

-- ----------------------------
-- Table structure for task_data_source
-- ----------------------------
DROP TABLE IF EXISTS `task_data_source`;
CREATE TABLE `task_data_source` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_id` int NOT NULL COMMENT '任务id',
  `data_source_id` int NOT NULL COMMENT '数据源id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modified_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='任务数据源表';

-- ----------------------------
-- Records of task_data_source
-- ----------------------------
INSERT INTO `task_data_source` VALUES ('20', '1', '1', null, null);
