-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: mysql.wm.net    Database: mir_sr_gaowenhao
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` char(64) NOT NULL,
  `platid` char(80) NOT NULL DEFAULT '' COMMENT '平台标识',
  `loginstatus` int(11) NOT NULL COMMENT '登陆状态 1是在线 0是不在线',
  `logintime` datetime NOT NULL COMMENT '登陆时间',
  `logouttime` datetime NOT NULL COMMENT '退出时间',
  `IngotNumber` decimal(18,0) NOT NULL COMMENT '元宝数量',
  `AreaNo` varchar(11) NOT NULL COMMENT '区服号',
  `Client` varchar(32) NOT NULL COMMENT '登陆途径',
  `IsAdult` int(11) NOT NULL COMMENT '是否成年',
  `LastLoginIp` varchar(24) NOT NULL COMMENT '最后登陆ip',
  `sealTime` varchar(24) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `LastLoginIp` (`LastLoginIp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_auction`
--

DROP TABLE IF EXISTS `logic_auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_auction` (
  `id` char(40) NOT NULL,
  `seller_id` char(40) NOT NULL,
  `time` int(11) NOT NULL,
  `max_price` int(11) NOT NULL,
  `buyer_id` char(40) NOT NULL,
  `bidding_price` int(11) NOT NULL,
  `original_price` int(11) NOT NULL,
  `item` text NOT NULL,
  `anonymous` int(11) NOT NULL,
  `del` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_guild`
--

