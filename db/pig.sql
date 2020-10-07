DROP DATABASE IF EXISTS `pig`;

CREATE DATABASE  `pig` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `pig`;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES (1, '最高部门', '0', '2020-03-13 13:13:16', '2020-09-28 15:54:24', '0', '0');
INSERT INTO `sys_dept` VALUES (2, '行政中心', '1', '2020-03-13 13:13:30', null, '0', '1');
INSERT INTO `sys_dept` VALUES (3, '能效事业部', '2', '2020-03-13 13:14:55', '2020-09-28 15:57:33', '0', '1');
INSERT INTO `sys_dept` VALUES (4, '运营中心', '3', '2020-03-13 13:15:15', null, '0', '1');
INSERT INTO `sys_dept` VALUES (5, '系统组', '5', '2020-03-13 13:15:34', '2020-09-28 15:57:45', '0', '3');
INSERT INTO `sys_dept` VALUES (6, '产品中心', '6', '2020-03-13 13:15:49', null, '0', '3');
INSERT INTO `sys_dept` VALUES (7, '测试中心', '7', '2020-03-13 13:16:02', null, '0', '3');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation` (
  `ancestor` int(11) NOT NULL COMMENT '祖先节点',
  `descendant` int(11) NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `idx1` (`ancestor`),
  KEY `idx2` (`descendant`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept_relation` VALUES (1, 1);
