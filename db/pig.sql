DROP DATABASE IF EXISTS `pig`;

CREATE DATABASE  `pig` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE pig;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `sort` int DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '最高部门', '0', '2020-03-13 13:13:16', '2020-09-28 15:54:24', '0', '0');
INSERT INTO `sys_dept` VALUES ('2', '行政中心', '1', '2020-03-13 13:13:30', null, '0', '1');
INSERT INTO `sys_dept` VALUES ('3', '能效事业部', '2', '2020-03-13 13:14:55', '2020-09-28 15:57:33', '0', '1');
INSERT INTO `sys_dept` VALUES ('4', '运营中心', '3', '2020-03-13 13:15:15', null, '0', '1');
INSERT INTO `sys_dept` VALUES ('5', '系统组', '5', '2020-03-13 13:15:34', '2020-09-28 15:57:45', '0', '3');
INSERT INTO `sys_dept` VALUES ('6', '产品中心', '6', '2020-03-13 13:15:49', null, '0', '3');
INSERT INTO `sys_dept` VALUES ('7', '测试中心', '7', '2020-03-13 13:16:02', null, '0', '3');

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation` (
  `ancestor` int NOT NULL COMMENT '祖先节点',
  `descendant` int NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `idx1` (`ancestor`),
  KEY `idx2` (`descendant`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
INSERT INTO `sys_dept_relation` VALUES ('1', '1');
INSERT INTO `sys_dept_relation` VALUES ('1', '2');
INSERT INTO `sys_dept_relation` VALUES ('1', '3');
INSERT INTO `sys_dept_relation` VALUES ('1', '4');
INSERT INTO `sys_dept_relation` VALUES ('1', '5');
INSERT INTO `sys_dept_relation` VALUES ('1', '6');
INSERT INTO `sys_dept_relation` VALUES ('1', '7');
INSERT INTO `sys_dept_relation` VALUES ('2', '2');
INSERT INTO `sys_dept_relation` VALUES ('3', '3');
INSERT INTO `sys_dept_relation` VALUES ('3', '5');
INSERT INTO `sys_dept_relation` VALUES ('3', '6');
INSERT INTO `sys_dept_relation` VALUES ('3', '7');
INSERT INTO `sys_dept_relation` VALUES ('4', '4');
INSERT INTO `sys_dept_relation` VALUES ('5', '5');
INSERT INTO `sys_dept_relation` VALUES ('6', '6');
INSERT INTO `sys_dept_relation` VALUES ('7', '7');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `system` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', 'dict_type', '字典类型', '2019-05-16 14:16:20', '2019-05-16 14:20:16', '系统类不能修改', '1', '0');
INSERT INTO `sys_dict` VALUES ('2', 'log_type', '日志类型', '2020-03-13 14:21:01', '2020-03-13 14:21:01', '0-正常 1 异常', '1', '0');
INSERT INTO `sys_dict` VALUES ('3', 'myDict', '判断是否本地任务或者远端任务', '2020-09-15 11:09:17', '2020-09-15 17:05:47', '', '0', '1');
INSERT INTO `sys_dict` VALUES ('4', 'local_task', '判断是否本地任务或者远端任务', '2020-09-15 17:06:24', '2020-09-15 17:06:24', '0 非 1 是', '0', '0');
INSERT INTO `sys_dict` VALUES ('5', 'task_state', '任务状态', '2020-09-17 08:39:25', '2020-09-17 08:39:25', '任务状态', '0', '0');
INSERT INTO `sys_dict` VALUES ('6', 'message_state', '报警消息状态', '2020-09-18 12:17:56', '2020-09-18 12:17:56', '报警消息状态', '0', '0');
INSERT INTO `sys_dict` VALUES ('7', 'platform_type', '平台类型', '2020-09-21 17:32:05', '2020-09-21 17:32:05', '平台类型', '0', '0');

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `dict_id` int NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序（升序）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`label`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典项';

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES ('1', '1', '1', '系统类', 'dict_type', '系统类字典', '0', '2019-05-16 14:20:40', '2019-05-16 14:20:40', '不能修改删除', '0');
INSERT INTO `sys_dict_item` VALUES ('2', '1', '0', '业务类', 'dict_type', '业务类字典', '0', '2019-05-16 14:20:59', '2019-05-16 14:20:59', '可以修改', '0');
INSERT INTO `sys_dict_item` VALUES ('3', '2', '0', '正常', 'log_type', '正常', '0', '2020-03-13 14:23:22', '2020-03-13 14:23:22', '正常', '0');
INSERT INTO `sys_dict_item` VALUES ('4', '2', '9', '异常', 'log_type', '异常', '1', '2020-03-13 14:23:35', '2020-03-13 14:23:35', '异常', '0');
INSERT INTO `sys_dict_item` VALUES ('6', '3', '0', '本都数据', 'myDict', '本都数据', '0', '2020-09-15 11:10:05', '2020-09-15 17:05:47', '', '1');
INSERT INTO `sys_dict_item` VALUES ('7', '3', '1', '远端任务', 'myDict', '远端任务', '0', '2020-09-15 11:10:24', '2020-09-15 17:05:47', '', '1');
INSERT INTO `sys_dict_item` VALUES ('8', '4', 'true', '本地', 'local_task', '本地任务', '0', '2020-09-15 17:06:47', '2020-09-15 17:06:47', '', '0');
INSERT INTO `sys_dict_item` VALUES ('9', '4', 'false', '远端', 'local_task', '远端任务', '1', '2020-09-15 17:07:17', '2020-09-15 17:07:17', '', '0');
INSERT INTO `sys_dict_item` VALUES ('10', '5', 'STOPPED', '已停止', 'task_state', '已停止', '0', '2020-09-17 08:39:56', '2020-09-17 08:39:56', '已停止', '0');
INSERT INTO `sys_dict_item` VALUES ('11', '5', 'START', '运行中', 'task_state', '运行中', '1', '2020-09-17 08:40:32', '2020-09-17 08:40:32', '运行中', '0');
INSERT INTO `sys_dict_item` VALUES ('12', '6', 'NOT_SEND', '未发送', 'message_state', '未发送', '0', '2020-09-18 12:18:45', '2020-09-18 12:18:45', '', '0');
INSERT INTO `sys_dict_item` VALUES ('13', '6', 'HAS_SEND', '已发送', 'message_state', '已发送', '1', '2020-09-18 12:19:06', '2020-09-18 12:19:06', '', '0');
INSERT INTO `sys_dict_item` VALUES ('14', '7', 'ICBS', '能源易支付', 'platform_type', '能源易支付', '0', '2020-09-21 17:32:32', '2020-09-21 17:32:32', '', '0');
INSERT INTO `sys_dict_item` VALUES ('15', '7', 'JAVA_ENERGY', 'java节能平台', 'platform_type', 'java节能平台', '1', '2020-09-21 17:33:11', '2020-09-21 17:33:11', 'java节能平台', '0');
INSERT INTO `sys_dict_item` VALUES ('16', '7', 'C_ENERGY', 'C#节能平台', 'platform_type', 'C#节能平台', '2', '2020-09-21 17:33:40', '2020-09-21 17:33:40', 'C#节能平台', '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `service_id` varchar(32) DEFAULT NULL COMMENT '服务ID',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `time` mediumtext COMMENT '执行时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  `exception` text COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', '0', '更新菜单', 'pig', 'admin', '2020-09-04 15:17:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '152', '0', null);
INSERT INTO `sys_log` VALUES ('2', '0', '新增数据源表', 'pig', 'admin', '2020-09-04 16:26:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dsconf', 'POST', '', '159', '0', null);
INSERT INTO `sys_log` VALUES ('3', '0', '新增数据源表', 'pig', 'admin', '2020-09-04 16:28:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dsconf', 'POST', '', '130', '0', null);
INSERT INTO `sys_log` VALUES ('4', '0', '更新菜单', 'pig', 'admin', '2020-09-04 16:59:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '489', '0', null);
INSERT INTO `sys_log` VALUES ('5', '0', '更新菜单', 'pig', 'admin', '2020-09-04 16:59:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '87', '0', null);
INSERT INTO `sys_log` VALUES ('6', '0', '更新角色菜单', 'pig', 'admin', '2020-09-04 17:00:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '284', '0', null);
INSERT INTO `sys_log` VALUES ('7', '0', '编辑终端', 'pig', 'admin', '2020-09-07 15:17:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/client', 'PUT', '', '224', '0', null);
INSERT INTO `sys_log` VALUES ('8', '9', '新增任务管理模块', 'pig', 'admin', '2020-09-08 12:00:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/systask', 'POST', '', '67', '0', 'ids for this class must be manually assigned before calling save(): com.sf.cloud.task.task.entity.SysTask; nested exception is org.hibernate.id.IdentifierGenerationException: ids for this class must be manually assigned before calling save(): com.sf.cloud.task.task.entity.SysTask');
INSERT INTO `sys_log` VALUES ('9', '0', '新增任务管理模块', 'pig', 'admin', '2020-09-08 12:06:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/systask', 'POST', '', '199', '0', null);
INSERT INTO `sys_log` VALUES ('10', '0', '修改任务管理模块', 'pig', 'admin', '2020-09-08 12:08:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/systask', 'PUT', '', '119', '0', null);
INSERT INTO `sys_log` VALUES ('11', '0', '通过id删除任务管理模块', 'pig', 'admin', '2020-09-08 14:30:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/systask/2', 'DELETE', '', '525', '0', null);
INSERT INTO `sys_log` VALUES ('12', '0', '新增生成记录', 'pig', 'admin', '2020-09-08 14:38:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form', 'POST', '', '158', '0', null);
INSERT INTO `sys_log` VALUES ('13', '0', '新增任务管理模块', 'pig', 'admin', '2020-09-08 14:39:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/systask', 'POST', '', '77', '0', null);
INSERT INTO `sys_log` VALUES ('14', '0', '更新菜单', 'pig', 'admin', '2020-09-08 14:52:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '255', '0', null);
INSERT INTO `sys_log` VALUES ('15', '0', '新增菜单', 'pig', 'admin', '2020-09-08 14:54:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'POST', '', '107', '0', null);
INSERT INTO `sys_log` VALUES ('16', '0', '更新角色菜单', 'pig', 'admin', '2020-09-08 14:54:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '227', '0', null);
INSERT INTO `sys_log` VALUES ('17', '0', '更新菜单', 'pig', 'admin', '2020-09-08 14:55:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '63', '0', null);
INSERT INTO `sys_log` VALUES ('18', '0', '更新菜单', 'pig', 'admin', '2020-09-08 14:56:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '89', '0', null);
INSERT INTO `sys_log` VALUES ('19', '0', '更新菜单', 'pig', 'admin', '2020-09-08 14:57:27', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '49', '0', null);
INSERT INTO `sys_log` VALUES ('20', '0', '更新菜单', 'pig', 'admin', '2020-09-08 14:57:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '51', '0', null);
INSERT INTO `sys_log` VALUES ('21', '0', '更新菜单', 'pig', 'admin', '2020-09-08 14:57:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '52', '0', null);
INSERT INTO `sys_log` VALUES ('22', '0', '更新菜单', 'pig', 'admin', '2020-09-08 14:57:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '47', '0', null);
INSERT INTO `sys_log` VALUES ('23', '0', '新增生成记录', 'pig', 'admin', '2020-09-08 15:13:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form', 'POST', '', '108', '0', null);
INSERT INTO `sys_log` VALUES ('24', '0', '新增生成记录', 'pig', 'admin', '2020-09-08 15:17:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form', 'POST', '', '62', '0', null);
INSERT INTO `sys_log` VALUES ('25', '0', '修改任务管理模块', 'pig', 'admin', '2020-09-08 15:30:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/systask', 'PUT', '', '39', '0', null);
INSERT INTO `sys_log` VALUES ('26', '0', '更新角色菜单', 'pig', 'admin', '2020-09-08 16:10:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '229', '0', null);
INSERT INTO `sys_log` VALUES ('27', '0', '新增处理器表', 'pig', 'admin', '2020-09-08 16:22:40', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler', 'POST', '', '114', '0', null);
INSERT INTO `sys_log` VALUES ('28', '0', '新增处理器表', 'pig', 'admin', '2020-09-08 16:29:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler', 'POST', '', '83', '0', null);
INSERT INTO `sys_log` VALUES ('29', '0', '新增处理器表', 'pig', 'admin', '2020-09-08 16:47:27', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler', 'POST', '', '213', '0', null);
INSERT INTO `sys_log` VALUES ('30', '0', '新增处理器表', 'pig', 'admin', '2020-09-08 16:52:48', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler', 'POST', '', '46', '0', null);
INSERT INTO `sys_log` VALUES ('31', '0', '修改处理器表', 'pig', 'admin', '2020-09-08 16:53:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler', 'PUT', '', '110', '0', null);
INSERT INTO `sys_log` VALUES ('32', '0', '新增生成记录', 'pig', 'admin', '2020-09-08 17:03:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form', 'POST', '', '260', '0', null);
INSERT INTO `sys_log` VALUES ('33', '0', '新增生成记录', 'pig', 'admin', '2020-09-08 17:04:28', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form', 'POST', '', '73', '0', null);
INSERT INTO `sys_log` VALUES ('34', '0', '修改处理器表', 'pig', 'admin', '2020-09-08 17:06:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler', 'PUT', '', '44', '0', null);
INSERT INTO `sys_log` VALUES ('35', '0', '通过id删除处理器表', 'pig', 'admin', '2020-09-08 17:13:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler/4', 'DELETE', '', '167', '0', null);
INSERT INTO `sys_log` VALUES ('36', '0', '通过id删除处理器表', 'pig', 'admin', '2020-09-08 17:13:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler/3', 'DELETE', '', '73', '0', null);
INSERT INTO `sys_log` VALUES ('37', '0', '通过id删除处理器表', 'pig', 'admin', '2020-09-08 17:13:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler/2', 'DELETE', '', '194', '0', null);
INSERT INTO `sys_log` VALUES ('38', '0', '通过id删除处理器表', 'pig', 'admin', '2020-09-08 17:13:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler/1', 'DELETE', '', '59', '0', null);
INSERT INTO `sys_log` VALUES ('39', '0', '新增处理器表', 'pig', 'admin', '2020-09-08 17:13:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/handler', 'POST', '', '41', '0', null);
INSERT INTO `sys_log` VALUES ('40', '0', '更新角色菜单', 'pig', 'admin', '2020-09-08 17:38:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '150', '0', null);
INSERT INTO `sys_log` VALUES ('41', '9', '新增项目分组表', 'pig', 'admin', '2020-09-08 17:48:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/group', 'POST', '', '143', '0', 'could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not execute statement');
INSERT INTO `sys_log` VALUES ('42', '0', '新增项目分组表', 'pig', 'admin', '2020-09-09 08:07:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/group', 'POST', '', '340', '0', null);
INSERT INTO `sys_log` VALUES ('43', '0', '新增项目分组表', 'pig', 'admin', '2020-09-09 08:11:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/group', 'POST', '', '266', '0', null);
INSERT INTO `sys_log` VALUES ('44', '0', '新增项目分组表', 'pig', 'admin', '2020-09-09 08:12:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/group', 'POST', '', '288', '0', null);
INSERT INTO `sys_log` VALUES ('45', '0', '修改项目分组表', 'pig', 'admin', '2020-09-09 08:12:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/group', 'PUT', '', '182', '0', null);
INSERT INTO `sys_log` VALUES ('46', '0', '新增生成记录', 'pig', 'admin', '2020-09-09 08:13:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form', 'POST', '', '245', '0', null);
INSERT INTO `sys_log` VALUES ('47', '0', '新增生成记录', 'pig', 'admin', '2020-09-09 08:16:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form', 'POST', '', '105', '0', null);
INSERT INTO `sys_log` VALUES ('48', '0', '通过id删除项目分组表', 'pig', 'admin', '2020-09-09 08:20:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/group/1', 'DELETE', '', '236', '0', null);
INSERT INTO `sys_log` VALUES ('49', '0', '更新菜单', 'pig', 'admin', '2020-09-09 08:56:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '115', '0', null);
INSERT INTO `sys_log` VALUES ('50', '0', '删除菜单', 'pig', 'admin', '2020-09-09 09:00:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10011', 'DELETE', '', '548', '0', null);
INSERT INTO `sys_log` VALUES ('51', '0', '删除菜单', 'pig', 'admin', '2020-09-09 09:00:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10012', 'DELETE', '', '142', '0', null);
INSERT INTO `sys_log` VALUES ('52', '0', '删除菜单', 'pig', 'admin', '2020-09-09 09:00:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10013', 'DELETE', '', '114', '0', null);
INSERT INTO `sys_log` VALUES ('53', '0', '删除菜单', 'pig', 'admin', '2020-09-09 09:00:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10014', 'DELETE', '', '104', '0', null);
INSERT INTO `sys_log` VALUES ('54', '0', '删除菜单', 'pig', 'admin', '2020-09-09 09:00:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10015', 'DELETE', '', '122', '0', null);
INSERT INTO `sys_log` VALUES ('55', '0', '删除菜单', 'pig', 'admin', '2020-09-09 09:00:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10011', 'DELETE', '', '158', '0', null);
INSERT INTO `sys_log` VALUES ('56', '0', '更新角色菜单', 'pig', 'admin', '2020-09-09 09:02:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '864', '0', null);
INSERT INTO `sys_log` VALUES ('57', '0', '更新菜单', 'pig', 'admin', '2020-09-09 09:52:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '126', '0', null);
INSERT INTO `sys_log` VALUES ('58', '0', '更新角色菜单', 'pig', 'admin', '2020-09-09 10:47:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '537', '0', null);
INSERT INTO `sys_log` VALUES ('59', '0', '新增平台表', 'pig', 'admin', '2020-09-09 10:49:40', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/platform', 'POST', '', '204', '0', null);
INSERT INTO `sys_log` VALUES ('60', '0', '新增平台表', 'pig', 'admin', '2020-09-09 10:51:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/platform', 'POST', '', '96', '0', null);
INSERT INTO `sys_log` VALUES ('61', '0', '更新角色菜单', 'pig', 'admin', '2020-09-09 15:29:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '218', '0', null);
INSERT INTO `sys_log` VALUES ('62', '9', '修改数据源表', 'pig', 'admin', '2020-09-10 12:05:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/datasource', 'PUT', '', '207', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('63', '0', '新增平台表', 'pig', 'admin', '2020-09-10 17:12:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/platform', 'POST', '', '358', '0', null);
INSERT INTO `sys_log` VALUES ('64', '0', '新增平台表', 'pig', 'admin', '2020-09-10 17:20:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/platform', 'POST', '', '64', '0', null);
INSERT INTO `sys_log` VALUES ('65', '0', '修改平台表', 'pig', 'admin', '2020-09-10 17:32:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/platform', 'PUT', '', '141', '0', null);
INSERT INTO `sys_log` VALUES ('66', '0', '通过id删除平台表', 'pig', 'admin', '2020-09-11 08:07:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/platform/3', 'DELETE', '', '461', '0', null);
INSERT INTO `sys_log` VALUES ('67', '0', '通过id删除平台表', 'pig', 'admin', '2020-09-11 08:07:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/platform/4', 'DELETE', '', '115', '0', null);
INSERT INTO `sys_log` VALUES ('68', '0', '更新菜单', 'pig', 'admin', '2020-09-11 08:10:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '138', '0', null);
INSERT INTO `sys_log` VALUES ('69', '0', '更新菜单', 'pig', 'admin', '2020-09-11 08:10:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '146', '0', null);
INSERT INTO `sys_log` VALUES ('70', '0', '更新菜单', 'pig', 'admin', '2020-09-11 08:11:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '124', '0', null);
INSERT INTO `sys_log` VALUES ('71', '0', '更新菜单', 'pig', 'admin', '2020-09-11 08:11:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '93', '0', null);
INSERT INTO `sys_log` VALUES ('72', '0', '更新菜单', 'pig', 'admin', '2020-09-11 08:12:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '79', '0', null);
INSERT INTO `sys_log` VALUES ('73', '0', '删除菜单', 'pig', 'admin', '2020-09-11 10:00:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10001', 'DELETE', '', '116', '0', null);
INSERT INTO `sys_log` VALUES ('74', '0', '删除菜单', 'pig', 'admin', '2020-09-11 10:00:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10002', 'DELETE', '', '80', '0', null);
INSERT INTO `sys_log` VALUES ('75', '0', '删除菜单', 'pig', 'admin', '2020-09-11 10:00:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10003', 'DELETE', '', '94', '0', null);
INSERT INTO `sys_log` VALUES ('76', '0', '删除菜单', 'pig', 'admin', '2020-09-11 10:00:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10004', 'DELETE', '', '102', '0', null);
INSERT INTO `sys_log` VALUES ('77', '0', '删除菜单', 'pig', 'admin', '2020-09-11 10:00:40', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10005', 'DELETE', '', '80', '0', null);
INSERT INTO `sys_log` VALUES ('78', '0', '更新角色菜单', 'pig', 'admin', '2020-09-11 11:06:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '541', '0', null);
INSERT INTO `sys_log` VALUES ('79', '9', '新增任务表', 'pig', 'admin', '2020-09-11 11:09:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '178', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('80', '9', '新增任务表', 'pig', 'admin', '2020-09-11 11:11:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '17', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('81', '9', '新增任务表', 'pig', 'admin', '2020-09-11 11:18:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '9', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('82', '9', '新增任务表', 'pig', 'admin', '2020-09-11 11:21:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '57703', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('83', '9', '新增任务表', 'pig', 'admin', '2020-09-11 14:56:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '7987', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('84', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:04:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '8226', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('85', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:09:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '5868', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('86', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:09:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '5250', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('87', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:15:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '42166', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('88', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:26:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '15756', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('89', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:42:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '30358', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('90', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:50:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '35306', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('91', '9', '新增任务表', 'pig', 'admin', '2020-09-11 15:51:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '5942', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('92', '9', '新增任务表', 'pig', 'admin', '2020-09-11 16:25:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '8844', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('93', '9', '新增任务表', 'pig', 'admin', '2020-09-11 16:33:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '4488', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('94', '9', '新增任务表', 'pig', 'admin', '2020-09-11 16:40:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '4934', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('95', '9', '新增任务表', 'pig', 'admin', '2020-09-11 16:42:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '1784', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('96', '9', '新增任务表', 'pig', 'admin', '2020-09-11 17:22:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '5483', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('97', '9', '新增任务表', 'pig', 'admin', '2020-09-11 17:23:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '1295', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('98', '9', '新增任务表', 'pig', 'admin', '2020-09-11 17:24:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '11', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('99', '9', '新增任务表', 'pig', 'admin', '2020-09-14 08:34:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '18687', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('100', '9', '新增任务表', 'pig', 'admin', '2020-09-14 09:10:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '23560', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('101', '9', '新增任务表', 'pig', 'admin', '2020-09-14 09:11:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '618', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('102', '9', '新增任务表', 'pig', 'admin', '2020-09-14 09:28:20', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '4230', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('103', '9', '新增任务表', 'pig', 'admin', '2020-09-14 09:28:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '9', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('104', '9', '新增任务表', 'pig', 'admin', '2020-09-14 09:53:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '8471', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('105', '9', '新增任务表', 'pig', 'admin', '2020-09-14 09:54:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '11', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('106', '9', '新增任务表', 'pig', 'admin', '2020-09-14 09:58:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '13137', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('107', '9', '新增任务表', 'pig', 'admin', '2020-09-14 11:22:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '253', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('108', '0', '新增任务表', 'pig', 'admin', '2020-09-14 11:23:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '2493', '0', null);
INSERT INTO `sys_log` VALUES ('109', '0', '新增任务表', 'pig', 'admin', '2020-09-14 11:24:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '17507', '0', null);
INSERT INTO `sys_log` VALUES ('110', '0', '修改任务表', 'pig', 'admin', '2020-09-14 17:20:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '36', '0', null);
INSERT INTO `sys_log` VALUES ('111', '0', '修改任务表', 'pig', 'admin', '2020-09-14 17:23:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '14', '0', null);
INSERT INTO `sys_log` VALUES ('112', '0', '修改任务表', 'pig', 'admin', '2020-09-14 17:49:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '34', '0', null);
INSERT INTO `sys_log` VALUES ('113', '0', '修改任务表', 'pig', 'admin', '2020-09-14 17:50:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '279', '0', null);
INSERT INTO `sys_log` VALUES ('114', '0', '修改任务表', 'pig', 'admin', '2020-09-14 17:57:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '126', '0', null);
INSERT INTO `sys_log` VALUES ('115', '0', '新增字典项', 'pig', 'admin', '2020-09-15 09:34:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '375', '0', null);
INSERT INTO `sys_log` VALUES ('116', '0', '更新菜单', 'pig', 'admin', '2020-09-15 11:00:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '201', '0', null);
INSERT INTO `sys_log` VALUES ('117', '9', '修改字典项', 'pig', 'admin', '2020-09-15 11:03:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '163', '0', '系统内置字典项目不能修改');
INSERT INTO `sys_log` VALUES ('118', '9', '修改字典项', 'pig', 'admin', '2020-09-15 11:03:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '25', '0', '系统内置字典项目不能修改');
INSERT INTO `sys_log` VALUES ('119', '9', '添加字典', 'pig', 'admin', '2020-09-15 11:04:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '1573', '0', '\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n### The error may exist in com/pig4cloud/pig/admin/mapper/SysDictMapper.java (best guess)\n### The error may involve com.pig4cloud.pig.admin.mapper.SysDictMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO sys_dict  ( type, description,   `system`, remarks )  VALUES  ( ?, ?,   ?, ? )\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n; Data truncation: Data too long for column \'system\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1');
INSERT INTO `sys_log` VALUES ('120', '9', '添加字典', 'pig', 'admin', '2020-09-15 11:05:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '4', '0', '\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n### The error may exist in com/pig4cloud/pig/admin/mapper/SysDictMapper.java (best guess)\n### The error may involve com.pig4cloud.pig.admin.mapper.SysDictMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO sys_dict  ( type, description,   `system`, remarks )  VALUES  ( ?, ?,   ?, ? )\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n; Data truncation: Data too long for column \'system\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1');
INSERT INTO `sys_log` VALUES ('121', '9', '添加字典', 'pig', 'admin', '2020-09-15 11:05:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '3', '0', '\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n### The error may exist in com/pig4cloud/pig/admin/mapper/SysDictMapper.java (best guess)\n### The error may involve com.pig4cloud.pig.admin.mapper.SysDictMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO sys_dict  ( type, description,   `system`, remarks )  VALUES  ( ?, ?,   ?, ? )\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n; Data truncation: Data too long for column \'system\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1');
INSERT INTO `sys_log` VALUES ('122', '9', '删除字典项', 'pig', 'admin', '2020-09-15 11:06:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item/5', 'DELETE', '', '18', '0', '系统内置字典项目不能删除');
INSERT INTO `sys_log` VALUES ('123', '9', '添加字典', 'pig', 'admin', '2020-09-15 11:06:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '3', '0', '\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n### The error may exist in com/pig4cloud/pig/admin/mapper/SysDictMapper.java (best guess)\n### The error may involve com.pig4cloud.pig.admin.mapper.SysDictMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO sys_dict  ( type, description,   `system`, remarks )  VALUES  ( ?, ?,   ?, ? )\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1\n; Data truncation: Data too long for column \'system\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'system\' at row 1');
INSERT INTO `sys_log` VALUES ('124', '9', '修改字典项', 'pig', 'admin', '2020-09-15 11:08:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '3', '0', '系统内置字典项目不能修改');
INSERT INTO `sys_log` VALUES ('125', '0', '添加字典', 'pig', 'admin', '2020-09-15 11:09:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '136', '0', null);
INSERT INTO `sys_log` VALUES ('126', '0', '新增字典项', 'pig', 'admin', '2020-09-15 11:10:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '253', '0', null);
INSERT INTO `sys_log` VALUES ('127', '0', '新增字典项', 'pig', 'admin', '2020-09-15 11:10:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '90', '0', null);
INSERT INTO `sys_log` VALUES ('128', '9', '删除字典项', 'pig', 'admin', '2020-09-15 11:12:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item/5', 'DELETE', '', '2', '0', '系统内置字典项目不能删除');
INSERT INTO `sys_log` VALUES ('129', '0', '修改任务表', 'pig', 'admin', '2020-09-15 16:30:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '0', '0', null);
INSERT INTO `sys_log` VALUES ('130', '0', '修改任务表', 'pig', 'admin', '2020-09-15 16:31:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '0', '0', null);
INSERT INTO `sys_log` VALUES ('131', '0', '修改任务表', 'pig', 'admin', '2020-09-15 16:33:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '18756', '0', null);
INSERT INTO `sys_log` VALUES ('132', '0', '修改任务表', 'pig', 'admin', '2020-09-15 16:40:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '18684', '0', null);
INSERT INTO `sys_log` VALUES ('133', '0', '修改任务表', 'pig', 'admin', '2020-09-15 17:03:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '1878', '0', null);
INSERT INTO `sys_log` VALUES ('134', '0', '修改任务表', 'pig', 'admin', '2020-09-15 17:04:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '1958', '0', null);
INSERT INTO `sys_log` VALUES ('135', '0', '删除字典', 'pig', 'admin', '2020-09-15 17:05:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/3', 'DELETE', '', '494', '0', null);
INSERT INTO `sys_log` VALUES ('136', '0', '添加字典', 'pig', 'admin', '2020-09-15 17:06:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '57', '0', null);
INSERT INTO `sys_log` VALUES ('137', '0', '新增字典项', 'pig', 'admin', '2020-09-15 17:06:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '104', '0', null);
INSERT INTO `sys_log` VALUES ('138', '0', '新增字典项', 'pig', 'admin', '2020-09-15 17:07:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '170', '0', null);
INSERT INTO `sys_log` VALUES ('139', '9', '新增任务表', 'pig', 'admin', '2020-09-15 17:14:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '20744', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('140', '9', '新增任务表', 'pig', 'admin', '2020-09-15 17:15:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '14673', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('141', '9', '新增任务表', 'pig', 'admin', '2020-09-15 17:16:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'POST', '', '3709', '0', 'could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement');
INSERT INTO `sys_log` VALUES ('142', '0', '修改任务表', 'pig', 'admin', '2020-09-15 17:33:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '25649', '0', null);
INSERT INTO `sys_log` VALUES ('143', '0', '修改任务表', 'pig', 'admin', '2020-09-15 17:34:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '2997', '0', null);
INSERT INTO `sys_log` VALUES ('144', '0', '修改任务表', 'pig', 'admin', '2020-09-15 17:35:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/task', 'PUT', '', '1794', '0', null);
INSERT INTO `sys_log` VALUES ('145', '0', '修改字典项', 'pig', 'admin', '2020-09-16 08:56:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '258', '0', null);
INSERT INTO `sys_log` VALUES ('146', '0', '修改字典项', 'pig', 'admin', '2020-09-16 08:56:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '176', '0', null);
INSERT INTO `sys_log` VALUES ('147', '0', '修改字典项', 'pig', 'admin', '2020-09-16 09:14:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '107', '0', null);
INSERT INTO `sys_log` VALUES ('148', '0', '修改字典项', 'pig', 'admin', '2020-09-16 09:15:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '240', '0', null);
INSERT INTO `sys_log` VALUES ('149', '0', '修改字典项', 'pig', 'admin', '2020-09-16 11:21:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '81', '0', null);
INSERT INTO `sys_log` VALUES ('150', '0', '修改字典项', 'pig', 'admin', '2020-09-16 11:21:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '159', '0', null);
INSERT INTO `sys_log` VALUES ('151', '0', '添加字典', 'pig', 'admin', '2020-09-17 08:39:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '117', '0', null);
INSERT INTO `sys_log` VALUES ('152', '0', '新增字典项', 'pig', 'admin', '2020-09-17 08:39:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '241', '0', null);
INSERT INTO `sys_log` VALUES ('153', '0', '新增字典项', 'pig', 'admin', '2020-09-17 08:40:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '95', '0', null);
INSERT INTO `sys_log` VALUES ('154', '0', '修改字典项', 'pig', 'admin', '2020-09-17 09:09:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '109', '0', null);
INSERT INTO `sys_log` VALUES ('155', '0', '修改字典项', 'pig', 'admin', '2020-09-17 09:09:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '74', '0', null);
INSERT INTO `sys_log` VALUES ('156', '0', '修改字典项', 'pig', 'admin', '2020-09-17 10:24:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '43', '0', null);
INSERT INTO `sys_log` VALUES ('157', '0', '更新菜单', 'pig', 'admin', '2020-09-18 08:54:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '94', '0', null);
INSERT INTO `sys_log` VALUES ('158', '0', '更新菜单', 'pig', 'admin', '2020-09-18 08:54:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '57', '0', null);
INSERT INTO `sys_log` VALUES ('159', '0', '更新菜单', 'pig', 'admin', '2020-09-18 08:55:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '156', '0', null);
INSERT INTO `sys_log` VALUES ('160', '0', '更新菜单', 'pig', 'admin', '2020-09-18 08:55:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '65', '0', null);
INSERT INTO `sys_log` VALUES ('161', '0', '更新菜单', 'pig', 'admin', '2020-09-18 08:55:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '83', '0', null);
INSERT INTO `sys_log` VALUES ('162', '0', '更新角色菜单', 'pig', 'admin', '2020-09-18 08:56:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '411', '0', null);
INSERT INTO `sys_log` VALUES ('163', '0', '修改字典项', 'pig', 'admin', '2020-09-18 10:42:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '125', '0', null);
INSERT INTO `sys_log` VALUES ('164', '0', '修改字典项', 'pig', 'admin', '2020-09-18 10:42:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '47', '0', null);
INSERT INTO `sys_log` VALUES ('165', '0', '添加字典', 'pig', 'admin', '2020-09-18 12:17:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '81', '0', null);
INSERT INTO `sys_log` VALUES ('166', '0', '新增字典项', 'pig', 'admin', '2020-09-18 12:18:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '79', '0', null);
INSERT INTO `sys_log` VALUES ('167', '0', '新增字典项', 'pig', 'admin', '2020-09-18 12:19:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '48', '0', null);
INSERT INTO `sys_log` VALUES ('168', '0', '更新角色菜单', 'pig', 'admin', '2020-09-18 14:46:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '169', '0', null);
INSERT INTO `sys_log` VALUES ('169', '0', '更新角色菜单', 'pig', 'admin', '2020-09-18 14:46:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role/menu', 'PUT', '', '203', '0', null);
INSERT INTO `sys_log` VALUES ('170', '0', '更新用户信息', 'pig', 'admin', '2020-09-21 10:32:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/user', 'PUT', '', '4951', '0', null);
INSERT INTO `sys_log` VALUES ('171', '0', '添加字典', 'pig', 'admin', '2020-09-21 17:32:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict', 'POST', '', '124', '0', null);
INSERT INTO `sys_log` VALUES ('172', '0', '新增字典项', 'pig', 'admin', '2020-09-21 17:32:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '101', '0', null);
INSERT INTO `sys_log` VALUES ('173', '0', '新增字典项', 'pig', 'admin', '2020-09-21 17:33:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '45', '0', null);
INSERT INTO `sys_log` VALUES ('174', '0', '新增字典项', 'pig', 'admin', '2020-09-21 17:33:40', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'POST', '', '156', '0', null);
INSERT INTO `sys_log` VALUES ('175', '0', '修改字典项', 'pig', 'admin', '2020-09-22 09:16:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dict/item', 'PUT', '', '211', '0', null);
INSERT INTO `sys_log` VALUES ('176', '0', '删除菜单', 'pig', 'admin', '2020-09-22 10:19:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10025', 'DELETE', '', '330', '0', null);
INSERT INTO `sys_log` VALUES ('177', '0', '删除菜单', 'pig', 'admin', '2020-09-22 10:20:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10024', 'DELETE', '', '64', '0', null);
INSERT INTO `sys_log` VALUES ('178', '0', '删除菜单', 'pig', 'admin', '2020-09-22 10:20:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10023', 'DELETE', '', '597', '0', null);
INSERT INTO `sys_log` VALUES ('179', '0', '删除菜单', 'pig', 'admin', '2020-09-22 10:20:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10022', 'DELETE', '', '78', '0', null);
INSERT INTO `sys_log` VALUES ('180', '0', '删除菜单', 'pig', 'admin', '2020-09-22 10:20:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu/10021', 'DELETE', '', '51', '0', null);
INSERT INTO `sys_log` VALUES ('181', '0', '修改项目分组表', 'pig', 'admin', '2020-09-28 15:20:38', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/project', 'PUT', '', '13883', '0', null);
INSERT INTO `sys_log` VALUES ('182', '0', '修改项目分组表', 'pig', 'admin', '2020-09-28 15:38:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/project', 'PUT', '', '3052', '0', null);
INSERT INTO `sys_log` VALUES ('183', '0', '修改项目分组表', 'pig', 'admin', '2020-09-28 15:41:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/project', 'PUT', '', '89', '0', null);
INSERT INTO `sys_log` VALUES ('184', '0', '修改项目分组表', 'pig', 'admin', '2020-09-28 15:41:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/project', 'PUT', '', '52', '0', null);
INSERT INTO `sys_log` VALUES ('185', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:49:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '264', '0', null);
INSERT INTO `sys_log` VALUES ('186', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:51:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '57', '0', null);
INSERT INTO `sys_log` VALUES ('187', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:51:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '100', '0', null);
INSERT INTO `sys_log` VALUES ('188', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:51:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '83', '0', null);
INSERT INTO `sys_log` VALUES ('189', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:51:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '53', '0', null);
INSERT INTO `sys_log` VALUES ('190', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:51:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '55', '0', null);
INSERT INTO `sys_log` VALUES ('191', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:51:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '62', '0', null);
INSERT INTO `sys_log` VALUES ('192', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:52:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '83', '0', null);
INSERT INTO `sys_log` VALUES ('193', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:52:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '133', '0', null);
INSERT INTO `sys_log` VALUES ('194', '0', '更新菜单', 'pig', 'admin', '2020-09-28 15:52:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/menu', 'PUT', '', '51', '0', null);
INSERT INTO `sys_log` VALUES ('195', '0', '编辑部门', 'pig', 'admin', '2020-09-28 15:54:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dept', 'PUT', '', '459', '0', null);
INSERT INTO `sys_log` VALUES ('196', '0', '编辑部门', 'pig', 'admin', '2020-09-28 15:57:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dept', 'PUT', '', '446', '0', null);
INSERT INTO `sys_log` VALUES ('197', '0', '编辑部门', 'pig', 'admin', '2020-09-28 15:57:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dept', 'PUT', '', '105', '0', null);
INSERT INTO `sys_log` VALUES ('198', '0', '添加用户', 'pig', 'admin', '2020-09-28 15:58:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/user', 'POST', '', '298', '0', null);
INSERT INTO `sys_log` VALUES ('199', '0', '修改项目分组表', 'pig', '涂召亮', '2020-09-28 16:01:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/project', 'PUT', '', '89', '0', null);
INSERT INTO `sys_log` VALUES ('200', '0', '修改项目分组表', 'pig', '涂召亮', '2020-09-28 16:01:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/project', 'PUT', '', '54', '0', null);
INSERT INTO `sys_log` VALUES ('201', '0', '修改项目分组表', 'pig', '涂召亮', '2020-09-28 16:01:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/project', 'PUT', '', '44', '0', null);
INSERT INTO `sys_log` VALUES ('202', '0', '删除数据源表', 'pig', '涂召亮', '2020-09-28 16:11:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/dsconf/9', 'DELETE', '', '87', '0', null);
INSERT INTO `sys_log` VALUES ('203', '0', '通过id删除生成记录', 'pig', '涂召亮', '2020-09-28 16:11:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form/7', 'DELETE', '', '156', '0', null);
INSERT INTO `sys_log` VALUES ('204', '0', '通过id删除生成记录', 'pig', '涂召亮', '2020-09-28 16:11:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form/6', 'DELETE', '', '125', '0', null);
INSERT INTO `sys_log` VALUES ('205', '0', '通过id删除生成记录', 'pig', '涂召亮', '2020-09-28 16:11:48', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form/5', 'DELETE', '', '139', '0', null);
INSERT INTO `sys_log` VALUES ('206', '0', '通过id删除生成记录', 'pig', '涂召亮', '2020-09-28 16:11:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form/4', 'DELETE', '', '79', '0', null);
INSERT INTO `sys_log` VALUES ('207', '0', '通过id删除生成记录', 'pig', '涂召亮', '2020-09-28 16:11:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form/3', 'DELETE', '', '93', '0', null);
INSERT INTO `sys_log` VALUES ('208', '0', '通过id删除生成记录', 'pig', '涂召亮', '2020-09-28 16:11:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form/2', 'DELETE', '', '290', '0', null);
INSERT INTO `sys_log` VALUES ('209', '0', '通过id删除生成记录', 'pig', '涂召亮', '2020-09-28 16:11:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/form/1', 'DELETE', '', '68', '0', null);
INSERT INTO `sys_log` VALUES ('210', '0', '添加角色', 'pig', 'admin', '2020-09-30 08:41:50', null, '192.168.7.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role', 'POST', '', '1035', '0', null);
INSERT INTO `sys_log` VALUES ('211', '0', '添加角色', 'pig', 'admin', '2020-09-30 08:43:22', null, '192.168.7.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3775.400 QQBrowser/10.6.4208.400', '/role', 'POST', '', '159', '0', null);
INSERT INTO `sys_log` VALUES ('212', '0', '更新角色菜单', 'pig', 'admin', '2020-09-30 09:54:09', null, '192.168.7.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/role/menu', 'PUT', '', '1145', '0', null);
INSERT INTO `sys_log` VALUES ('213', '0', '更新菜单', 'pig', 'admin', '2020-09-30 10:02:01', null, '192.168.7.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/menu', 'PUT', '', '225', '0', null);
INSERT INTO `sys_log` VALUES ('214', '0', '更新角色菜单', 'pig', 'admin', '2020-09-30 10:07:52', null, '192.168.7.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/role/menu', 'PUT', '', '323', '0', null);
INSERT INTO `sys_log` VALUES ('215', '0', '通过id删除任务表', 'pig', 'admin', '2020-09-30 10:08:02', null, '192.168.7.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/task/4', 'DELETE', '', '112', '0', null);
INSERT INTO `sys_log` VALUES ('216', '0', '更新角色菜单', 'pig', 'admin', '2020-09-30 10:08:25', null, '192.168.7.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/role/menu', 'PUT', '', '581', '0', null);
INSERT INTO `sys_log` VALUES ('217', '0', '更新角色菜单', 'pig', 'admin', '2020-09-30 10:09:01', null, '192.168.7.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/role/menu', 'PUT', '', '318', '0', null);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(32) NOT NULL COMMENT '菜单名称',
  `permission` varchar(32) DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) DEFAULT NULL COMMENT '前端URL',
  `parent_id` int DEFAULT NULL COMMENT '父菜单ID',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `component` varchar(64) DEFAULT NULL COMMENT 'VUE页面',
  `sort` int DEFAULT '1' COMMENT '排序值',
  `keep_alive` char(1) DEFAULT '0' COMMENT '0-开启，1- 关闭',
  `type` char(1) DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '逻辑删除标记(0--正常 1--删除)',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10041 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1000', '权限管理', null, '/admin', '-1', 'icon-quanxianguanli', null, '0', '0', '0', '2018-09-28 08:29:53', '2020-03-11 23:58:18', '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', null, '/admin/user/index', '1000', 'icon-yonghuguanli', null, '1', '0', '0', '2017-11-02 22:24:37', '2020-03-12 00:12:57', '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户新增', 'sys_user_add', null, '1100', null, null, null, '0', '1', '2017-11-08 09:52:09', '2018-09-28 09:06:34', '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户修改', 'sys_user_edit', null, '1100', null, null, null, '0', '1', '2017-11-08 09:52:48', '2018-09-28 09:06:37', '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', 'sys_user_del', null, '1100', null, null, null, '0', '1', '2017-11-08 09:54:01', '2018-09-28 09:06:42', '0');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', null, '/admin/menu/index', '1000', 'icon-caidanguanli', null, '2', '0', '0', '2017-11-08 09:57:27', '2020-03-12 00:13:52', '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单新增', 'sys_menu_add', null, '1200', null, null, null, '0', '1', '2017-11-08 10:15:53', '2018-09-28 09:07:16', '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单修改', 'sys_menu_edit', null, '1200', null, null, null, '0', '1', '2017-11-08 10:16:23', '2018-09-28 09:07:18', '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', 'sys_menu_del', null, '1200', null, null, null, '0', '1', '2017-11-08 10:16:43', '2018-09-28 09:07:22', '0');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', null, '/admin/role/index', '1000', 'icon-jiaoseguanli', null, '3', '0', '0', '2017-11-08 10:13:37', '2020-03-12 00:15:40', '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色新增', 'sys_role_add', null, '1300', null, null, null, '0', '1', '2017-11-08 10:14:18', '2018-09-28 09:07:46', '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色修改', 'sys_role_edit', null, '1300', null, null, null, '0', '1', '2017-11-08 10:14:41', '2018-09-28 09:07:49', '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', 'sys_role_del', null, '1300', null, null, null, '0', '1', '2017-11-08 10:14:59', '2018-09-28 09:07:53', '0');
INSERT INTO `sys_menu` VALUES ('1304', '分配权限', 'sys_role_perm', null, '1300', null, null, null, '0', '1', '2018-04-20 07:22:55', '2018-09-28 09:13:23', '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', null, '/admin/dept/index', '1000', 'icon-web-icon-', null, '4', '0', '0', '2018-01-20 13:17:19', '2020-03-12 00:15:44', '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门新增', 'sys_dept_add', null, '1400', null, null, null, '0', '1', '2018-01-20 14:56:16', '2018-09-28 09:08:13', '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门修改', 'sys_dept_edit', null, '1400', null, null, null, '0', '1', '2018-01-20 14:56:59', '2018-09-28 09:08:16', '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', 'sys_dept_del', null, '1400', null, null, null, '0', '1', '2018-01-20 14:57:28', '2018-09-28 09:08:18', '0');
INSERT INTO `sys_menu` VALUES ('2000', '系统管理', null, '/setting', '-1', 'icon-xitongguanli', null, '1', '0', '0', '2017-11-07 20:56:00', '2020-03-11 23:52:53', '0');
INSERT INTO `sys_menu` VALUES ('2100', '日志管理', null, '/admin/log/index', '2000', 'icon-rizhiguanli', null, '5', '0', '0', '2017-11-20 14:06:22', '2020-03-12 00:15:49', '0');
INSERT INTO `sys_menu` VALUES ('2101', '日志删除', 'sys_log_del', null, '2100', null, null, null, '0', '1', '2017-11-20 20:37:37', '2018-09-28 09:08:44', '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', null, '/admin/dict/index', '2000', 'icon-navicon-zdgl', null, '6', '0', '0', '2017-11-29 11:30:52', '2020-03-12 00:15:58', '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', 'sys_dict_del', null, '2200', null, null, null, '0', '1', '2017-11-29 11:30:11', '2018-09-28 09:09:10', '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典新增', 'sys_dict_add', null, '2200', null, null, null, '0', '1', '2018-05-11 22:34:55', '2018-09-28 09:09:12', '0');
INSERT INTO `sys_menu` VALUES ('2203', '字典修改', 'sys_dict_edit', null, '2200', null, null, null, '0', '1', '2018-05-11 22:36:03', '2018-09-28 09:09:16', '0');
INSERT INTO `sys_menu` VALUES ('2300', '令牌管理', null, '/admin/token/index', '2000', 'icon-denglvlingpai', null, '11', '0', '0', '2018-09-04 05:58:41', '2020-03-13 12:57:25', '0');
INSERT INTO `sys_menu` VALUES ('2301', '令牌删除', 'sys_token_del', null, '2300', null, null, '1', '0', '1', '2018-09-04 05:59:50', '2020-03-13 12:57:34', '0');
INSERT INTO `sys_menu` VALUES ('2400', '终端管理', '', '/admin/client/index', '2000', 'icon-shouji', null, '9', '0', '0', '2018-01-20 13:17:19', '2020-03-12 00:15:54', '0');
INSERT INTO `sys_menu` VALUES ('2401', '客户端新增', 'sys_client_add', null, '2400', '1', null, null, '0', '1', '2018-05-15 21:35:18', '2018-09-28 09:10:25', '0');
INSERT INTO `sys_menu` VALUES ('2402', '客户端修改', 'sys_client_edit', null, '2400', null, null, null, '0', '1', '2018-05-15 21:37:06', '2018-09-28 09:10:27', '0');
INSERT INTO `sys_menu` VALUES ('2403', '客户端删除', 'sys_client_del', null, '2400', null, null, null, '0', '1', '2018-05-15 21:39:16', '2018-09-28 09:10:30', '0');
INSERT INTO `sys_menu` VALUES ('2500', '服务监控', null, 'http://127.0.0.1:5001', '2000', 'icon-server', null, '10', '0', '0', '2018-06-26 10:50:32', '2019-02-01 20:41:30', '0');
INSERT INTO `sys_menu` VALUES ('3000', '开发平台', null, '/gen', '-1', 'icon-shejiyukaifa-', null, '3', '1', '0', '2020-03-11 22:15:40', '2020-03-11 23:52:54', '0');
INSERT INTO `sys_menu` VALUES ('3100', '数据源管理', null, '/gen/datasource', '3000', 'icon-mysql', null, '1', '1', '0', '2020-03-11 22:17:05', '2020-03-12 00:16:09', '0');
INSERT INTO `sys_menu` VALUES ('3200', '代码生成', null, '/gen/index', '3000', 'icon-weibiaoti46', null, '2', '0', '0', '2020-03-11 22:23:42', '2020-03-12 00:16:14', '0');
INSERT INTO `sys_menu` VALUES ('3300', '表单管理', null, '/gen/form', '3000', 'icon-record', null, '3', '1', '0', '2020-03-11 22:19:32', '2020-03-12 00:16:18', '0');
INSERT INTO `sys_menu` VALUES ('3301', '表单新增', 'gen_form_add', null, '3300', '', null, '0', '0', '1', '2018-05-15 21:35:18', '2020-03-11 22:39:08', '0');
INSERT INTO `sys_menu` VALUES ('3302', '表单修改', 'gen_form_edit', null, '3300', '', null, '1', '0', '1', '2018-05-15 21:35:18', '2020-03-11 22:39:09', '0');
INSERT INTO `sys_menu` VALUES ('3303', '表单删除', 'gen_form_del', null, '3300', '', null, '2', '0', '1', '2018-05-15 21:35:18', '2020-03-11 22:39:11', '0');
INSERT INTO `sys_menu` VALUES ('3400', '表单设计', null, '/gen/design', '3000', 'icon-biaodanbiaoqian', null, '4', '1', '0', '2020-03-11 22:18:05', '2020-03-12 00:16:25', '0');
INSERT INTO `sys_menu` VALUES ('9999', '系统官网', null, 'http://www.baidu.com', '-1', 'icon-guanwangfangwen', null, '9', '0', '0', '2019-01-17 17:05:19', '2020-03-11 23:52:57', '0');
INSERT INTO `sys_menu` VALUES ('10000', '任务管理', '', '/task', '-1', 'icon-record', null, '8', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES ('10001', '任务管理模块查看', 'task_systask_get', null, '10005', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:29', '1');
INSERT INTO `sys_menu` VALUES ('10002', '任务管理模块新增', 'task_systask_add', null, '10005', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:31', '1');
INSERT INTO `sys_menu` VALUES ('10003', '任务管理模块修改', 'task_systask_edit', null, '10005', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:34', '1');
INSERT INTO `sys_menu` VALUES ('10004', '任务管理模块删除', 'task_systask_del', null, '10005', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:37', '1');
INSERT INTO `sys_menu` VALUES ('10005', '任务管理', null, '/task/systask/index', '1000', 'icon-quanxianguanli', null, '5', '0', '0', '2020-09-08 14:53:59', '2020-09-11 10:00:40', '1');
INSERT INTO `sys_menu` VALUES ('10006', '处理器表管理', '', '/task/handler/index', '3000', 'icon-caidanguanli', null, '5', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES ('10007', '处理器表查看', 'task_handler_get', null, '10006', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10008', '处理器表新增', 'task_handler_add', null, '10006', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10009', '处理器表修改', 'task_handler_edit', null, '10006', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10010', '处理器表删除', 'task_handler_del', null, '10006', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10016', '项目分组表管理', '', '/task/project/index', '10000', 'icon-web-icon-', null, '1', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES ('10017', '项目分组表查看', 'task_project_get', null, '10016', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10018', '项目分组表新增', 'task_project_add', null, '10016', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10019', '项目分组表修改', 'task_project_edit', null, '10016', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10020', '项目分组表删除', 'task_project_del', null, '10016', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10021', '平台表管理', '', '/task/platform/index', '10000', 'icon-bangzhushouji', null, '4', '0', '0', '2018-01-20 13:17:19', '2020-09-22 10:20:21', '1');
INSERT INTO `sys_menu` VALUES ('10022', '平台表查看', 'task_platform_get', null, '10021', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:20:18', '1');
INSERT INTO `sys_menu` VALUES ('10023', '平台表新增', 'task_platform_add', null, '10021', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:20:14', '1');
INSERT INTO `sys_menu` VALUES ('10024', '平台表修改', 'task_platform_edit', null, '10021', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:20:08', '1');
INSERT INTO `sys_menu` VALUES ('10025', '平台表删除', 'task_platform_del', null, '10021', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:19:57', '1');
INSERT INTO `sys_menu` VALUES ('10026', '数据源表管理', '', '/task/datasource/index', '10000', 'icon-wenjianguanli', null, '3', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES ('10027', '数据源表查看', 'task_datasource_get', null, '10026', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10028', '数据源表新增', 'task_datasource_add', null, '10026', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10029', '数据源表修改', 'task_datasource_edit', null, '10026', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10030', '数据源表删除', 'task_datasource_del', null, '10026', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10031', '任务表管理', '', '/task/task/index', '10000', 'icon-shejiyukaifa-', null, '4', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES ('10032', '任务表查看', 'task_task_get', null, '10031', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10033', '任务表新增', 'task_task_add', null, '10031', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10034', '任务表修改', 'task_task_edit', null, '10031', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10035', '任务表删除', 'task_task_del', null, '10031', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10036', '报警消息管理', '', '/task/message/index', '10000', 'icon-xiaoxiguanli', null, '5', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES ('10037', '报警消息查看', 'task_message_get', null, '10036', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10038', '报警消息新增', 'task_message_add', null, '10036', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10039', '报警消息修改', 'task_message_edit', null, '10036', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES ('10040', '报警消息删除', 'task_message_del', null, '10036', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');

-- ----------------------------
-- Table structure for sys_oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `sys_oauth_client_details`;
CREATE TABLE `sys_oauth_client_details` (
  `client_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `resource_ids` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_secret` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `scope` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `authorized_grant_types` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `authorities` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_token_validity` int DEFAULT NULL,
  `refresh_token_validity` int DEFAULT NULL,
  `additional_information` varchar(4096) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `autoapprove` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='终端信息表';