DROP TABLE IF EXISTS `logic_guild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_guild` (
  `id` char(24) CHARACTER SET utf8 NOT NULL,
  `name` varchar(32) COLLATE utf8_bin NOT NULL,
  `notice` varchar(512) CHARACTER SET utf8 NOT NULL,
  `level` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `treasure` int(11) NOT NULL,
  `del` int(11) NOT NULL,
  `red` text CHARACTER SET utf8 NOT NULL,
  `rival` text COLLATE utf8_bin NOT NULL,
  `audits` text CHARACTER SET utf8 NOT NULL,
  `members` text CHARACTER SET utf8 NOT NULL,
  `leave_infos` text COLLATE utf8_bin NOT NULL,
  `treasure_day` text COLLATE utf8_bin NOT NULL,
  `items_1` text CHARACTER SET utf8 NOT NULL,
  `items_2` text COLLATE utf8_bin NOT NULL,
  `items_3` text COLLATE utf8_bin NOT NULL,
  `bossinfo` text COLLATE utf8_bin NOT NULL,
  `serverid` text COLLATE utf8_bin NOT NULL,
  `impeach` text COLLATE utf8_bin NOT NULL,
  `retain` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_login_sessions`
--

DROP TABLE IF EXISTS `logic_login_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_login_sessions` (
  `accountID` char(64) NOT NULL,
  `accountName` char(72) NOT NULL,
  `sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户登录平台后，会去账号服务器验证，通过后由账号服务器生成',
  `activeTime` varchar(255) NOT NULL DEFAULT '' COMMENT '首次登陆时间',
  `invalidTime` varchar(255) NOT NULL DEFAULT '0' COMMENT '有效时间',
  `sealTime` varchar(255) NOT NULL DEFAULT '0',
  `retain` text NOT NULL COMMENT '保留',
  PRIMARY KEY (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_mail`
--

DROP TABLE IF EXISTS `logic_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_mail` (
  `mail_id` char(24) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `role_id` char(24) NOT NULL,
  `sender` varchar(32) NOT NULL,
  `title` varchar(64) NOT NULL,
  `content` varchar(512) NOT NULL,
  `item_List` varchar(200) NOT NULL,
  `award_gold_free` int(11) NOT NULL,
  `award_gold_bind` int(11) NOT NULL,
  `award_vip_point_free` int(11) NOT NULL,
  `award_vip_point_bind` int(11) NOT NULL,
  `time_point` bigint(19) NOT NULL,
  `received` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  `base_id` int(11) NOT NULL,
  `funparams` text NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_new_role_key`
--

DROP TABLE IF EXISTS `logic_new_role_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_new_role_key` (
  `registration_code` varchar(255) NOT NULL COMMENT '激活码',
  `use_code_account_name` char(40) NOT NULL COMMENT '使用激活码的账号',
  `get_code_account_name` char(40) NOT NULL COMMENT '获取激活码的账号',
  PRIMARY KEY (`registration_code`),
  KEY `registration_code` (`registration_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_public_mail`
--

DROP TABLE IF EXISTS `logic_public_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_public_mail` (
  `id` char(24) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `item_List` varchar(255) NOT NULL,
  `award_gold_free` int(11) NOT NULL,
  `award_gold_bind` int(11) NOT NULL,
  `award_vip_point_free` int(11) NOT NULL,
  `award_vip_point_bind` int(11) NOT NULL,
  `get_time` int(11) NOT NULL,
  `effective_time` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_role`
--

DROP TABLE IF EXISTS `logic_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_role` (
  `id` char(80) NOT NULL,
  `account_id` char(64) NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `gender` int(11) NOT NULL,
  `job` int(11) NOT NULL,
  `level_re` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `pk_mode` int(11) NOT NULL,
  `logouttime` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `pos` varchar(255) NOT NULL,
  `simple` text NOT NULL,
  `attr` text NOT NULL,
  `mars` text NOT NULL,
  `smelter` text NOT NULL,
  `equip` text NOT NULL,
  `equip_pos` text NOT NULL,
  `func_open` text NOT NULL,
  `time` text NOT NULL,
  `config` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `task` text NOT NULL,
  `skill` text NOT NULL,
  `buffer` text NOT NULL,
  `item` mediumtext NOT NULL,
  `wing` text NOT NULL,
  `mall_limit` text NOT NULL,
  `activity` text NOT NULL,
  `achievement` text NOT NULL,
  `active_value` text NOT NULL,
  `sw_mission` text NOT NULL,
  `limit_mission` text NOT NULL,
  `mission` text NOT NULL,
  `popular_boss` text NOT NULL,
  `award_hall` text NOT NULL,
  `role_daily_data` text NOT NULL,
  `role_once_data` text NOT NULL,
  `role_relation` text NOT NULL,
  `vip` text NOT NULL,
  `mine` text NOT NULL,
  `lianhun` text NOT NULL,
  `guild_skill` text NOT NULL,
  `suit` text NOT NULL,
  `gem` text NOT NULL,
  `levelaward` text NOT NULL,
  `title` text NOT NULL,
  `roleinfo` text NOT NULL,
  `privilege` text NOT NULL COMMENT '特权卡',
  `guide` text NOT NULL,
  `private_boss` text NOT NULL,
  `retain1` text NOT NULL COMMENT '保留1',
  `retain2` text NOT NULL COMMENT '保留2',
  `retain3` text NOT NULL COMMENT '保留3',
  `retain4` text NOT NULL COMMENT '保留4',
  `retain5` text NOT NULL,
  `role_weekly_data` text NOT NULL,
  `citizen_red` text NOT NULL,
  `world_prosperity` text NOT NULL,
  `delete_flag` int(11) NOT NULL DEFAULT '0',
  `crossServerInfo` text NOT NULL,
  `off_line_hook` text NOT NULL,
  `mail_push` text NOT NULL,
  `pay_push` text NOT NULL,
  `serverid` int(11) DEFAULT '0',
  `chance_boss` text NOT NULL,
  `merge_server_flag` int(11) NOT NULL COMMENT '合服标致，用于合服后邮件提取和删除',
  `customized_activities` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `level` (`level`) USING BTREE,
  KEY `account_id` (`account_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_super_store`
--

DROP TABLE IF EXISTS `logic_super_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_super_store` (
  `id` char(40) NOT NULL COMMENT '唯一id',
  `item` text NOT NULL,
  `role_id` char(25) NOT NULL,
  `mail_id` char(25) NOT NULL,
  `del` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_variable`
--

DROP TABLE IF EXISTS `logic_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_variable` (
  `name` varchar(255) NOT NULL,
  `value` mediumtext,
  `DC` varchar(1024) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_web_deduction`
--

DROP TABLE IF EXISTS `logic_web_deduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_web_deduction` (
  `role_id` char(24) NOT NULL,
  `type` int(11) NOT NULL,
  `item_id` char(24) NOT NULL,
  `count` int(11) NOT NULL,
  `operator_id` char(24) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_gag`
--

DROP TABLE IF EXISTS `pub_gag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_gag` (
  `RoleId` varchar(255) NOT NULL,
  `Type` int(255) NOT NULL,
  `Way` int(255) NOT NULL DEFAULT '1' COMMENT '1后台 2 系统自动禁言',
  `EndDate` varchar(255) NOT NULL,
  `status` int(255) NOT NULL,
  `key` int(255) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_gm`
--

DROP TABLE IF EXISTS `pub_gm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_gm` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `gm` varchar(255) DEFAULT NULL,
  `param` text,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_kick`
--

DROP TABLE IF EXISTS `pub_kick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_kick` (
  `RoleId` char(24) NOT NULL COMMENT '要踢出游戏的角色id',
  `type` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL COMMENT '//状态',
  `key` int(11) NOT NULL AUTO_INCREMENT COMMENT '//主键',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_mail`
--

DROP TABLE IF EXISTS `pub_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_mail` (
  `roleid` char(24) NOT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `itemlist` varchar(255) DEFAULT NULL,
  `awardGoldFree` int(255) DEFAULT NULL,
  `awardGoldBind` int(255) DEFAULT NULL,
  `awardVIPPointFree` int(255) DEFAULT NULL,
  `awardVIPPointBind` int(255) DEFAULT NULL,
  `key` int(255) NOT NULL AUTO_INCREMENT,
  `status` int(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_notice`
--

DROP TABLE IF EXISTS `pub_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_notice` (
  `key` int(255) NOT NULL AUTO_INCREMENT,
  `NoticeType` int(255) NOT NULL,
  `Content` varchar(255) NOT NULL COMMENT '//公告  类型 内容 状态  ',
  `Date` varchar(255) NOT NULL,
  `status` int(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_pay`
--

DROP TABLE IF EXISTS `pub_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_pay` (
  `accountId` varchar(255) NOT NULL,
  `roleId` varchar(255) NOT NULL,
  `money` int(255) NOT NULL,
  `moneytype` int(255) NOT NULL DEFAULT '0',
  `yuanbao` int(255) NOT NULL,
  `orderId` varchar(255) NOT NULL COMMENT '订单编号',
  `status` int(255) NOT NULL,
  `key` int(255) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) NOT NULL DEFAULT '0',
  `other` varchar(255) NOT NULL DEFAULT '0',
  `create_time` varchar(255) NOT NULL DEFAULT '0',
  `handle_time` varchar(255) NOT NULL DEFAULT '0',
  `from_api` int(1) NOT NULL DEFAULT '0',
  `test` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=7395 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_seal`
--

DROP TABLE IF EXISTS `pub_seal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_seal` (
  `accountId` varchar(255) NOT NULL,
  `Type` int(8) NOT NULL,
  `EndDate` varchar(255) NOT NULL,
  `status` int(8) NOT NULL,
  `key` int(255) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system_info`
--

DROP TABLE IF EXISTS `system_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_info` (
  `server_ID` smallint(5) NOT NULL,
  `online` smallint(5) unsigned NOT NULL COMMENT '在线人数',
  `cpu` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `net` int(10) unsigned NOT NULL DEFAULT '0',
  `mem` varchar(512) NOT NULL DEFAULT '0',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`datetime`),
  KEY `datetime` (`datetime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-29 16:04:37