INSERT INTO `sys_dept_relation` VALUES (1, 2);
INSERT INTO `sys_dept_relation` VALUES (1, 3);
INSERT INTO `sys_dept_relation` VALUES (1, 4);
INSERT INTO `sys_dept_relation` VALUES (1, 5);
INSERT INTO `sys_dept_relation` VALUES (1, 6);
INSERT INTO `sys_dept_relation` VALUES (1, 7);
INSERT INTO `sys_dept_relation` VALUES (2, 2);
INSERT INTO `sys_dept_relation` VALUES (3, 3);
INSERT INTO `sys_dept_relation` VALUES (3, 5);
INSERT INTO `sys_dept_relation` VALUES (3, 6);
INSERT INTO `sys_dept_relation` VALUES (3, 7);
INSERT INTO `sys_dept_relation` VALUES (4, 4);
INSERT INTO `sys_dept_relation` VALUES (5, 5);
INSERT INTO `sys_dept_relation` VALUES (6, 6);
INSERT INTO `sys_dept_relation` VALUES (7, 7);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `system` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES (1, 'dict_type', '字典类型', '2019-05-16 14:16:20', '2019-05-16 14:20:16', '系统类不能修改', '1', '0');
INSERT INTO `sys_dict` VALUES (2, 'log_type', '日志类型', '2020-03-13 14:21:01', '2020-03-13 14:21:01', '0-正常 1 异常', '1', '0');
INSERT INTO `sys_dict` VALUES (3, 'myDict', '判断是否本地任务或者远端任务', '2020-09-15 11:09:17', '2020-09-15 17:05:47', '', '0', '1');
INSERT INTO `sys_dict` VALUES (4, 'local_task', '判断是否本地任务或者远端任务', '2020-09-15 17:06:24', '2020-09-15 17:06:24', '0 非 1 是', '0', '0');
INSERT INTO `sys_dict` VALUES (5, 'task_state', '任务状态', '2020-09-17 08:39:25', '2020-09-17 08:39:25', '任务状态', '0', '0');
INSERT INTO `sys_dict` VALUES (6, 'message_state', '报警消息状态', '2020-09-18 12:17:56', '2020-09-18 12:17:56', '报警消息状态', '0', '0');
INSERT INTO `sys_dict` VALUES (7, 'platform_type', '平台类型', '2020-09-21 17:32:05', '2020-09-21 17:32:05', '平台类型', '0', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `dict_id` int(11) NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序（升序）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`label`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典项';

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_item` VALUES (1, 1, '1', '系统类', 'dict_type', '系统类字典', 0, '2019-05-16 14:20:40', '2019-05-16 14:20:40', '不能修改删除', '0');
INSERT INTO `sys_dict_item` VALUES (2, 1, '0', '业务类', 'dict_type', '业务类字典', 0, '2019-05-16 14:20:59', '2019-05-16 14:20:59', '可以修改', '0');
INSERT INTO `sys_dict_item` VALUES (3, 2, '0', '正常', 'log_type', '正常', 0, '2020-03-13 14:23:22', '2020-03-13 14:23:22', '正常', '0');
INSERT INTO `sys_dict_item` VALUES (4, 2, '9', '异常', 'log_type', '异常', 1, '2020-03-13 14:23:35', '2020-03-13 14:23:35', '异常', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='日志表';

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(32) NOT NULL COMMENT '菜单名称',
  `permission` varchar(32) DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) DEFAULT NULL COMMENT '前端URL',
  `parent_id` int(11) DEFAULT NULL COMMENT '父菜单ID',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `component` varchar(64) DEFAULT NULL COMMENT 'VUE页面',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `keep_alive` char(1) DEFAULT '0' COMMENT '0-开启，1- 关闭',
  `type` char(1) DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '逻辑删除标记(0--正常 1--删除)',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (1000, '权限管理', null, '/admin', '-1', 'icon-quanxianguanli', null, '0', '0', '0', '2018-09-28 08:29:53', '2020-03-11 23:58:18', '0');
INSERT INTO `sys_menu` VALUES (1100, '用户管理', null, '/admin/user/index', '1000', 'icon-yonghuguanli', null, '1', '0', '0', '2017-11-02 22:24:37', '2020-03-12 00:12:57', '0');
INSERT INTO `sys_menu` VALUES (1101, '用户新增', 'sys_user_add', null, '1100', null, null, null, '0', '1', '2017-11-08 09:52:09', '2018-09-28 09:06:34', '0');
INSERT INTO `sys_menu` VALUES (1102, '用户修改', 'sys_user_edit', null, '1100', null, null, null, '0', '1', '2017-11-08 09:52:48', '2018-09-28 09:06:37', '0');
INSERT INTO `sys_menu` VALUES (1103, '用户删除', 'sys_user_del', null, '1100', null, null, null, '0', '1', '2017-11-08 09:54:01', '2018-09-28 09:06:42', '0');
INSERT INTO `sys_menu` VALUES (1200, '菜单管理', null, '/admin/menu/index', '1000', 'icon-caidanguanli', null, '2', '0', '0', '2017-11-08 09:57:27', '2020-03-12 00:13:52', '0');
INSERT INTO `sys_menu` VALUES (1201, '菜单新增', 'sys_menu_add', null, '1200', null, null, null, '0', '1', '2017-11-08 10:15:53', '2018-09-28 09:07:16', '0');
INSERT INTO `sys_menu` VALUES (1202, '菜单修改', 'sys_menu_edit', null, '1200', null, null, null, '0', '1', '2017-11-08 10:16:23', '2018-09-28 09:07:18', '0');
INSERT INTO `sys_menu` VALUES (1203, '菜单删除', 'sys_menu_del', null, '1200', null, null, null, '0', '1', '2017-11-08 10:16:43', '2018-09-28 09:07:22', '0');
INSERT INTO `sys_menu` VALUES (1300, '角色管理', null, '/admin/role/index', '1000', 'icon-jiaoseguanli', null, '3', '0', '0', '2017-11-08 10:13:37', '2020-03-12 00:15:40', '0');
INSERT INTO `sys_menu` VALUES (1301, '角色新增', 'sys_role_add', null, '1300', null, null, null, '0', '1', '2017-11-08 10:14:18', '2018-09-28 09:07:46', '0');
INSERT INTO `sys_menu` VALUES (1302, '角色修改', 'sys_role_edit', null, '1300', null, null, null, '0', '1', '2017-11-08 10:14:41', '2018-09-28 09:07:49', '0');
INSERT INTO `sys_menu` VALUES (1303, '角色删除', 'sys_role_del', null, '1300', null, null, null, '0', '1', '2017-11-08 10:14:59', '2018-09-28 09:07:53', '0');
INSERT INTO `sys_menu` VALUES (1304, '分配权限', 'sys_role_perm', null, '1300', null, null, null, '0', '1', '2018-04-20 07:22:55', '2018-09-28 09:13:23', '0');
INSERT INTO `sys_menu` VALUES (1400, '部门管理', null, '/admin/dept/index', '1000', 'icon-web-icon-', null, '4', '0', '0', '2018-01-20 13:17:19', '2020-03-12 00:15:44', '0');
INSERT INTO `sys_menu` VALUES (1401, '部门新增', 'sys_dept_add', null, '1400', null, null, null, '0', '1', '2018-01-20 14:56:16', '2018-09-28 09:08:13', '0');
INSERT INTO `sys_menu` VALUES (1402, '部门修改', 'sys_dept_edit', null, '1400', null, null, null, '0', '1', '2018-01-20 14:56:59', '2018-09-28 09:08:16', '0');
INSERT INTO `sys_menu` VALUES (1403, '部门删除', 'sys_dept_del', null, '1400', null, null, null, '0', '1', '2018-01-20 14:57:28', '2018-09-28 09:08:18', '0');
INSERT INTO `sys_menu` VALUES (2000, '系统管理', null, '/setting', '-1', 'icon-xitongguanli', null, '1', '0', '0', '2017-11-07 20:56:00', '2020-03-11 23:52:53', '0');
INSERT INTO `sys_menu` VALUES (2100, '日志管理', null, '/admin/log/index', '2000', 'icon-rizhiguanli', null, '5', '0', '0', '2017-11-20 14:06:22', '2020-03-12 00:15:49', '0');
INSERT INTO `sys_menu` VALUES (2101, '日志删除', 'sys_log_del', null, '2100', null, null, null, '0', '1', '2017-11-20 20:37:37', '2018-09-28 09:08:44', '0');
INSERT INTO `sys_menu` VALUES (2200, '字典管理', null, '/admin/dict/index', '2000', 'icon-navicon-zdgl', null, '6', '0', '0', '2017-11-29 11:30:52', '2020-03-12 00:15:58', '0');
INSERT INTO `sys_menu` VALUES (2201, '字典删除', 'sys_dict_del', null, '2200', null, null, null, '0', '1', '2017-11-29 11:30:11', '2018-09-28 09:09:10', '0');
INSERT INTO `sys_menu` VALUES (2202, '字典新增', 'sys_dict_add', null, '2200', null, null, null, '0', '1', '2018-05-11 22:34:55', '2018-09-28 09:09:12', '0');
INSERT INTO `sys_menu` VALUES (2203, '字典修改', 'sys_dict_edit', null, '2200', null, null, null, '0', '1', '2018-05-11 22:36:03', '2018-09-28 09:09:16', '0');
INSERT INTO `sys_menu` VALUES (2300, '令牌管理', null, '/admin/token/index', '2000', 'icon-denglvlingpai', null, '11', '0', '0', '2018-09-04 05:58:41', '2020-03-13 12:57:25', '0');
INSERT INTO `sys_menu` VALUES (2301, '令牌删除', 'sys_token_del', null, '2300', null, null, '1', '0', '1', '2018-09-04 05:59:50', '2020-03-13 12:57:34', '0');
INSERT INTO `sys_menu` VALUES (2400, '终端管理', '', '/admin/client/index', '2000', 'icon-shouji', null, '9', '0', '0', '2018-01-20 13:17:19', '2020-03-12 00:15:54', '0');
INSERT INTO `sys_menu` VALUES (2401, '客户端新增', 'sys_client_add', null, '2400', '1', null, null, '0', '1', '2018-05-15 21:35:18', '2018-09-28 09:10:25', '0');
INSERT INTO `sys_menu` VALUES (2402, '客户端修改', 'sys_client_edit', null, '2400', null, null, null, '0', '1', '2018-05-15 21:37:06', '2018-09-28 09:10:27', '0');
INSERT INTO `sys_menu` VALUES (2403, '客户端删除', 'sys_client_del', null, '2400', null, null, null, '0', '1', '2018-05-15 21:39:16', '2018-09-28 09:10:30', '0');
INSERT INTO `sys_menu` VALUES (2500, '服务监控', null, 'http://127.0.0.1:5001', '2000', 'icon-server', null, '10', '0', '0', '2018-06-26 10:50:32', '2019-02-01 20:41:30', '0');
INSERT INTO `sys_menu` VALUES (3000, '开发平台', null, '/gen', '-1', 'icon-shejiyukaifa-', null, '3', '1', '0', '2020-03-11 22:15:40', '2020-03-11 23:52:54', '0');
INSERT INTO `sys_menu` VALUES (3100, '数据源管理', null, '/gen/datasource', '3000', 'icon-mysql', null, '1', '1', '0', '2020-03-11 22:17:05', '2020-03-12 00:16:09', '0');
INSERT INTO `sys_menu` VALUES (3200, '代码生成', null, '/gen/index', '3000', 'icon-weibiaoti46', null, '2', '0', '0', '2020-03-11 22:23:42', '2020-03-12 00:16:14', '0');
INSERT INTO `sys_menu` VALUES (3300, '表单管理', null, '/gen/form', '3000', 'icon-record', null, '3', '1', '0', '2020-03-11 22:19:32', '2020-03-12 00:16:18', '0');
INSERT INTO `sys_menu` VALUES (3301, '表单新增', 'gen_form_add', null, '3300', '', null, '0', '0', '1', '2018-05-15 21:35:18', '2020-03-11 22:39:08', '0');
INSERT INTO `sys_menu` VALUES (3302, '表单修改', 'gen_form_edit', null, '3300', '', null, '1', '0', '1', '2018-05-15 21:35:18', '2020-03-11 22:39:09', '0');
INSERT INTO `sys_menu` VALUES (3303, '表单删除', 'gen_form_del', null, '3300', '', null, '2', '0', '1', '2018-05-15 21:35:18', '2020-03-11 22:39:11', '0');
INSERT INTO `sys_menu` VALUES (3400, '表单设计', null, '/gen/design', '3000', 'icon-biaodanbiaoqian', null, '4', '1', '0', '2020-03-11 22:18:05', '2020-03-12 00:16:25', '0');
INSERT INTO `sys_menu` VALUES (9999, '系统官网', null, 'http://www.baidu.com', '-1', 'icon-guanwangfangwen', null, '9', '0', '0', '2019-01-17 17:05:19', '2020-03-11 23:52:57', '0');
INSERT INTO `sys_menu` VALUES (10000, '任务管理', '', '/task', '-1', 'icon-record', null, '8', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES (10001, '任务管理模块查看', 'task_systask_get', null, '10005', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:29', '1');
INSERT INTO `sys_menu` VALUES (10002, '任务管理模块新增', 'task_systask_add', null, '10005', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:31', '1');
INSERT INTO `sys_menu` VALUES (10003, '任务管理模块修改', 'task_systask_edit', null, '10005', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:34', '1');
INSERT INTO `sys_menu` VALUES (10004, '任务管理模块删除', 'task_systask_del', null, '10005', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2020-09-11 10:00:37', '1');
INSERT INTO `sys_menu` VALUES (10005, '任务管理', null, '/task/systask/index', '1000', 'icon-quanxianguanli', null, '5', '0', '0', '2020-09-08 14:53:59', '2020-09-11 10:00:40', '1');
INSERT INTO `sys_menu` VALUES (10006, '处理器表管理', '', '/task/handler/index', '10000', 'icon-caidanguanli', null, '2', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES (10007, '处理器表查看', 'task_handler_get', null, '10006', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10008, '处理器表新增', 'task_handler_add', null, '10006', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10009, '处理器表修改', 'task_handler_edit', null, '10006', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10010, '处理器表删除', 'task_handler_del', null, '10006', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10016, '项目分组表管理', '', '/task/project/index', '10000', 'icon-web-icon-', null, '1', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES (10017, '项目分组表查看', 'task_project_get', null, '10016', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10018, '项目分组表新增', 'task_project_add', null, '10016', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10019, '项目分组表修改', 'task_project_edit', null, '10016', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10020, '项目分组表删除', 'task_project_del', null, '10016', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10021, '平台表管理', '', '/task/platform/index', '10000', 'icon-bangzhushouji', null, '4', '0', '0', '2018-01-20 13:17:19', '2020-09-22 10:20:21', '1');
INSERT INTO `sys_menu` VALUES (10022, '平台表查看', 'task_platform_get', null, '10021', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:20:18', '1');
INSERT INTO `sys_menu` VALUES (10023, '平台表新增', 'task_platform_add', null, '10021', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:20:14', '1');
INSERT INTO `sys_menu` VALUES (10024, '平台表修改', 'task_platform_edit', null, '10021', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:20:08', '1');
INSERT INTO `sys_menu` VALUES (10025, '平台表删除', 'task_platform_del', null, '10021', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2020-09-22 10:19:57', '1');
INSERT INTO `sys_menu` VALUES (10026, '数据源表管理', '', '/task/datasource/index', '10000', 'icon-wenjianguanli', null, '3', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES (10027, '数据源表查看', 'task_datasource_get', null, '10026', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10028, '数据源表新增', 'task_datasource_add', null, '10026', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10029, '数据源表修改', 'task_datasource_edit', null, '10026', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10030, '数据源表删除', 'task_datasource_del', null, '10026', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10031, '任务表管理', '', '/task/task/index', '10000', 'icon-shejiyukaifa-', null, '4', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES (10032, '任务表查看', 'task_task_get', null, '10031', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10033, '任务表新增', 'task_task_add', null, '10031', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10034, '任务表修改', 'task_task_edit', null, '10031', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10035, '任务表删除', 'task_task_del', null, '10031', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10036, '报警消息管理', '', '/task/message/index', '10000', 'icon-xiaoxiguanli', null, '5', '0', '0', '2018-01-20 13:17:19', '2018-07-29 13:38:19', '0');
INSERT INTO `sys_menu` VALUES (10037, '报警消息查看', 'task_message_get', null, '10036', '1', null, '0', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10038, '报警消息新增', 'task_message_add', null, '10036', '1', null, '1', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10039, '报警消息修改', 'task_message_edit', null, '10036', '1', null, '2', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
INSERT INTO `sys_menu` VALUES (10040, '报警消息删除', 'task_message_del', null, '10036', '1', null, '3', '0', '1', '2018-05-15 21:35:18', '2018-07-29 13:38:59', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `sys_oauth_client_details`;
CREATE TABLE `sys_oauth_client_details` (
  `client_id` varchar(32) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='终端信息表';

-- ----------------------------
-- Records of sys_oauth_client_details
-- ----------------------------
BEGIN;
INSERT INTO `sys_oauth_client_details` VALUES ('app', NULL, 'app', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('daemon', NULL, 'daemon', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('gen', NULL, 'gen', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('pig', NULL, 'pig', 'server', 'password,refresh_token,authorization_code,client_credentials', 'http://localhost:4040/sso1/login,http://localhost:4041/sso1/login', NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('test', NULL, 'test', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_idx1_role_code` (`role_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, '管理员', 'ROLE_ADMIN', '管理员', '2017-10-29 15:45:51', '2018-12-26 14:09:11', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES (1, 1000);
INSERT INTO `sys_role_menu` VALUES (1, 1100);
INSERT INTO `sys_role_menu` VALUES (1, 1101);
INSERT INTO `sys_role_menu` VALUES (1, 1102);
INSERT INTO `sys_role_menu` VALUES (1, 1103);
INSERT INTO `sys_role_menu` VALUES (1, 1200);
INSERT INTO `sys_role_menu` VALUES (1, 1201);
INSERT INTO `sys_role_menu` VALUES (1, 1202);
INSERT INTO `sys_role_menu` VALUES (1, 1203);
INSERT INTO `sys_role_menu` VALUES (1, 1300);
INSERT INTO `sys_role_menu` VALUES (1, 1301);
INSERT INTO `sys_role_menu` VALUES (1, 1302);
INSERT INTO `sys_role_menu` VALUES (1, 1303);
INSERT INTO `sys_role_menu` VALUES (1, 1304);
INSERT INTO `sys_role_menu` VALUES (1, 1400);
INSERT INTO `sys_role_menu` VALUES (1, 1401);
INSERT INTO `sys_role_menu` VALUES (1, 1402);
INSERT INTO `sys_role_menu` VALUES (1, 1403);
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2100);
INSERT INTO `sys_role_menu` VALUES (1, 2101);
INSERT INTO `sys_role_menu` VALUES (1, 2200);
INSERT INTO `sys_role_menu` VALUES (1, 2201);
INSERT INTO `sys_role_menu` VALUES (1, 2202);
INSERT INTO `sys_role_menu` VALUES (1, 2203);
INSERT INTO `sys_role_menu` VALUES (1, 2300);
INSERT INTO `sys_role_menu` VALUES (1, 2301);
INSERT INTO `sys_role_menu` VALUES (1, 2400);
INSERT INTO `sys_role_menu` VALUES (1, 2401);
INSERT INTO `sys_role_menu` VALUES (1, 2402);
INSERT INTO `sys_role_menu` VALUES (1, 2403);
INSERT INTO `sys_role_menu` VALUES (1, 2500);
INSERT INTO `sys_role_menu` VALUES (1, 3000);
INSERT INTO `sys_role_menu` VALUES (1, 3100);
INSERT INTO `sys_role_menu` VALUES (1, 3200);
INSERT INTO `sys_role_menu` VALUES (1, 3300);
INSERT INTO `sys_role_menu` VALUES (1, 3301);
INSERT INTO `sys_role_menu` VALUES (1, 3302);
INSERT INTO `sys_role_menu` VALUES (1, 3303);
INSERT INTO `sys_role_menu` VALUES (1, 3400);
INSERT INTO `sys_role_menu` VALUES (1, 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '随机盐',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '简介',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `dept_id` int(11) DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `lock_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '0-正常，9-锁定',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`user_id`),
  KEY `user_idx1_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$RpFJjxYiXdEsAGnWp/8fsOetMuOON96Ntk/Ym2M/RKRyU0GZseaDC', NULL, '17034642999', '', 1, '2018-04-20 07:15:18', '2019-01-31 14:29:07', '0', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES (1, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