-- ----------------------------
-- Records of sys_oauth_client_details
-- ----------------------------
INSERT INTO `sys_oauth_client_details` VALUES ('app', null, 'app', 'server', 'password,refresh_token', null, null, null, null, null, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('daemon', null, 'daemon', 'server', 'password,refresh_token', null, null, null, null, null, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('gen', null, 'gen', 'server', 'password,refresh_token', null, null, null, null, null, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('pig', null, 'pig', 'server', 'password,refresh_token,authorization_code,client_credentials', 'http://localhost:4040/sso1/login,http://localhost:4041/sso1/login', null, null, null, null, 'false');
INSERT INTO `sys_oauth_client_details` VALUES ('test', null, 'test', 'server', 'password,refresh_token', null, null, null, null, null, 'true');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_idx1_role_code` (`role_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员', 'ROLE_ADMIN', '管理员', '2017-10-29 15:45:51', '2018-12-26 14:09:11', '0');
INSERT INTO `sys_role` VALUES ('5', '开发者', 'ROLE_DEV', '开发者', '2020-09-30 08:41:49', null, '0');
INSERT INTO `sys_role` VALUES ('6', '普通用户', 'ROLE_GUEST', '普通用户', '2020-09-30 08:43:22', null, '0');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int NOT NULL COMMENT '角色ID',
  `menu_id` int NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1000');
INSERT INTO `sys_role_menu` VALUES ('1', '1100');
INSERT INTO `sys_role_menu` VALUES ('1', '1101');
INSERT INTO `sys_role_menu` VALUES ('1', '1102');
INSERT INTO `sys_role_menu` VALUES ('1', '1103');
INSERT INTO `sys_role_menu` VALUES ('1', '1200');
INSERT INTO `sys_role_menu` VALUES ('1', '1201');
INSERT INTO `sys_role_menu` VALUES ('1', '1202');
INSERT INTO `sys_role_menu` VALUES ('1', '1203');
INSERT INTO `sys_role_menu` VALUES ('1', '1300');
INSERT INTO `sys_role_menu` VALUES ('1', '1301');
INSERT INTO `sys_role_menu` VALUES ('1', '1302');
INSERT INTO `sys_role_menu` VALUES ('1', '1303');
INSERT INTO `sys_role_menu` VALUES ('1', '1304');
INSERT INTO `sys_role_menu` VALUES ('1', '1400');
INSERT INTO `sys_role_menu` VALUES ('1', '1401');
INSERT INTO `sys_role_menu` VALUES ('1', '1402');
INSERT INTO `sys_role_menu` VALUES ('1', '1403');
INSERT INTO `sys_role_menu` VALUES ('1', '2000');
INSERT INTO `sys_role_menu` VALUES ('1', '2100');
INSERT INTO `sys_role_menu` VALUES ('1', '2101');
INSERT INTO `sys_role_menu` VALUES ('1', '2200');
INSERT INTO `sys_role_menu` VALUES ('1', '2201');
INSERT INTO `sys_role_menu` VALUES ('1', '2202');
INSERT INTO `sys_role_menu` VALUES ('1', '2203');
INSERT INTO `sys_role_menu` VALUES ('1', '2300');
INSERT INTO `sys_role_menu` VALUES ('1', '2301');
INSERT INTO `sys_role_menu` VALUES ('1', '2400');
INSERT INTO `sys_role_menu` VALUES ('1', '2401');
INSERT INTO `sys_role_menu` VALUES ('1', '2402');
INSERT INTO `sys_role_menu` VALUES ('1', '2403');
INSERT INTO `sys_role_menu` VALUES ('1', '2500');
INSERT INTO `sys_role_menu` VALUES ('1', '3000');
INSERT INTO `sys_role_menu` VALUES ('1', '3100');
INSERT INTO `sys_role_menu` VALUES ('1', '3200');
INSERT INTO `sys_role_menu` VALUES ('1', '3300');
INSERT INTO `sys_role_menu` VALUES ('1', '3301');
INSERT INTO `sys_role_menu` VALUES ('1', '3302');
INSERT INTO `sys_role_menu` VALUES ('1', '3303');
INSERT INTO `sys_role_menu` VALUES ('1', '3400');
INSERT INTO `sys_role_menu` VALUES ('1', '9999');
INSERT INTO `sys_role_menu` VALUES ('1', '10000');
INSERT INTO `sys_role_menu` VALUES ('1', '10006');
INSERT INTO `sys_role_menu` VALUES ('1', '10007');
INSERT INTO `sys_role_menu` VALUES ('1', '10008');
INSERT INTO `sys_role_menu` VALUES ('1', '10009');
INSERT INTO `sys_role_menu` VALUES ('1', '10010');
INSERT INTO `sys_role_menu` VALUES ('1', '10016');
INSERT INTO `sys_role_menu` VALUES ('1', '10017');
INSERT INTO `sys_role_menu` VALUES ('1', '10018');
INSERT INTO `sys_role_menu` VALUES ('1', '10019');
INSERT INTO `sys_role_menu` VALUES ('1', '10020');
INSERT INTO `sys_role_menu` VALUES ('1', '10026');
INSERT INTO `sys_role_menu` VALUES ('1', '10027');
INSERT INTO `sys_role_menu` VALUES ('1', '10028');
INSERT INTO `sys_role_menu` VALUES ('1', '10029');
INSERT INTO `sys_role_menu` VALUES ('1', '10030');
INSERT INTO `sys_role_menu` VALUES ('1', '10031');
INSERT INTO `sys_role_menu` VALUES ('1', '10032');
INSERT INTO `sys_role_menu` VALUES ('1', '10033');
INSERT INTO `sys_role_menu` VALUES ('1', '10034');
INSERT INTO `sys_role_menu` VALUES ('1', '10035');
INSERT INTO `sys_role_menu` VALUES ('1', '10036');
INSERT INTO `sys_role_menu` VALUES ('1', '10037');
INSERT INTO `sys_role_menu` VALUES ('1', '10038');
INSERT INTO `sys_role_menu` VALUES ('1', '10039');
INSERT INTO `sys_role_menu` VALUES ('1', '10040');
INSERT INTO `sys_role_menu` VALUES ('6', '10000');
INSERT INTO `sys_role_menu` VALUES ('6', '10006');
INSERT INTO `sys_role_menu` VALUES ('6', '10007');
INSERT INTO `sys_role_menu` VALUES ('6', '10008');
INSERT INTO `sys_role_menu` VALUES ('6', '10009');
INSERT INTO `sys_role_menu` VALUES ('6', '10010');
INSERT INTO `sys_role_menu` VALUES ('6', '10016');
INSERT INTO `sys_role_menu` VALUES ('6', '10017');
INSERT INTO `sys_role_menu` VALUES ('6', '10018');
INSERT INTO `sys_role_menu` VALUES ('6', '10019');
INSERT INTO `sys_role_menu` VALUES ('6', '10020');
INSERT INTO `sys_role_menu` VALUES ('6', '10026');
INSERT INTO `sys_role_menu` VALUES ('6', '10027');
INSERT INTO `sys_role_menu` VALUES ('6', '10028');
INSERT INTO `sys_role_menu` VALUES ('6', '10029');
INSERT INTO `sys_role_menu` VALUES ('6', '10030');
INSERT INTO `sys_role_menu` VALUES ('6', '10031');
INSERT INTO `sys_role_menu` VALUES ('6', '10032');
INSERT INTO `sys_role_menu` VALUES ('6', '10033');
INSERT INTO `sys_role_menu` VALUES ('6', '10034');
INSERT INTO `sys_role_menu` VALUES ('6', '10035');
INSERT INTO `sys_role_menu` VALUES ('6', '10036');
INSERT INTO `sys_role_menu` VALUES ('6', '10037');
INSERT INTO `sys_role_menu` VALUES ('6', '10038');
INSERT INTO `sys_role_menu` VALUES ('6', '10039');
INSERT INTO `sys_role_menu` VALUES ('6', '10040');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '随机盐',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '简介',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `dept_id` int DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `lock_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '0-正常，9-锁定',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`user_id`),
  KEY `user_idx1_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$QPe3iJs669eSVVpunnvH0enr7TYs88xe5VnsgcqqRSluRCNcxxGKy', null, '17034642999', '', '1', '2018-04-20 07:15:18', '2020-09-21 10:32:02', '0', '0');
INSERT INTO `sys_user` VALUES ('2', '涂召亮', '$2a$10$IGtqNBHe5MOw2zny4pOqZOfLmAYSnDjmVwF76VQC9Obcw07ZV061e', null, '15172445210', null, '5', '2020-09-28 15:58:23', null, '0', '0');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` int NOT NULL COMMENT '用户ID',
  `role_id` int NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '1');
