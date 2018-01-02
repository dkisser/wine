/*
Navicat MySQL Data Transfer

Source Server         : wenchen
Source Server Version : 50153
Source Host           : localhost:3306
Source Database       : byb

Target Server Type    : MYSQL
Target Server Version : 50153
File Encoding         : 65001

Date: 2018-01-02 18:29:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `chu_user`
-- ----------------------------
DROP TABLE IF EXISTS `chu_user`;
CREATE TABLE `chu_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UNAME` varchar(255) DEFAULT NULL COMMENT '用户名',
  `UPW` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `ROLE` int(11) DEFAULT NULL COMMENT '角色类型',
  `NAME` varchar(255) DEFAULT NULL COMMENT '姓名',
  `PHONE` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `BM_ID` int(11) DEFAULT NULL COMMENT '与部门表对应',
  `RYLX` int(11) DEFAULT NULL COMMENT '业务员0，送货员1，收货人2',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chu_user
-- ----------------------------
INSERT INTO `chu_user` VALUES ('1', 'wenchen', '3EAE24F429DEAD060334275C71B152B7', '1', '文臣', '123456789', '1', '0');
INSERT INTO `chu_user` VALUES ('2', 'hehaishui', '1ACF597D5CF8F06C4BB30E1634CD88FD', '1', '何海水', '123456789', '1', '0');

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户唯一标识',
  `UNAME` varchar(255) DEFAULT NULL COMMENT '客户用户名',
  `NAME` varchar(255) DEFAULT NULL COMMENT '客户姓名',
  `PHONE` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '送货地址',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------

-- ----------------------------
-- Table structure for `dept`
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，唯一标识',
  `MC` varchar(255) DEFAULT NULL COMMENT '部门名称',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '打印出EXCEL时要显示的标题',
  `PIC_URL` varchar(255) DEFAULT NULL COMMENT '部门图片在服务器上的地址',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '打印出EXCEL时最后面要追加的说明',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('1', '湖北白云边酒业', '湖北白云边酒业产品朔源单', null, null);

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',
  `NAME` varchar(255) DEFAULT '' COMMENT '菜单名称',
  `URL` varchar(255) DEFAULT '' COMMENT '访问地址',
  `ICON` varchar(255) DEFAULT '' COMMENT '菜单图标',
  `PID` int(11) DEFAULT NULL COMMENT '父菜单的ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('10', '数据字典', '/data', '', '0');
INSERT INTO `menu` VALUES ('20', '订单业务', '/order', '', '0');
INSERT INTO `menu` VALUES ('101', '客户管理', '/data/customerUI', '', '10');
INSERT INTO `menu` VALUES ('102', '酒品管理', '/data/wineUI', '', '10');
INSERT INTO `menu` VALUES ('201', '数据录入', '/order/importUI', '', '20');
INSERT INTO `menu` VALUES ('202', '订单查询', '/order/queryUI', '', '20');
INSERT INTO `menu` VALUES ('203', '报表打印', '/order/reportUI', '', '20');

-- ----------------------------
-- Table structure for `menu_role`
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MID` int(11) DEFAULT NULL COMMENT '菜单对应的ID',
  `RID` int(11) DEFAULT NULL COMMENT '角色对应的ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('1', '10', '1');
INSERT INTO `menu_role` VALUES ('2', '101', '1');
INSERT INTO `menu_role` VALUES ('3', '102', '1');
INSERT INTO `menu_role` VALUES ('4', '20', '1');
INSERT INTO `menu_role` VALUES ('5', '201', '1');
INSERT INTO `menu_role` VALUES ('6', '202', '1');
INSERT INTO `menu_role` VALUES ('7', '203', '1');

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单的唯一标识',
  `TXM` varchar(255) DEFAULT NULL COMMENT '条形码',
  `ORDER_ID` varchar(255) DEFAULT NULL COMMENT '销售单号',
  `WINE_ID` int(11) DEFAULT NULL COMMENT '酒的ID',
  `SHY` varchar(255) DEFAULT NULL COMMENT '送货员',
  `YWY` varchar(255) DEFAULT NULL COMMENT '业务员',
  `SHR` varchar(255) DEFAULT NULL COMMENT '收货人,与客户表关联',
  `KDR` varchar(255) DEFAULT NULL COMMENT '开单人',
  `DATE` date DEFAULT NULL COMMENT '开单日期',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `NAME` varchar(255) DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '管理员');

-- ----------------------------
-- Table structure for `wine`
-- ----------------------------
DROP TABLE IF EXISTS `wine`;
CREATE TABLE `wine` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '酒的ID，唯一标识',
  `MC` varchar(255) DEFAULT NULL COMMENT '商品酒的名称',
  `PRICE` int(11) DEFAULT NULL COMMENT '价格',
  `DATE` date DEFAULT NULL COMMENT '出厂日期',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '对该商品酒的备注说明',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wine
-- ----------------------------
