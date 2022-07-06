/*
 Navicat Premium Data Transfer

 Source Server         : localhost_for_docker
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 06/07/2022 13:09:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (6, 'qy_articles', '文章表', NULL, NULL, 'Articles', 'crud', 'xin.jiangqiang.blog', 'blog', 'articles', '文章新增', 'JiangQiang', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2022-05-21 14:55:10', '', '2022-06-22 09:25:44', NULL);
INSERT INTO `gen_table` VALUES (7, 'qy_attachments', '附件表', NULL, NULL, 'Attachments', 'crud', 'com.ruoyi.web', 'web', 'attachments', '附件', 'JiangQiang', '0', '/', NULL, 'admin', '2022-05-21 14:55:10', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (8, 'qy_categories', '文章分类表', NULL, NULL, 'Categories', 'crud', 'com.ruoyi.web', 'web', 'categories', '文章分类', 'JiangQiang', '0', '/', NULL, 'admin', '2022-05-21 14:55:10', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (9, 'qy_storages', '存储类型表', NULL, NULL, 'Storages', 'crud', 'xin.jiangqiang.netdisc', 'netdisc', 'storages', '存储类型', 'JiangQiang', '0', '/', '{\"parentMenuId\":\"2022\"}', 'admin', '2022-05-21 14:55:10', '', '2022-06-23 01:17:44', '存储类型配置');
INSERT INTO `gen_table` VALUES (10, 'qy_tags', '文章标签表', NULL, NULL, 'Tags', 'crud', 'com.ruoyi.web', 'web', 'tags', '文章标签', 'JiangQiang', '0', '/', NULL, 'admin', '2022-05-21 14:55:10', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (12, 'qy_files', '文件表', NULL, NULL, 'Files', 'crud', 'xin.jiangqiang.netdisc', 'netdisc', 'files', '文件', 'JiangQiang', '0', '/', '{}', 'admin', '2022-06-22 04:56:22', '', '2022-06-22 09:25:55', '文件存储表');

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 132 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (51, '6', 'article_id', '文章id', 'bigint', 'Long', 'articleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (54, '6', 'html_content', '文章html内容', 'longtext', 'String', 'htmlContent', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'editor', '', 4, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (55, '6', 'article_url', '文章固定链接', 'varchar(255)', 'String', 'articleUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (56, '6', 'category_id', '文章分类', 'bigint', 'Long', 'categoryId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (57, '6', 'tag_ids', '文章标签id组成的字符串', 'varchar(255)', 'String', 'tagIds', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (58, '6', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 8, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (59, '6', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 9, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (60, '6', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 10, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (61, '6', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', NULL, 11, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (62, '6', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', NULL, 12, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (63, '7', 'attachment_id', '附件id', 'bigint', 'Long', 'attachmentId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (64, '7', 'attachment_name', '附件名称，不包含后缀', 'varchar(255)', 'String', 'attachmentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (65, '7', 'suffix', '附件后缀', 'varchar(255)', 'String', 'suffix', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (66, '7', 'size', '附件大小', 'bigint', 'Long', 'size', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (67, '7', 'memdia_type', '附件传输类型', 'varchar(255)', 'String', 'memdiaType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (68, '7', 'storage_id', '存储类型id，OSS/本地', 'int', 'Long', 'storageId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (69, '7', 'upload_path', '服务端存储路径', 'varchar(500)', 'String', 'uploadPath', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (70, '7', 'file_key', 'URL访问路径，多数情况与存储路径一致', 'varchar(500)', 'String', 'fileKey', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 8, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (71, '7', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (72, '7', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (73, '7', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (74, '7', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (75, '7', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (76, '8', 'category_id', '分类主键', 'bigint', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (77, '8', 'category_name', '分类名称', 'varchar(255)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (78, '8', 'category_description', '分类描述', 'varchar(255)', 'String', 'categoryDescription', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (79, '8', 'parent_id', '父级分类id，顶级分类默认为0', 'bigint', 'Long', 'parentId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (80, '8', 'sort', '排序', 'int', 'Long', 'sort', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (81, '8', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (82, '8', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (83, '8', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (84, '8', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (85, '8', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (86, '9', 'storage_id', '存储类型id', 'bigint', 'Long', 'storageId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (87, '9', 'storage_name', '类型名称', 'varchar(255)', 'String', 'storageName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (88, '9', 'storage_config', '存储类型相关配置', 'varchar(500)', 'String', 'storageConfig', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (89, '9', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 4, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (90, '9', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 5, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (91, '9', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 6, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (92, '9', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', NULL, 7, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (93, '9', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', NULL, 8, 'admin', '2022-05-21 14:55:10', NULL, '2022-06-23 01:17:51');
INSERT INTO `gen_table_column` VALUES (94, '10', 'tag_id', '文章标签id', 'bigint', 'Long', 'tagId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (95, '10', 'tag_name', '标签名称', 'varchar(255)', 'String', 'tagName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (96, '10', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (97, '10', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 4, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (98, '10', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 5, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (99, '10', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (100, '10', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2022-05-21 14:55:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (111, '6', 'article_title', '文章标题', 'varchar(255)', 'String', 'articleTitle', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, '', '2022-06-20 14:43:38', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (112, '6', 'text_content', '文章原始内容', 'longtext', 'String', 'textContent', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', 3, '', '2022-06-21 02:57:43', NULL, '2022-06-22 09:25:44');
INSERT INTO `gen_table_column` VALUES (113, '12', 'file_id', '文件或目录id', 'bigint', 'Long', 'fileId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (114, '12', 'file_name', '文件或目录原始名称，不包含后缀', 'varchar(255)', 'String', 'fileName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (115, '12', 'suffix', '文件名后缀，不包含小数点', 'varchar(255)', 'String', 'suffix', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (116, '12', 'size', '文件大小', 'bigint', 'Long', 'size', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (118, '12', 'storage_id', '存储类型id，OSS/本地', 'int', 'Long', 'storageId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (119, '12', 'upload_path', '服务端存储路径', 'varchar(500)', 'String', 'uploadPath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (120, '12', 'file_key', '文件的唯一key', 'varchar(500)', 'String', 'fileKey', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 8, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (122, '12', 'parent_id', '父级目录id，如果为0则为根目录', 'bigint', 'Long', 'parentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (123, '12', 'is_public', '是否公开，1表示所有人可以访问，0表示需要访问权限', 'tinyint(1)', 'Integer', 'isPublic', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (124, '12', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 14, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (125, '12', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 15, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (126, '12', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 16, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (127, '12', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', NULL, 17, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (128, '12', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', NULL, 18, 'admin', '2022-06-22 04:56:22', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (129, '12', 'mime_type', '文件传输类型', 'varchar(255)', 'String', 'mimeType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 5, '', '2022-06-22 08:36:45', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (130, '12', 'is_dir', '是否为目录，0表示文件，1表示目录', 'tinyint(1)', 'Integer', 'isDir', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, '', '2022-06-22 08:40:15', NULL, '2022-06-29 06:50:44');
INSERT INTO `gen_table_column` VALUES (131, '12', 'random_key', '同一个目录下，不可重复', 'varchar(255)', 'String', 'randomKey', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, '', '2022-06-29 06:50:44', '', NULL);
INSERT INTO `gen_table_column` VALUES (132, '12', 'identifier', '文件摘要算法计算得出的唯一值', 'varchar(255)', 'String', 'identifier', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, '', '2022-06-29 06:50:44', '', NULL);

-- ----------------------------
-- Table structure for qy_articles
-- ----------------------------
DROP TABLE IF EXISTS `qy_articles`;
CREATE TABLE `qy_articles`  (
  `article_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `article_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文章标题',
  `text_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文章原始内容',
  `html_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文章html内容',
  `article_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '文章固定链接',
  `category_id` bigint NULL DEFAULT 0 COMMENT '文章分类',
  `tag_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '文章标签id组成的字符串',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qy_articles
-- ----------------------------
INSERT INTO `qy_articles` VALUES (2, '1', '12333\n\n2222222222222\n\n4444444444444\n', '12333\n2222222222222\n4444444444444\n', '11111111', 111111111, '111111111111', '0', 'admin', '2022-06-23 12:01:25', 'admin', '2022-06-23 11:57:40');
INSERT INTO `qy_articles` VALUES (3, '2', '2444\n\n22222222222222222\n', '2444\n22222222222222222\n', '2', 2, '222222222', '0', 'admin', '2022-06-23 12:01:25', 'admin', '2022-06-23 11:57:50');
INSERT INTO `qy_articles` VALUES (4, '3', '2444\n\n22222222222222222\n', '2444\n22222222222222222\n', '1', 3123, '12', '0', 'admin', '2022-06-23 12:01:25', 'admin', '2022-06-23 12:01:40');

-- ----------------------------
-- Table structure for qy_attachments
-- ----------------------------
DROP TABLE IF EXISTS `qy_attachments`;
CREATE TABLE `qy_attachments`  (
  `attachment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `attachment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '附件名称，不包含后缀',
  `suffix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '附件后缀',
  `size` bigint NOT NULL COMMENT '附件大小',
  `memdia_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '附件传输类型',
  `storage_id` int NULL DEFAULT NULL COMMENT '存储类型id，OSS/本地',
  `upload_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '服务端存储路径',
  `file_key` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'URL访问路径，多数情况与存储路径一致',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`attachment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '附件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qy_attachments
-- ----------------------------

-- ----------------------------
-- Table structure for qy_categories
-- ----------------------------
DROP TABLE IF EXISTS `qy_categories`;
CREATE TABLE `qy_categories`  (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类主键',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '分类名称',
  `category_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '分类描述',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父级分类id，顶级分类默认为0',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '文章分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qy_categories
-- ----------------------------

-- ----------------------------
-- Table structure for qy_files
-- ----------------------------
DROP TABLE IF EXISTS `qy_files`;
CREATE TABLE `qy_files`  (
  `file_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件或目录id',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文件或目录原始名称，不包含后缀',
  `suffix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '文件名后缀，不包含小数点',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小',
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文件传输类型',
  `storage_id` int NOT NULL COMMENT '存储类型id，OSS/本地',
  `upload_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '服务端存储路径',
  `file_key` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文件的唯一key',
  `is_dir` tinyint(1) NOT NULL COMMENT '是否为目录，0表示文件，1表示目录',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父级目录id，如果为0则为根目录，-1为博客系统默认上传目录',
  `random_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '同一个目录下，不可重复',
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文件摘要算法计算得出的唯一值',
  `is_public` tinyint(1) NOT NULL COMMENT '是否公开，1表示所有人可以访问，0表示需要访问权限',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2950 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qy_files
-- ----------------------------
INSERT INTO `qy_files` VALUES (1, '默认文件夹', '', NULL, NULL, 1, NULL, '1', 1, -1, NULL, NULL, 0, '0', '', NULL, '', NULL);
INSERT INTO `qy_files` VALUES (2915, '1', '', NULL, NULL, 1, NULL, '165649672371259952', 1, 0, '16564967231033655175205', NULL, 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2916, '3', 'txt', 0, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649672370318408.txt', 0, 2915, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2917, '2', '', NULL, NULL, 1, NULL, '165649672379527351', 1, 2915, NULL, NULL, 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2918, '3', '', NULL, NULL, 1, NULL, '165649672380936139', 1, 2917, NULL, NULL, 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2919, '4', '', NULL, NULL, 1, NULL, '165649672382396730', 1, 2918, NULL, NULL, 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2920, '2', 'txt', 0, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649672378340171.txt', 0, 2919, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2921, '1', 'txt', 0, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649672378395044.txt', 0, 2919, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2922, '4', 'txt', 0, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649672378390028.txt', 0, 2917, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 17:58:44', '', NULL);
INSERT INTO `qy_files` VALUES (2923, 'role_script_00001', '', NULL, NULL, 1, NULL, '165649681188077473', 1, 0, '16564968111464324534154', NULL, 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2924, 'task', '', NULL, NULL, 1, NULL, '165649681189314656', 1, 2923, NULL, NULL, 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2925, '0001', 'txt', 465, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681186848594.txt', 0, 2924, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2926, 'arrange', 'txt', 40, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681186829125.txt', 0, 2923, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2927, '0002', 'txt', 70, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681217456404.txt', 0, 2924, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2928, '0003', 'txt', 70, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681219487653.txt', 0, 2924, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2929, 'catalogue', 'txt', 1487, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681219315928.txt', 0, 2923, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2930, 'catalogue - 副本', 'txt', 1487, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681217821638.txt', 0, 2923, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2931, '0005', 'txt', 70, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681226951880.txt', 0, 2924, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2932, '0004', 'txt', 70, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681225948117.txt', 0, 2924, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:12', '', NULL);
INSERT INTO `qy_files` VALUES (2933, 'role', '', NULL, NULL, 1, NULL, '165649681254550676', 1, 2923, NULL, NULL, 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2934, '0001', 'txt', 645, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681253607587.txt', 0, 2933, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2935, '0002', 'txt', 2263, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681257320456.txt', 0, 2933, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2936, '0003', 'txt', 71, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681296764249.txt', 0, 2933, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2937, 'clue', '', NULL, NULL, 1, NULL, '165649681329041908', 1, 2923, NULL, NULL, 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2938, '0004', 'txt', 981, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681326215033.txt', 0, 2933, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2939, '0005', 'txt', 71, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681326184763.txt', 0, 2933, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2940, '0002', 'txt', 4905, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681328437666.txt', 0, 2937, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2941, '0001', 'txt', 71, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681326196333.txt', 0, 2937, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2942, '0003', 'txt', 71, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681334263815.txt', 0, 2937, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:13', '', NULL);
INSERT INTO `qy_files` VALUES (2943, '0004', 'txt', 1485, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681354612044.txt', 0, 2937, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);
INSERT INTO `qy_files` VALUES (2944, '0005', 'txt', 1485, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681363784253.txt', 0, 2937, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);
INSERT INTO `qy_files` VALUES (2945, 'chapter', '', NULL, NULL, 1, NULL, '165649681367114065', 1, 2923, NULL, NULL, 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);
INSERT INTO `qy_files` VALUES (2946, '0001', 'txt', 13879, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681365869801.txt', 0, 2945, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);
INSERT INTO `qy_files` VALUES (2947, '0002', 'txt', 20633, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681368644983.txt', 0, 2945, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);
INSERT INTO `qy_files` VALUES (2948, '0003', 'txt', 2137, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681399341324.txt', 0, 2945, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);
INSERT INTO `qy_files` VALUES (2949, '0004', 'txt', 9183, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681403252387.txt', 0, 2945, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);
INSERT INTO `qy_files` VALUES (2950, '0005', 'txt', 694, 'text/plain', 1, 'D:\\tmp\\ruoyi\\uploadPath', '165649681422731517.txt', 0, 2945, NULL, 'd41d8cd98f00b204e9800998ecf8427e', 0, '0', 'admin', '2022-06-29 18:00:14', '', NULL);

-- ----------------------------
-- Table structure for qy_storages
-- ----------------------------
DROP TABLE IF EXISTS `qy_storages`;
CREATE TABLE `qy_storages`  (
  `storage_id` bigint NOT NULL AUTO_INCREMENT COMMENT '存储类型id',
  `storage_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '类型名称',
  `storage_config` json NULL COMMENT '存储类型相关配置',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`storage_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qy_storages
-- ----------------------------
INSERT INTO `qy_storages` VALUES (1, '本地存储', NULL, '0', '', NULL, NULL, NULL);
INSERT INTO `qy_storages` VALUES (2, '阿里云OSS', '{\"endPoint\": \"\", \"bucketName\": \"\", \"accessKeyId\": \"\", \"accessKeySecret\": \"\"}', '0', '', NULL, NULL, NULL);
INSERT INTO `qy_storages` VALUES (3, '腾讯云COS', '{\"endPoint\": \"\", \"bucketName\": \"\", \"accessKeyId\": \"\", \"accessKeySecret\": \"\"}', '0', '', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for qy_tags
-- ----------------------------
DROP TABLE IF EXISTS `qy_tags`;
CREATE TABLE `qy_tags`  (
  `tag_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章标签id',
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标签名称',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '文章标签表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qy_tags
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-05-21 05:51:20', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-05-21 05:51:20', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-05-21 05:51:20', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2022-05-21 05:51:20', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-05-21 05:51:20', '', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-05-21 05:51:20', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-05-21 05:51:19', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-05-21 05:51:20', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-05-21 05:51:20', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-05-21 05:51:20', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 206 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-21 05:52:09');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 05:52:12');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-21 05:52:42');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 05:52:51');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-21 06:08:52');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', 'java.security.InvalidKeyException: Invalid RSA private key', '2022-05-21 06:09:10');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 06:10:26');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-21 06:50:18');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-21 06:50:32');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-21 06:52:30');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 06:53:03');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-21 06:55:52');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 06:56:01');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-21 07:08:39');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 07:08:45');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 09:38:55');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 14:32:38');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-22 00:22:18');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '47.99.243.2', 'XX XX', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-22 05:25:27');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-22 05:27:16');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-17 07:29:28');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-17 07:30:02');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-17 07:30:09');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-17 07:35:59');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-17 07:36:45');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-17 08:42:02');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-17 09:18:03');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-17 09:18:09');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-17 09:29:25');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-17 09:29:33');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 02:18:22');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 08:30:53');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 09:19:48');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-19 09:27:58');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 09:28:42');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 13:23:59');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-19 13:30:19');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 13:30:44');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 14:13:59');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-19 14:44:45');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 00:51:20');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 05:24:14');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 08:38:10');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-20 08:38:14');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 08:50:16');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-20 08:50:22');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 09:16:42');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-20 09:16:47');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 09:21:57');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-20 09:22:01');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 09:24:16');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-20 14:43:29');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-21 01:54:59');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-21 06:27:27');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-22 03:25:38');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-22 04:30:30');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-22 05:29:26');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-22 08:36:35');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-23 01:16:13');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-23 02:37:49');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-23 03:32:43');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-23 08:34:54');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-23 10:23:26');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-24 05:21:01');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-24 06:35:24');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-24 08:46:56');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-24 09:21:22');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-24 11:10:36');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-24 12:34:22');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-25 01:57:49');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-25 04:46:28');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-25 06:57:24');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-25 07:51:59');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-26 01:36:52');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-26 02:38:47');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-26 04:52:46');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-26 06:00:43');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-26 06:00:59');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-26 07:06:15');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-27 07:49:28');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-27 08:23:52');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-27 10:25:00');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-27 11:27:51');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-28 10:15:35');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-28 10:31:49');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-28 10:36:47');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-28 10:46:13');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-28 10:46:23');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-28 10:47:51');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-28 10:49:33');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-28 10:49:59');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-29 01:03:29');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-29 01:53:11');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-29 01:53:16');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-29 01:55:43');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-29 01:55:58');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-29 01:56:01');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-29 01:56:11');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-29 01:56:17');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-29 01:56:23');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-29 02:10:59');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-29 03:18:12');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-29 03:18:24');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-30 01:17:14');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-30 01:54:03');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-30 05:35:00');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-30 06:54:09');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2024 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-05-21 05:51:18', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 4, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-05-21 05:51:18', 'admin', '2022-05-22 05:30:07', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 5, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-05-21 05:51:18', 'admin', '2022-05-22 05:28:48', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-05-21 05:51:18', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-05-21 05:51:18', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-05-21 05:51:18', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-05-21 05:51:18', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-05-21 05:51:18', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-05-21 05:51:18', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-05-21 05:51:18', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-05-21 05:51:18', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-05-21 05:51:18', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-05-21 05:51:18', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-05-21 05:51:18', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-05-21 05:51:18', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-05-21 05:51:18', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-05-21 05:51:18', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-05-21 05:51:18', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-05-21 05:51:18', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-05-21 05:51:18', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-05-21 05:51:18', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-05-21 05:51:18', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-05-21 05:51:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '博客管理', 0, 3, 'blog', NULL, NULL, 1, 0, 'M', '0', '0', '', 'list', 'admin', '2022-05-21 14:58:51', 'admin', '2022-05-22 05:30:03', '');
INSERT INTO `sys_menu` VALUES (2001, '文章分类', 2000, 1, 'category', NULL, NULL, 1, 0, 'C', '0', '0', '', '#', 'admin', '2022-05-21 15:01:18', 'admin', '2022-05-21 15:01:59', '');
INSERT INTO `sys_menu` VALUES (2002, '文章标签', 2000, 2, 'tag', NULL, NULL, 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2022-05-21 15:01:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '附件管理', 2000, 4, 'attachment', NULL, NULL, 1, 0, 'M', '0', '0', NULL, '#', 'admin', '2022-05-21 15:04:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '博客设置', 2000, 5, 'setting', NULL, NULL, 1, 0, 'C', '0', '0', '', '#', 'admin', '2022-05-21 15:06:39', 'admin', '2022-05-21 15:06:46', '');
INSERT INTO `sys_menu` VALUES (2016, '文章管理', 2000, 1, 'articles', 'blog/articles/index', NULL, 1, 0, 'C', '0', '0', 'blog:articles:list', '#', 'admin', '2022-06-17 09:27:53', 'admin', '2022-06-21 09:45:57', '文章新增菜单');
INSERT INTO `sys_menu` VALUES (2017, '文章查询', 2016, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'blog:articles:query', '#', 'admin', '2022-06-17 09:27:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '文章新增', 2016, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'blog:articles:add', '#', 'admin', '2022-06-17 09:27:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '文章修改', 2016, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'blog:articles:edit', '#', 'admin', '2022-06-17 09:27:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '文章删除', 2016, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'blog:articles:remove', '#', 'admin', '2022-06-17 09:27:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '文章导出', 2016, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'blog:articles:export', '#', 'admin', '2022-06-17 09:27:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '网盘管理', 0, 2, 'netdisk', NULL, NULL, 1, 0, 'M', '0', '0', '', 'form', 'admin', '2022-06-22 05:41:00', 'admin', '2022-06-22 05:42:44', '');
INSERT INTO `sys_menu` VALUES (2023, '文件目录', 2022, 1, 'dir', 'net-disc/index', NULL, 1, 0, 'C', '0', '0', '', '#', 'admin', '2022-06-22 05:42:18', 'admin', '2022-06-23 08:37:33', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-05-21 05:51:20', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-05-21 05:51:20', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 314 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_articles,qy_attachments,qy_categories,qy_storages,qy_tags', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 14:39:32');
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/1,2,3,4,5', '127.0.0.1', '内网IP', '{tableIds=1,2,3,4,5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 14:54:56');
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_articles,qy_attachments,qy_categories,qy_storages,qy_tags', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 14:55:10');
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":3,\"menuName\":\"博客管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"blog\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 14:58:51');
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"list\",\"orderNum\":3,\"menuName\":\"博客管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"blog\",\"children\":[],\"createTime\":1653116331000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2000,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 14:59:54');
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":1,\"menuName\":\"文章分类\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"category\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:01:18');
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":2,\"menuName\":\"文章标签\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"tag\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:01:52');
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":1,\"menuName\":\"文章分类\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"category\",\"children\":[],\"createTime\":1653116478000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2001,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:01:59');
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":3,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"article\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:03:24');
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":4,\"menuName\":\"附件管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"attachment\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:04:29');
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":5,\"menuName\":\"博客设置\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"setting\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:06:39');
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":5,\"menuName\":\"博客设置\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"setting\",\"children\":[],\"createTime\":1653116799000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2005,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:06:46');
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"guide\",\"orderNum\":4,\"menuName\":\"若依官网\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"http://ruoyi.vip\",\"children\":[],\"createTime\":1653083478000,\"updateBy\":\"admin\",\"isFrame\":\"0\",\"menuId\":4,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:07:07');
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":0,\"menuName\":\"000\",\"params\":{},\"parentId\":4,\"isCache\":\"0\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"F\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:07:30');
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2006', '127.0.0.1', '内网IP', '{menuId=2006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:07:44');
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-05-21 15:07:47');
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"guide\",\"orderNum\":4,\"menuName\":\"若依官网\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"http://ruoyi.vip\",\"children\":[],\"createTime\":1653083478000,\"updateBy\":\"admin\",\"isFrame\":\"0\",\"menuId\":4,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:07:54');
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-05-21 15:07:57');
INSERT INTO `sys_oper_log` VALUES (118, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"普通角色\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1653083478000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"menuIds\":[1,100,1001,1002,1003,1004,1005,1006,1007,101,1008,1009,1010,1011,1012,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,108,500,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116,2000,2001,2002,2003,2004,2005],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:08:10');
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 15:08:17');
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":5,\"menuName\":\"微信管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:28:11');
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":3,\"menuName\":\"微信管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"children\":[],\"createTime\":1653168491000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:28:32');
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"tool\",\"orderNum\":5,\"menuName\":\"系统工具\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"tool\",\"children\":[],\"createTime\":1653083478000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":3,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:28:48');
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"list\",\"orderNum\":4,\"menuName\":\"博客管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"blog\",\"children\":[],\"createTime\":1653116331000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2000,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:28:52');
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"monitor\",\"orderNum\":5,\"menuName\":\"系统监控\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"monitor\",\"children\":[],\"createTime\":1653083478000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:29:51');
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":2,\"menuName\":\"微信管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"children\":[],\"createTime\":1653168491000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:29:59');
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"list\",\"orderNum\":3,\"menuName\":\"博客管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"blog\",\"children\":[],\"createTime\":1653116331000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2000,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:30:03');
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"monitor\",\"orderNum\":4,\"menuName\":\"系统监控\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"monitor\",\"children\":[],\"createTime\":1653083478000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:30:07');
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":2,\"menuName\":\"微信管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"component\":\"公众号配置\",\"children\":[],\"createTime\":1653168491000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"C\",\"perms\":\"config\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:30:39');
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":2,\"menuName\":\"公众号列表\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"component\":\"\",\"children\":[],\"createTime\":1653168491000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"C\",\"perms\":\"config\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:31:18');
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":2,\"menuName\":\"公众号运营\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"component\":\"\",\"children\":[],\"createTime\":1653168491000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"C\",\"perms\":\"config\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:31:34');
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":1,\"menuName\":\"公众号配置\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"path\":\"config\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:32:55');
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":2,\"menuName\":\"菜单管理\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"path\":\"menu\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:33:20');
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":2,\"menuName\":\"公众号运营\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"component\":\"\",\"children\":[],\"createTime\":1653168491000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:33:56');
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"wechat\",\"orderNum\":2,\"menuName\":\"公众号运营\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"wx\",\"component\":\"\",\"children\":[],\"createTime\":1653168491000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:34:22');
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"system\",\"orderNum\":1,\"menuName\":\"公众号配置\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"path\":\"config\",\"children\":[],\"createTime\":1653168775000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2008,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:36:55');
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"example\",\"orderNum\":2,\"menuName\":\"菜单管理\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"path\":\"menu\",\"children\":[],\"createTime\":1653168800000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2009,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:37:08');
INSERT INTO `sys_oper_log` VALUES (137, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_wx_configs', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:49:15');
INSERT INTO `sys_oper_log` VALUES (138, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"ConfigId\",\"usableColumn\":false,\"columnId\":101,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"configId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"配置id\",\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653169755000,\"tableId\":11,\"pk\":true,\"columnName\":\"config_id\"},{\"capJavaField\":\"AppId\",\"usableColumn\":false,\"columnId\":102,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appId\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"公众号AppID\",\"isQuery\":\"1\",\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653169755000,\"isEdit\":\"1\",\"tableId\":11,\"pk\":false,\"columnName\":\"app_id\"},{\"capJavaField\":\"AppSecret\",\"usableColumn\":false,\"columnId\":103,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appSecret\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"公众号appSecret\",\"isQuery\":\"1\",\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653169755000,\"isEdit\":\"1\",\"tableId\":11,\"pk\":false,\"columnName\":\"app_secret\"},{\"capJavaField\":\"EncodingAesKey\",\"usableColumn\":false,\"columnId\":104,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"encodingAesKey\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"公众号encodingAESKey\",\"isQuery\":\"1\",\"sort\":4,\"list\":true,\"params\":{},\"ja', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-22 05:50:13');
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2009', '127.0.0.1', '内网IP', '{menuId=2009}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 07:37:56');
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2008', '127.0.0.1', '内网IP', '{menuId=2008}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 07:38:02');
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2007', '127.0.0.1', '内网IP', '{menuId=2007}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 07:38:06');
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/11', '127.0.0.1', '内网IP', '{tableIds=11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 08:50:34');
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_articles', '127.0.0.1', '内网IP', '{tableName=qy_articles}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 08:50:41');
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-17 08:50:50');
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-17 08:50:53');
INSERT INTO `sys_oper_log` VALUES (146, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"ArticleId\",\"usableColumn\":false,\"columnId\":51,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"articleId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文章id\",\"updateTime\":1655427041000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":6,\"pk\":true,\"columnName\":\"article_id\"},{\"capJavaField\":\"StorageTitle\",\"usableColumn\":false,\"columnId\":52,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"storageTitle\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文章标题\",\"isQuery\":\"1\",\"updateTime\":1655427041000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"storage_title\"},{\"capJavaField\":\"OriginalContent\",\"usableColumn\":false,\"columnId\":53,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"originalContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章原始内容\",\"isQuery\":\"1\",\"updateTime\":1655427041000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"longtext\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"original_content\"},{\"capJavaField\":\"HtmlContent\",\"usableColumn\":false,\"columnId\":54,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"htmlContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章html内容\",\"isQuery\":\"1\",\"updateTime\":1655427041000,\"sor', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 08:59:36');
INSERT INTO `sys_oper_log` VALUES (147, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-17 08:59:50');
INSERT INTO `sys_oper_log` VALUES (148, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-17 08:59:51');
INSERT INTO `sys_oper_log` VALUES (149, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-17 09:00:14');
INSERT INTO `sys_oper_log` VALUES (150, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"ArticleId\",\"usableColumn\":false,\"columnId\":51,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"articleId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文章id\",\"updateTime\":1655427576000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":6,\"pk\":true,\"columnName\":\"article_id\"},{\"capJavaField\":\"StorageTitle\",\"usableColumn\":false,\"columnId\":52,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"storageTitle\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文章标题\",\"isQuery\":\"1\",\"updateTime\":1655427576000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"storage_title\"},{\"capJavaField\":\"OriginalContent\",\"usableColumn\":false,\"columnId\":53,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"originalContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章原始内容\",\"isQuery\":\"1\",\"updateTime\":1655427576000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"longtext\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"original_content\"},{\"capJavaField\":\"HtmlContent\",\"usableColumn\":false,\"columnId\":54,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"htmlContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章html内容\",\"isQuery\":\"1\",\"updateTime\":1655427576000,\"sor', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:01:45');
INSERT INTO `sys_oper_log` VALUES (151, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-17 09:01:49');
INSERT INTO `sys_oper_log` VALUES (152, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"ArticleId\",\"usableColumn\":false,\"columnId\":51,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"articleId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文章id\",\"updateTime\":1655427704000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":6,\"pk\":true,\"columnName\":\"article_id\"},{\"capJavaField\":\"StorageTitle\",\"usableColumn\":false,\"columnId\":52,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"storageTitle\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文章标题\",\"isQuery\":\"1\",\"updateTime\":1655427704000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"storage_title\"},{\"capJavaField\":\"OriginalContent\",\"usableColumn\":false,\"columnId\":53,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"originalContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章原始内容\",\"isQuery\":\"1\",\"updateTime\":1655427704000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"longtext\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"original_content\"},{\"capJavaField\":\"HtmlContent\",\"usableColumn\":false,\"columnId\":54,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"htmlContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章html内容\",\"isQuery\":\"1\",\"updateTime\":1655427704000,\"sor', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:08:21');
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":3,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"article\",\"children\":[],\"createTime\":1653116604000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2003,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:18:41');
INSERT INTO `sys_oper_log` VALUES (154, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"ArticleId\",\"usableColumn\":false,\"columnId\":51,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"articleId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文章id\",\"updateTime\":1655428101000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":6,\"pk\":true,\"columnName\":\"article_id\"},{\"capJavaField\":\"StorageTitle\",\"usableColumn\":false,\"columnId\":52,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"storageTitle\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文章标题\",\"isQuery\":\"1\",\"updateTime\":1655428101000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"storage_title\"},{\"capJavaField\":\"OriginalContent\",\"usableColumn\":false,\"columnId\":53,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"originalContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章原始内容\",\"isQuery\":\"1\",\"updateTime\":1655428101000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"longtext\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"original_content\"},{\"capJavaField\":\"HtmlContent\",\"usableColumn\":false,\"columnId\":54,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"htmlContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章html内容\",\"isQuery\":\"1\",\"updateTime\":1655428101000,\"sor', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:20:29');
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":1,\"menuName\":\"文章新增\",\"params\":{},\"parentId\":2003,\"isCache\":\"0\",\"path\":\"articles\",\"component\":\"blog/articles/index\",\"children\":[],\"createTime\":1655427772000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2010,\"menuType\":\"C\",\"perms\":\"web:articles:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:21:51');
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2010', '127.0.0.1', '内网IP', '{menuId=2010}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', 0, NULL, '2022-06-17 09:24:29');
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2015', '127.0.0.1', '内网IP', '{menuId=2015}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:24:33');
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2014', '127.0.0.1', '内网IP', '{menuId=2014}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:24:36');
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2012', '127.0.0.1', '内网IP', '{menuId=2012}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:24:38');
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2011', '127.0.0.1', '内网IP', '{menuId=2011}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:24:43');
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2013', '127.0.0.1', '内网IP', '{menuId=2013}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:24:45');
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2010', '127.0.0.1', '内网IP', '{menuId=2010}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:24:49');
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2003', '127.0.0.1', '内网IP', '{menuId=2003}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-06-17 09:28:43');
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2003', '127.0.0.1', '内网IP', '{menuId=2003}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-06-17 09:28:49');
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2003', '127.0.0.1', '内网IP', '{menuId=2003}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-06-17 09:29:47');
INSERT INTO `sys_oper_log` VALUES (166, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":3,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"article\",\"children\":[],\"createTime\":1653116604000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2003,\"menuType\":\"F\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:30:05');
INSERT INTO `sys_oper_log` VALUES (167, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2003', '127.0.0.1', '内网IP', '{menuId=2003}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-06-17 09:30:10');
INSERT INTO `sys_oper_log` VALUES (168, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"普通角色\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1653083478000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"menuIds\":[1,100,1001,1002,1003,1004,1005,1006,1007,101,1008,1009,1010,1011,1012,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,108,500,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:30:30');
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2003', '127.0.0.1', '内网IP', '{menuId=2003}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:30:36');
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":1,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"articles\",\"component\":\"blog/articles/index\",\"children\":[],\"createTime\":1655429273000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2016,\"menuType\":\"C\",\"perms\":\"blog:articles:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-17 09:30:54');
INSERT INTO `sys_oper_log` VALUES (171, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"123\",\"tagIds\":\"23414\",\"params\":{},\"articleUrl\":\"123\",\"categoryId\":234,\"originalContent\":\"<p>213123</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-19 13:24:18');
INSERT INTO `sys_oper_log` VALUES (172, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"123\",\"tagIds\":\"23414\",\"params\":{},\"articleUrl\":\"123\",\"categoryId\":234,\"originalContent\":\"<p>213123</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-19 13:25:13');
INSERT INTO `sys_oper_log` VALUES (173, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"123\",\"tagIds\":\"23414\",\"params\":{},\"articleUrl\":\"123\",\"categoryId\":234,\"originalContent\":\"<p>213123</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-19 13:25:42');
INSERT INTO `sys_oper_log` VALUES (174, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"231\",\"tagIds\":\"3123\",\"params\":{},\"articleUrl\":\"123123\",\"categoryId\":12333321,\"originalContent\":\"<p>3123213123</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-19 15:02:11');
INSERT INTO `sys_oper_log` VALUES (175, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"231\",\"tagIds\":\"3123\",\"params\":{},\"articleUrl\":\"123123\",\"categoryId\":12333321,\"originalContent\":\"<p>3123213123</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-19 15:02:19');
INSERT INTO `sys_oper_log` VALUES (176, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"231\",\"tagIds\":\"3123\",\"params\":{},\"articleUrl\":\"123123\",\"categoryId\":12333321,\"originalContent\":\"<p>3123213123</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-19 15:04:26');
INSERT INTO `sys_oper_log` VALUES (177, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"1\",\"tagIds\":\"5\",\"params\":{},\"articleUrl\":\"3\",\"categoryId\":4,\"originalContent\":\"<p>2</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-20 00:52:14');
INSERT INTO `sys_oper_log` VALUES (178, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"1\",\"tagIds\":\"5\",\"params\":{},\"articleUrl\":\"3\",\"categoryId\":4,\"originalContent\":\"<p>2</p>\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/system/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve com.ruoyi.system.mapper.ArticlesMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-06-20 00:52:22');
INSERT INTO `sys_oper_log` VALUES (179, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"1\",\"tagIds\":\"3\",\"articleId\":1,\"params\":{},\"articleUrl\":\"2\",\"categoryId\":2,\"originalContent\":\"<p>11</p>\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-20 01:02:08');
INSERT INTO `sys_oper_log` VALUES (180, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"1\",\"tagIds\":\"3\",\"articleId\":1,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2,\"originalContent\":\"<p>113333333</p>\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-20 01:02:17');
INSERT INTO `sys_oper_log` VALUES (181, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"storageTitle\":\"1\",\"tagIds\":\"3\",\"articleId\":1,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2,\"originalContent\":\"<p>113333333<img src=\\\"/dev-api/profile/upload/2022/06/20/000002_tp_cyf04_20220620090516A001.png\\\"></p>\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-20 01:05:20');
INSERT INTO `sys_oper_log` VALUES (182, '文章新增', 3, 'com.ruoyi.web.controller.blog.ArticlesController.remove()', 'DELETE', 1, 'admin', NULL, '/web/articles/1', '127.0.0.1', '内网IP', '{articleIds=1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-20 10:43:35');
INSERT INTO `sys_oper_log` VALUES (183, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_articles', '127.0.0.1', '内网IP', '{tableName=qy_articles}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-20 14:43:38');
INSERT INTO `sys_oper_log` VALUES (184, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"223123123\",\"tagIds\":\"333333333333333\",\"articleId\":2,\"params\":{},\"articleUrl\":\"33333333\",\"htmlContent\":\"<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:10:47');
INSERT INTO `sys_oper_log` VALUES (185, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"223123123\",\"tagIds\":\"333333333333333\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"33333333\",\"htmlContent\":\"<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333额</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231额332</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>2222222223133333333333333333333333333333</p>\\n<p>qw</p>\\n<p>sddddddd2ddddddd21231232231231</p>\\n<p>22222222231333333333333333', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:13:07');
INSERT INTO `sys_oper_log` VALUES (186, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"223123123\",\"tagIds\":\"333333333333333\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"33333333\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":333333333333333}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:19:00');
INSERT INTO `sys_oper_log` VALUES (187, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"223123123\",\"tagIds\":\"333333333333333\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"33333333\",\"htmlContent\":\"<p>1213</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":333333333333333,\"originalContent\":\"1213\\n\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:23:15');
INSERT INTO `sys_oper_log` VALUES (188, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"223123123\",\"tagIds\":\"333333333333333\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"33333333\",\"htmlContent\":\"<p>22222222222222</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":333333333333333,\"originalContent\":\"22222222222222\\n\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:23:38');
INSERT INTO `sys_oper_log` VALUES (189, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"223123123\",\"tagIds\":\"333333333333333\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"33333333\",\"htmlContent\":\"<p>钱钱钱钱钱钱群群群</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":333333333333333,\"originalContent\":\"钱钱钱钱钱钱群群群\\n\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:25:14');
INSERT INTO `sys_oper_log` VALUES (190, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"11111111111111\",\"articleId\":3,\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"<p>11111111</p>\\n\",\"categoryId\":1,\"originalContent\":\"11111111\\n\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:28:19');
INSERT INTO `sys_oper_log` VALUES (191, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"11111111111111\",\"articleId\":3,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"<p>11111</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":1,\"originalContent\":\"11111\\n\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:53:30');
INSERT INTO `sys_oper_log` VALUES (192, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"223123123\",\"tagIds\":\"333333333333333\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"33333333\",\"htmlContent\":\"<p>11111</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":333333333333333,\"originalContent\":\"11111\\n\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:53:40');
INSERT INTO `sys_oper_log` VALUES (193, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_articles', '127.0.0.1', '内网IP', '{tableName=qy_articles}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 02:57:43');
INSERT INTO `sys_oper_log` VALUES (194, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 03:02:35');
INSERT INTO `sys_oper_log` VALUES (195, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"11111\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>11111</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 03:02:45');
INSERT INTO `sys_oper_log` VALUES (196, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:13:32');
INSERT INTO `sys_oper_log` VALUES (197, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"22222\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>222</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:13:35');
INSERT INTO `sys_oper_log` VALUES (198, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:14:00');
INSERT INTO `sys_oper_log` VALUES (199, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:14:12');
INSERT INTO `sys_oper_log` VALUES (200, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:14:32');
INSERT INTO `sys_oper_log` VALUES (201, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:14:39');
INSERT INTO `sys_oper_log` VALUES (202, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:14:42');
INSERT INTO `sys_oper_log` VALUES (203, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:15:36');
INSERT INTO `sys_oper_log` VALUES (204, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:16:52');
INSERT INTO `sys_oper_log` VALUES (205, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:18:46');
INSERT INTO `sys_oper_log` VALUES (206, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:19:18');
INSERT INTO `sys_oper_log` VALUES (207, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:19:55');
INSERT INTO `sys_oper_log` VALUES (208, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:20:01');
INSERT INTO `sys_oper_log` VALUES (209, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:20:18');
INSERT INTO `sys_oper_log` VALUES (210, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:21:11');
INSERT INTO `sys_oper_log` VALUES (211, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:21:32');
INSERT INTO `sys_oper_log` VALUES (212, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:22:51');
INSERT INTO `sys_oper_log` VALUES (213, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:22:55');
INSERT INTO `sys_oper_log` VALUES (214, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:23:36');
INSERT INTO `sys_oper_log` VALUES (215, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:24:58');
INSERT INTO `sys_oper_log` VALUES (216, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\\n123123\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:25:07');
INSERT INTO `sys_oper_log` VALUES (217, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"22222\\n\\n234234\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:26:28');
INSERT INTO `sys_oper_log` VALUES (218, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\\n123123312\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 04:41:41');
INSERT INTO `sys_oper_log` VALUES (219, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\\n123123312\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 05:04:27');
INSERT INTO `sys_oper_log` VALUES (220, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\\n123123312\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 05:04:32');
INSERT INTO `sys_oper_log` VALUES (221, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\\n123123312\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 05:05:07');
INSERT INTO `sys_oper_log` VALUES (222, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\\n123123312\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 05:06:21');
INSERT INTO `sys_oper_log` VALUES (223, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"11111\\n\\n123123312\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 07:51:37');
INSERT INTO `sys_oper_log` VALUES (224, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>1</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:34:32');
INSERT INTO `sys_oper_log` VALUES (225, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:36:37');
INSERT INTO `sys_oper_log` VALUES (226, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:36:53');
INSERT INTO `sys_oper_log` VALUES (227, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>1</p>\\n<p>22222222222222222222233333333333333344444444444444444444444444444444444444444444</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:42:35');
INSERT INTO `sys_oper_log` VALUES (228, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>&lt;22</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:44:09');
INSERT INTO `sys_oper_log` VALUES (229, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>eee</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:46:47');
INSERT INTO `sys_oper_log` VALUES (230, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>1</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:52:17');
INSERT INTO `sys_oper_log` VALUES (231, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:52:20');
INSERT INTO `sys_oper_log` VALUES (232, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>1</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:52:39');
INSERT INTO `sys_oper_log` VALUES (233, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>111</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:53:28');
INSERT INTO `sys_oper_log` VALUES (234, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>111</p>\\n<p>222</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:53:42');
INSERT INTO `sys_oper_log` VALUES (235, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>111</p>\\n<p>222</p>\\n<p>1</p>\\n<p>22</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:54:34');
INSERT INTO `sys_oper_log` VALUES (236, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>1</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:55:35');
INSERT INTO `sys_oper_log` VALUES (237, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>1</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:57:19');
INSERT INTO `sys_oper_log` VALUES (238, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>1</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:57:36');
INSERT INTO `sys_oper_log` VALUES (239, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>123</p>\\n<p>4</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 08:59:33');
INSERT INTO `sys_oper_log` VALUES (240, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:03:02');
INSERT INTO `sys_oper_log` VALUES (241, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>11111</p>\\n<p>123123312</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:03:11');
INSERT INTO `sys_oper_log` VALUES (242, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>22222</p>\\n<p>234234</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:03:18');
INSERT INTO `sys_oper_log` VALUES (243, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"12\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>12</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:04:59');
INSERT INTO `sys_oper_log` VALUES (244, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"12333\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>12333</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:05:07');
INSERT INTO `sys_oper_log` VALUES (245, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"2444\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>2444</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:05:12');
INSERT INTO `sys_oper_log` VALUES (246, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>2444</p>\\n<p>22222222222222222</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:13:04');
INSERT INTO `sys_oper_log` VALUES (247, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"12333\\n\\n2222222222222\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>12333</p>\\n<p>2222222222222</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:13:08');
INSERT INTO `sys_oper_log` VALUES (248, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/web/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"12333\\n\\n2222222222222\\n\\n4444444444444\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"<p>12333</p>\\n<p>2222222222222</p>\\n<p>4444444444444</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:13:14');
INSERT INTO `sys_oper_log` VALUES (249, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"ArticleId\",\"usableColumn\":false,\"columnId\":51,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"articleId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文章id\",\"updateTime\":1655751463000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":6,\"pk\":true,\"columnName\":\"article_id\"},{\"capJavaField\":\"ArticleTitle\",\"usableColumn\":false,\"columnId\":111,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"articleTitle\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文章标题\",\"isQuery\":\"1\",\"updateTime\":1655751463000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"\",\"isPk\":\"0\",\"createTime\":1655707418000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"article_title\"},{\"capJavaField\":\"TextContent\",\"usableColumn\":false,\"columnId\":112,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"textContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章原始内容\",\"isQuery\":\"1\",\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"longtext\",\"createBy\":\"\",\"isPk\":\"0\",\"createTime\":1655751463000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"text_content\"},{\"capJavaField\":\"HtmlContent\",\"usableColumn\":false,\"columnId\":54,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"htmlContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章html内容\",\"isQuery\":\"1\",\"updateTime\":1655751463000,\"sort\":4,\"list\":true,\"params\":{},\"javaT', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:44:15');
INSERT INTO `sys_oper_log` VALUES (250, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":1,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"articles\",\"component\":\"blog/articles/index\",\"children\":[],\"createTime\":1655429273000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2016,\"menuType\":\"C\",\"perms\":\"blog:articles:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:45:57');
INSERT INTO `sys_oper_log` VALUES (251, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>2444</p>\\n<p>22222222222222222</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 09:58:10');
INSERT INTO `sys_oper_log` VALUES (252, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"<p>2444</p>\\n<p>22222222222222222</p>\\n\",\"createBy\":\"\",\"updateBy\":\"\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-21 10:09:44');
INSERT INTO `sys_oper_log` VALUES (253, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:25:52');
INSERT INTO `sys_oper_log` VALUES (254, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:25:56');
INSERT INTO `sys_oper_log` VALUES (255, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:26:46');
INSERT INTO `sys_oper_log` VALUES (256, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:27:02');
INSERT INTO `sys_oper_log` VALUES (257, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:27:23');
INSERT INTO `sys_oper_log` VALUES (258, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:27:47');
INSERT INTO `sys_oper_log` VALUES (259, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:28:24');
INSERT INTO `sys_oper_log` VALUES (260, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'sys_user', NULL, 1, '导入失败：null', '2022-06-22 03:28:42');
INSERT INTO `sys_oper_log` VALUES (261, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_articles', '127.0.0.1', '内网IP', '{tableName=qy_articles}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 03:28:53');
INSERT INTO `sys_oper_log` VALUES (262, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:29:42');
INSERT INTO `sys_oper_log` VALUES (263, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:32:55');
INSERT INTO `sys_oper_log` VALUES (264, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:33:51');
INSERT INTO `sys_oper_log` VALUES (265, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:34:23');
INSERT INTO `sys_oper_log` VALUES (266, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 03:34:24');
INSERT INTO `sys_oper_log` VALUES (267, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-22 04:30:39');
INSERT INTO `sys_oper_log` VALUES (268, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 04:30:48');
INSERT INTO `sys_oper_log` VALUES (269, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 04:31:57');
INSERT INTO `sys_oper_log` VALUES (270, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 04:31:59');
INSERT INTO `sys_oper_log` VALUES (271, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 04:32:00');
INSERT INTO `sys_oper_log` VALUES (272, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', NULL, 1, '导入失败：null', '2022-06-22 04:32:02');
INSERT INTO `sys_oper_log` VALUES (273, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'qy_files', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 04:56:22');
INSERT INTO `sys_oper_log` VALUES (274, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_articles', '127.0.0.1', '内网IP', '{tableName=qy_articles}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 04:58:42');
INSERT INTO `sys_oper_log` VALUES (275, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_files', '127.0.0.1', '内网IP', '{tableName=qy_files}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 04:58:46');
INSERT INTO `sys_oper_log` VALUES (276, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"FileId\",\"usableColumn\":false,\"columnId\":113,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"fileId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文件或目录id\",\"updateTime\":1655845126000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1655844982000,\"tableId\":12,\"pk\":true,\"columnName\":\"file_id\"},{\"capJavaField\":\"FileName\",\"usableColumn\":false,\"columnId\":114,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"fileName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件或目录原始名称，不包含后缀\",\"isQuery\":\"1\",\"updateTime\":1655845126000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"file_name\"},{\"capJavaField\":\"Suffix\",\"usableColumn\":false,\"columnId\":115,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"suffix\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件名后缀，不包含小数点\",\"isQuery\":\"1\",\"updateTime\":1655845126000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"suffix\"},{\"capJavaField\":\"Size\",\"usableColumn\":false,\"columnId\":116,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"size\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件大小\",\"isQuery\":\"1\",\"updateTime\":1655845126000,\"sort\":4,\"list\":true,\"para', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 04:59:11');
INSERT INTO `sys_oper_log` VALUES (277, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"12333\\n\\n2222222222222\\n\\n4444444444444\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"12333\\n2222222222222\\n4444444444444\\n\",\"createBy\":\"\",\"updateBy\":\"admin\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 05:31:23');
INSERT INTO `sys_oper_log` VALUES (278, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createBy\":\"\",\"updateBy\":\"admin\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 05:31:27');
INSERT INTO `sys_oper_log` VALUES (279, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"FileId\",\"usableColumn\":false,\"columnId\":113,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"fileId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文件或目录id\",\"updateTime\":1655845151000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1655844982000,\"tableId\":12,\"pk\":true,\"columnName\":\"file_id\"},{\"capJavaField\":\"FileName\",\"usableColumn\":false,\"columnId\":114,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"fileName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件或目录原始名称，不包含后缀\",\"isQuery\":\"1\",\"updateTime\":1655845151000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"file_name\"},{\"capJavaField\":\"Suffix\",\"usableColumn\":false,\"columnId\":115,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"suffix\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件名后缀，不包含小数点\",\"isQuery\":\"1\",\"updateTime\":1655845151000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"suffix\"},{\"capJavaField\":\"Size\",\"usableColumn\":false,\"columnId\":116,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"size\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件大小\",\"isQuery\":\"1\",\"updateTime\":1655845151000,\"sort\":4,\"list\":true,\"para', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 05:37:47');
INSERT INTO `sys_oper_log` VALUES (280, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"download\",\"orderNum\":3,\"menuName\":\"网盘管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"netdisk\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 05:41:00');
INSERT INTO `sys_oper_log` VALUES (281, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"download\",\"orderNum\":2,\"menuName\":\"网盘管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"netdisk\",\"children\":[],\"createTime\":1655847660000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2022,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 05:41:11');
INSERT INTO `sys_oper_log` VALUES (282, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":1,\"menuName\":\"文件目录\",\"params\":{},\"parentId\":2022,\"isCache\":\"0\",\"path\":\"dir\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 05:42:18');
INSERT INTO `sys_oper_log` VALUES (283, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"form\",\"orderNum\":2,\"menuName\":\"网盘管理\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"netdisk\",\"children\":[],\"createTime\":1655847660000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2022,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 05:42:44');
INSERT INTO `sys_oper_log` VALUES (284, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_files', '127.0.0.1', '内网IP', '{tableName=qy_files}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 08:36:45');
INSERT INTO `sys_oper_log` VALUES (285, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"FileId\",\"usableColumn\":false,\"columnId\":113,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"fileId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文件或目录id\",\"updateTime\":1655858205000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1655844982000,\"tableId\":12,\"pk\":true,\"columnName\":\"file_id\"},{\"capJavaField\":\"FileName\",\"usableColumn\":false,\"columnId\":114,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"fileName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件或目录原始名称，不包含后缀\",\"isQuery\":\"1\",\"updateTime\":1655858205000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"file_name\"},{\"capJavaField\":\"Suffix\",\"usableColumn\":false,\"columnId\":115,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"suffix\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件名后缀，不包含小数点\",\"isQuery\":\"1\",\"updateTime\":1655858205000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"suffix\"},{\"capJavaField\":\"Size\",\"usableColumn\":false,\"columnId\":116,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"size\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件大小\",\"isQuery\":\"1\",\"updateTime\":1655858205000,\"sort\":4,\"list\":true,\"para', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 08:37:01');
INSERT INTO `sys_oper_log` VALUES (286, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_files', '127.0.0.1', '内网IP', '{tableName=qy_files}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 08:40:15');
INSERT INTO `sys_oper_log` VALUES (287, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"FileId\",\"usableColumn\":false,\"columnId\":113,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"fileId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文件或目录id\",\"updateTime\":1655858414000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1655844982000,\"tableId\":12,\"pk\":true,\"columnName\":\"file_id\"},{\"capJavaField\":\"FileName\",\"usableColumn\":false,\"columnId\":114,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"fileName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件或目录原始名称，不包含后缀\",\"isQuery\":\"1\",\"updateTime\":1655858415000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"file_name\"},{\"capJavaField\":\"Suffix\",\"usableColumn\":false,\"columnId\":115,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"suffix\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件名后缀，不包含小数点\",\"isQuery\":\"1\",\"updateTime\":1655858415000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"suffix\"},{\"capJavaField\":\"Size\",\"usableColumn\":false,\"columnId\":116,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"size\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件大小\",\"isQuery\":\"1\",\"updateTime\":1655858415000,\"sort\":4,\"list\":true,\"para', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 08:43:33');
INSERT INTO `sys_oper_log` VALUES (288, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"ArticleId\",\"usableColumn\":false,\"columnId\":51,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"articleId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文章id\",\"updateTime\":1655845122000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":6,\"pk\":true,\"columnName\":\"article_id\"},{\"capJavaField\":\"ArticleTitle\",\"usableColumn\":false,\"columnId\":111,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"articleTitle\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文章标题\",\"isQuery\":\"1\",\"updateTime\":1655845122000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"\",\"isPk\":\"0\",\"createTime\":1655707418000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"article_title\"},{\"capJavaField\":\"TextContent\",\"usableColumn\":false,\"columnId\":112,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"textContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章原始内容\",\"isQuery\":\"1\",\"updateTime\":1655845122000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"longtext\",\"createBy\":\"\",\"isPk\":\"0\",\"createTime\":1655751463000,\"isEdit\":\"1\",\"tableId\":6,\"pk\":false,\"columnName\":\"text_content\"},{\"capJavaField\":\"HtmlContent\",\"usableColumn\":false,\"columnId\":54,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"htmlContent\",\"htmlType\":\"editor\",\"edit\":true,\"query\":true,\"columnComment\":\"文章html内容\",\"isQuery\":\"1\",\"updateTime\":16558451', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 09:25:44');
INSERT INTO `sys_oper_log` VALUES (289, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"FileId\",\"usableColumn\":false,\"columnId\":113,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"fileId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"文件或目录id\",\"updateTime\":1655858613000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1655844982000,\"tableId\":12,\"pk\":true,\"columnName\":\"file_id\"},{\"capJavaField\":\"FileName\",\"usableColumn\":false,\"columnId\":114,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"fileName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件或目录原始名称，不包含后缀\",\"isQuery\":\"1\",\"updateTime\":1655858613000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"file_name\"},{\"capJavaField\":\"Suffix\",\"usableColumn\":false,\"columnId\":115,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"isInsert\":\"1\",\"javaField\":\"suffix\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件名后缀，不包含小数点\",\"isQuery\":\"1\",\"updateTime\":1655858613000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1655844982000,\"isEdit\":\"1\",\"tableId\":12,\"pk\":false,\"columnName\":\"suffix\"},{\"capJavaField\":\"Size\",\"usableColumn\":false,\"columnId\":116,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"size\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"文件大小\",\"isQuery\":\"1\",\"updateTime\":1655858613000,\"sort\":4,\"list\":true,\"para', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 09:25:56');
INSERT INTO `sys_oper_log` VALUES (290, '文章新增', 3, 'com.ruoyi.web.controller.blog.ArticlesController.remove()', 'DELETE', 1, 'admin', NULL, '/blog/articles/3', '127.0.0.1', '内网IP', '{articleIds=3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 10:08:30');
INSERT INTO `sys_oper_log` VALUES (291, '文章新增', 3, 'com.ruoyi.web.controller.blog.ArticlesController.remove()', 'DELETE', 1, 'admin', NULL, '/blog/articles/2', '127.0.0.1', '内网IP', '{articleIds=2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 10:08:32');
INSERT INTO `sys_oper_log` VALUES (292, '文章新增', 3, 'com.ruoyi.web.controller.blog.ArticlesController.remove()', 'DELETE', 1, 'admin', NULL, '/blog/articles/2', '127.0.0.1', '内网IP', '{articleIds=2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 10:14:03');
INSERT INTO `sys_oper_log` VALUES (293, '文章新增', 3, 'com.ruoyi.web.controller.blog.ArticlesController.remove()', 'DELETE', 1, 'admin', NULL, '/blog/articles/3', '127.0.0.1', '内网IP', '{articleIds=3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-22 10:14:06');
INSERT INTO `sys_oper_log` VALUES (294, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"StorageId\",\"usableColumn\":false,\"columnId\":86,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"storageId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"存储类型id\",\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":9,\"pk\":true,\"columnName\":\"storage_id\"},{\"capJavaField\":\"StorageName\",\"usableColumn\":false,\"columnId\":87,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"storageName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"类型名称\",\"isQuery\":\"1\",\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":9,\"pk\":false,\"columnName\":\"storage_name\"},{\"capJavaField\":\"StorageConfig\",\"usableColumn\":false,\"columnId\":88,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"storageConfig\",\"htmlType\":\"textarea\",\"edit\":true,\"query\":true,\"columnComment\":\"存储类型相关配置\",\"isQuery\":\"1\",\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":9,\"pk\":false,\"columnName\":\"storage_config\"},{\"capJavaField\":\"DelFlag\",\"usableColumn\":false,\"columnId\":89,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"delFlag\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"删除标志（0代表存在 2代表删除）\",\"sort\":4,\"list\":false,\"params\":{},\"javaType\":\"String\",\"queryType\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 01:17:21');
INSERT INTO `sys_oper_log` VALUES (295, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"StorageId\",\"usableColumn\":false,\"columnId\":86,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"storageId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"存储类型id\",\"updateTime\":1655918241000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":9,\"pk\":true,\"columnName\":\"storage_id\"},{\"capJavaField\":\"StorageName\",\"usableColumn\":false,\"columnId\":87,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"storageName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"类型名称\",\"isQuery\":\"1\",\"updateTime\":1655918241000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":9,\"pk\":false,\"columnName\":\"storage_name\"},{\"capJavaField\":\"StorageConfig\",\"usableColumn\":false,\"columnId\":88,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"storageConfig\",\"htmlType\":\"textarea\",\"edit\":true,\"query\":true,\"columnComment\":\"存储类型相关配置\",\"isQuery\":\"1\",\"updateTime\":1655918241000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":9,\"pk\":false,\"columnName\":\"storage_config\"},{\"capJavaField\":\"DelFlag\",\"usableColumn\":false,\"columnId\":89,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"delFlag\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"删除标志', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 01:17:32');
INSERT INTO `sys_oper_log` VALUES (296, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"sub\":false,\"functionAuthor\":\"JiangQiang\",\"columns\":[{\"capJavaField\":\"StorageId\",\"usableColumn\":false,\"columnId\":86,\"isIncrement\":\"1\",\"increment\":true,\"insert\":true,\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"storageId\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"存储类型id\",\"updateTime\":1655918252000,\"sort\":1,\"list\":false,\"params\":{},\"javaType\":\"Long\",\"queryType\":\"EQ\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"isPk\":\"1\",\"createTime\":1653116110000,\"tableId\":9,\"pk\":true,\"columnName\":\"storage_id\"},{\"capJavaField\":\"StorageName\",\"usableColumn\":false,\"columnId\":87,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":true,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"isRequired\":\"1\",\"javaField\":\"storageName\",\"htmlType\":\"input\",\"edit\":true,\"query\":true,\"columnComment\":\"类型名称\",\"isQuery\":\"1\",\"updateTime\":1655918252000,\"sort\":2,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"LIKE\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":9,\"pk\":false,\"columnName\":\"storage_name\"},{\"capJavaField\":\"StorageConfig\",\"usableColumn\":false,\"columnId\":88,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"isList\":\"1\",\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"storageConfig\",\"htmlType\":\"textarea\",\"edit\":true,\"query\":true,\"columnComment\":\"存储类型相关配置\",\"isQuery\":\"1\",\"updateTime\":1655918252000,\"sort\":3,\"list\":true,\"params\":{},\"javaType\":\"String\",\"queryType\":\"EQ\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"isPk\":\"0\",\"createTime\":1653116110000,\"isEdit\":\"1\",\"tableId\":9,\"pk\":false,\"columnName\":\"storage_config\"},{\"capJavaField\":\"DelFlag\",\"usableColumn\":false,\"columnId\":89,\"isIncrement\":\"0\",\"increment\":false,\"insert\":true,\"dictType\":\"\",\"required\":false,\"superColumn\":false,\"updateBy\":\"\",\"isInsert\":\"1\",\"javaField\":\"delFlag\",\"htmlType\":\"input\",\"edit\":false,\"query\":false,\"columnComment\":\"删除标志', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 01:17:44');
INSERT INTO `sys_oper_log` VALUES (297, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_storages', '127.0.0.1', '内网IP', '{tableName=qy_storages}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 01:17:51');
INSERT INTO `sys_oper_log` VALUES (298, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":1,\"menuName\":\"000\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"l\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 02:38:51');
INSERT INTO `sys_oper_log` VALUES (299, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2024', '127.0.0.1', '内网IP', '{menuId=2024}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 02:38:55');
INSERT INTO `sys_oper_log` VALUES (300, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"1\",\"tagIds\":\"111111111111\",\"articleId\":2,\"textContent\":\"12333\\n\\n2222222222222\\n\\n4444444444444\\n\",\"updateTime\":1655956660089,\"params\":{},\"articleUrl\":\"11111111\",\"htmlContent\":\"12333\\n2222222222222\\n4444444444444\\n\",\"createBy\":\"\",\"updateBy\":\"admin\",\"categoryId\":111111111}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 03:57:40');
INSERT INTO `sys_oper_log` VALUES (301, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"2\",\"tagIds\":\"222222222\",\"articleId\":3,\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"updateTime\":1655956669630,\"params\":{},\"articleUrl\":\"2\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createBy\":\"\",\"updateBy\":\"admin\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 03:57:49');
INSERT INTO `sys_oper_log` VALUES (302, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"3\",\"tagIds\":\"12\",\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createTime\":1655956681521,\"categoryId\":3123}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\r\n### The error may exist in xin/jiangqiang/blog/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve xin.jiangqiang.blog.mapper.ArticlesMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO qy_articles  ( article_title, text_content, html_content, article_url, category_id, tag_ids, del_flag, create_by, create_time )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\n; Column \'create_by\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null', '2022-06-23 03:58:01');
INSERT INTO `sys_oper_log` VALUES (303, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"3\",\"tagIds\":\"12\",\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createTime\":1655956724735,\"categoryId\":3123}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\r\n### The error may exist in xin/jiangqiang/blog/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve xin.jiangqiang.blog.mapper.ArticlesMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO qy_articles  ( article_title, text_content, html_content, article_url, category_id, tag_ids, del_flag, create_by, create_time )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\n; Column \'create_by\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null', '2022-06-23 03:59:22');
INSERT INTO `sys_oper_log` VALUES (304, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"3\",\"tagIds\":\"12\",\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createTime\":1655956799856,\"categoryId\":3123}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\r\n### The error may exist in xin/jiangqiang/blog/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve xin.jiangqiang.blog.mapper.ArticlesMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO qy_articles  ( article_title, text_content, html_content, article_url, category_id, tag_ids, del_flag, create_by, create_time )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\n; Column \'create_by\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null', '2022-06-23 03:59:59');
INSERT INTO `sys_oper_log` VALUES (305, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"3\",\"tagIds\":\"12\",\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createTime\":1655956812791,\"categoryId\":3123}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\r\n### The error may exist in xin/jiangqiang/blog/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve xin.jiangqiang.blog.mapper.ArticlesMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO qy_articles  ( article_title, text_content, html_content, article_url, category_id, tag_ids, del_flag, create_by, create_time )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\n; Column \'create_by\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null', '2022-06-23 04:00:40');
INSERT INTO `sys_oper_log` VALUES (306, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"3\",\"tagIds\":\"12\",\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createTime\":1655956856148,\"categoryId\":3123}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\r\n### The error may exist in xin/jiangqiang/blog/mapper/ArticlesMapper.java (best guess)\r\n### The error may involve xin.jiangqiang.blog.mapper.ArticlesMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO qy_articles  ( article_title, text_content, html_content, article_url, category_id, tag_ids, del_flag, create_by, create_time )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null\n; Column \'create_by\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'create_by\' cannot be null', '2022-06-23 04:00:56');
INSERT INTO `sys_oper_log` VALUES (307, '文章新增', 1, 'com.ruoyi.web.controller.blog.ArticlesController.add()', 'POST', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"3\",\"tagIds\":\"12\",\"articleId\":4,\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"delFlag\":\"0\",\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createBy\":\"admin\",\"createTime\":1655956885114,\"categoryId\":3123}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 04:01:25');
INSERT INTO `sys_oper_log` VALUES (308, '文章新增', 2, 'com.ruoyi.web.controller.blog.ArticlesController.edit()', 'PUT', 1, 'admin', NULL, '/blog/articles', '127.0.0.1', '内网IP', '{\"articleTitle\":\"3\",\"tagIds\":\"12\",\"articleId\":4,\"textContent\":\"2444\\n\\n22222222222222222\\n\",\"updateTime\":1655956900038,\"params\":{},\"articleUrl\":\"1\",\"htmlContent\":\"2444\\n22222222222222222\\n\",\"createBy\":\"admin\",\"createTime\":1655956885000,\"updateBy\":\"admin\",\"categoryId\":3123}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 04:01:40');
INSERT INTO `sys_oper_log` VALUES (309, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":1,\"menuName\":\"文件目录\",\"params\":{},\"parentId\":2022,\"isCache\":\"0\",\"path\":\"dir\",\"component\":\"net-disc/index\",\"children\":[],\"createTime\":1655847738000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2023,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-23 08:37:33');
INSERT INTO `sys_oper_log` VALUES (310, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/qy_files', '127.0.0.1', '内网IP', '{tableName=qy_files}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-29 06:50:44');
INSERT INTO `sys_oper_log` VALUES (311, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-29 06:50:46');
INSERT INTO `sys_oper_log` VALUES (312, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-29 06:50:47');
INSERT INTO `sys_oper_log` VALUES (313, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-29 06:51:28');
INSERT INTO `sys_oper_log` VALUES (314, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-29 06:51:28');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-05-21 05:51:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-05-21 05:51:18', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-05-21 05:51:18', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-05-21 05:51:18', 'admin', '2022-06-17 09:30:29', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-05-21 14:10:25', 'admin', '2022-05-21 05:51:18', '', '2022-05-21 06:10:26', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-05-21 05:51:18', 'admin', '2022-05-21 05:51:18', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
