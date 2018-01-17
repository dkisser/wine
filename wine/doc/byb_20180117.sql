/*
Navicat MySQL Data Transfer

Source Server         : wenchen
Source Server Version : 50153
Source Host           : localhost:3306
Source Database       : byb

Target Server Type    : MYSQL
Target Server Version : 50153
File Encoding         : 65001

Date: 2018-01-17 15:21:12
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
  `JC` varchar(255) DEFAULT '' COMMENT '首字母的缩写',
  `XS` int(3) unsigned zerofill DEFAULT '000' COMMENT '销售的单数，用来生成销售单号',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chu_user
-- ----------------------------
INSERT INTO `chu_user` VALUES ('1', 'wenchen', '3EAE24F429DEAD060334275C71B152B7', '1', '文臣', '123456789', '0', '0', 'wc', '004');
INSERT INTO `chu_user` VALUES ('2', 'hehaishui', '1ACF597D5CF8F06C4BB30E1634CD88FD', '1', '何海水', '123456789', '0', '0', 'hhs', '003');
INSERT INTO `chu_user` VALUES ('3', 'admin', 'A66ABB5684C45962D887564F08346E8D', '2', '管理员', '123456789', '0', '1', 'gly', '000');

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户唯一标识',
  `UNAME` varchar(255) DEFAULT NULL COMMENT '客户负责人名称',
  `NAME` varchar(255) DEFAULT NULL COMMENT '客户名称（即店铺名如：xxx副食）',
  `PHONE` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '送货地址',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', 'ddfd', '习经平', '110', '国务院');
INSERT INTO `customer` VALUES ('2', 'dafad', '稳架包', '120', '中南海');
INSERT INTO `customer` VALUES ('3', 'wenc', '弯沉', '15071451506', '湖北第二师范学院');
INSERT INTO `customer` VALUES ('4', 'hehai', '嘿嘿书', '1501505015', '湖北第二师范学院');
INSERT INTO `customer` VALUES ('5', '12dad', 'dfa放到', '15113156', '发的反馈来了贷款');
INSERT INTO `customer` VALUES ('7', '21fza', '地方', '04616131', '腹内时代峻峰');
INSERT INTO `customer` VALUES ('8', 'wenchen', '文臣', '15071451506', '你发的了框架爱思考了');
INSERT INTO `customer` VALUES ('9', '湖北第二师范学院副食', '文臣', '15071451506', '叫发挥了妇女的离开');
INSERT INTO `customer` VALUES ('10', 'ffhaldk副食', '文臣', '15465465', '发生的第三法师打发');
INSERT INTO `customer` VALUES ('11', '你东方丽景爱德华', '发多少，', '015456', '发顺丰达');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('0', '湖北白云边酒业', '湖北白云边酒业产品朔源单', null, null);

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
INSERT INTO `menu` VALUES ('103', '内部人员管理', '/data/nbryUI', '', '10');
INSERT INTO `menu` VALUES ('201', '数据录入', '/order/importUI', '', '20');
INSERT INTO `menu` VALUES ('202', '订单管理', '/order/queryUI', '', '20');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('1', '10', '1');
INSERT INTO `menu_role` VALUES ('2', '101', '1');
INSERT INTO `menu_role` VALUES ('3', '102', '1');
INSERT INTO `menu_role` VALUES ('4', '20', '1');
INSERT INTO `menu_role` VALUES ('5', '201', '1');
INSERT INTO `menu_role` VALUES ('6', '202', '1');
INSERT INTO `menu_role` VALUES ('8', '10', '2');
INSERT INTO `menu_role` VALUES ('9', '101', '2');
INSERT INTO `menu_role` VALUES ('10', '102', '2');
INSERT INTO `menu_role` VALUES ('11', '103', '2');
INSERT INTO `menu_role` VALUES ('12', '20', '2');
INSERT INTO `menu_role` VALUES ('13', '201', '2');
INSERT INTO `menu_role` VALUES ('14', '202', '2');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单的唯一标识',
  `TXM` varchar(255) DEFAULT NULL COMMENT '条形码',
  `XSDH` varchar(255) DEFAULT '' COMMENT '销售单号',
  `WINE_ID` int(11) DEFAULT NULL COMMENT '酒的ID',
  `SHY` varchar(255) DEFAULT NULL COMMENT '送货员',
  `YWY` varchar(255) DEFAULT NULL COMMENT '业务员',
  `SHZ` varchar(255) DEFAULT NULL COMMENT '收货者,与客户表关联',
  `KDR` varchar(255) DEFAULT NULL COMMENT '开单人',
  `DATE` date DEFAULT NULL COMMENT '开单日期',
  `REMARK` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '000000002000000001', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('2', '000000002000000002', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('3', '000000002000000003', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('4', '000000002000000004', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('5', '000000002000000005', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('6', '000000002000000006', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('7', '000000002000000007', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('8', '000000002000000008', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('9', '000000002000000009', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('10', '000000002000000010', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('11', '000000002000000011', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('12', '000000002000000012', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('13', '000000002000000013', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('14', '000000002000000014', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('15', '000000002000000015', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('16', '000000002000000016', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('17', '000000002000000017', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('18', '000000002000000018', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('19', '000000002000000019', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('20', '000000002000000020', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('21', '000000002000000021', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('22', '000000002000000022', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('23', '000000002000000023', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('24', '000000002000000024', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('25', '000000002000000025', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('26', '000000002000000026', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('27', '000000002000000027', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('28', '000000002000000028', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('29', '000000002000000029', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('30', '000000002000000030', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('31', '000000002000000031', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('32', '000000002000000032', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('33', '000000002000000033', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('34', '000000002000000034', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('35', '000000002000000035', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('36', '000000002000000036', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('37', '000000002000000037', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('38', '000000002000000038', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('39', '000000002000000039', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('40', '000000002000000040', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('41', '000000002000000041', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('42', '000000002000000042', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('43', '000000002000000043', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('44', '000000002000000044', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('45', '000000002000000045', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('46', '000000002000000046', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('47', '000000002000000047', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('48', '000000002000000048', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('49', '000000002000000049', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('50', '000000002000000050', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('51', '000000002000000051', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('52', '000000002000000052', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('53', '000000002000000053', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('54', '000000002000000054', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('55', '000000002000000055', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('56', '000000002000000056', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('57', '000000002000000057', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('58', '000000002000000058', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('59', '000000002000000059', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('60', '000000002000000060', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('61', '000000002000000061', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('62', '000000002000000062', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('63', '000000002000000063', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('64', '000000002000000064', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('65', '000000002000000065', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('66', '000000002000000066', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('67', '000000002000000067', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('68', '000000002000000068', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('69', '000000002000000069', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('70', '000000002000000070', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('71', '000000002000000071', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('72', '000000002000000072', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('73', '000000002000000073', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('74', '000000002000000074', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('75', '000000002000000075', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('76', '000000002000000076', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('77', '000000002000000077', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('78', '000000002000000078', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('79', '000000002000000079', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('80', '000000002000000080', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('81', '000000002000000081', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('82', '000000002000000082', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('83', '000000002000000083', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('84', '000000002000000084', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('85', '000000002000000085', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('86', '000000002000000086', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('87', '000000002000000087', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('88', '000000002000000088', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('89', '000000002000000089', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('90', '000000002000000090', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('91', '000000002000000091', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('92', '000000002000000092', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('93', '000000002000000093', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('94', '000000002000000094', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('95', '000000002000000095', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('96', '000000002000000096', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('97', '000000002000000097', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('98', '000000002000000098', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('99', '000000002000000099', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('100', '000000002000000100', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('101', '000000002000000101', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('102', '000000002000000102', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('103', '000000002000000103', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('104', '000000002000000104', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('105', '000000002000000105', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('106', '000000002000000106', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('107', '000000002000000107', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('108', '000000002000000108', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('109', '000000002000000109', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('110', '000000002000000110', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('111', '000000002000000111', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('112', '000000002000000112', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('113', '000000002000000113', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('114', '000000002000000114', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('115', '000000002000000115', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('116', '000000002000000116', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('117', '000000002000000117', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('118', '000000002000000118', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('119', '000000002000000119', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('120', '000000002000000120', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('121', '000000002000000121', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('122', '000000002000000122', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('123', '000000002000000123', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('124', '000000002000000124', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('125', '000000002000000125', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('126', '000000002000000126', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('127', '000000002000000127', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('128', '000000002000000128', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('129', '000000002000000129', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('130', '000000002000000130', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('131', '000000002000000131', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('132', '000000002000000132', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('133', '000000002000000133', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('134', '000000002000000134', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('135', '000000002000000135', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('136', '000000002000000136', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('137', '000000002000000137', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('138', '000000002000000138', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('139', '000000002000000139', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('140', '000000002000000140', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('141', '000000002000000141', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('142', '000000002000000142', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('143', '000000002000000143', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('144', '000000002000000144', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('145', '000000002000000145', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('146', '000000002000000146', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('147', '000000002000000147', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('148', '000000002000000148', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('149', '000000002000000149', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('150', '000000002000000150', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('151', '000000002000000151', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('152', '000000002000000152', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('153', '000000002000000153', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('154', '000000002000000154', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('155', '000000002000000155', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('156', '000000002000000156', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('157', '000000002000000157', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('158', '000000002000000158', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('159', '000000002000000159', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('160', '000000002000000160', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('161', '000000002000000161', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('162', '000000002000000162', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('163', '000000002000000163', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('164', '000000002000000164', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('165', '000000002000000165', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('166', '000000002000000166', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('167', '000000002000000167', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('168', '000000002000000168', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('169', '000000002000000169', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('170', '000000002000000170', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('171', '000000002000000171', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('172', '000000002000000172', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('173', '000000002000000173', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('174', '000000002000000174', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('175', '000000002000000175', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('176', '000000002000000176', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('177', '000000002000000177', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('178', '000000002000000178', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('179', '000000002000000179', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('180', '000000002000000180', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('181', '000000002000000181', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('182', '000000002000000182', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('183', '000000002000000183', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('184', '000000002000000184', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('185', '000000002000000185', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('186', '000000002000000186', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('187', '000000002000000187', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('188', '000000002000000188', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('189', '000000002000000189', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('190', '000000002000000190', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('191', '000000002000000191', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('192', '000000002000000192', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('193', '000000002000000193', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('194', '000000002000000194', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('195', '000000002000000195', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('196', '000000002000000196', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('197', '000000002000000197', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('198', '000000002000000198', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('199', '000000002000000199', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('200', '000000002000000200', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('201', '000000002000000201', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('202', '000000002000000202', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('203', '000000002000000203', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('204', '000000002000000204', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('205', '000000002000000205', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('206', '000000002000000206', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('207', '000000002000000207', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('208', '000000002000000208', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('209', '000000002000000209', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('210', '000000002000000210', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('211', '000000002000000211', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('212', '000000002000000212', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('213', '000000002000000213', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('214', '000000002000000214', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('215', '000000002000000215', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('216', '000000002000000216', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('217', '000000002000000217', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('218', '000000002000000218', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('219', '000000002000000219', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('220', '000000002000000220', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('221', '000000002000000221', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('222', '000000002000000222', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('223', '000000002000000223', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('224', '000000002000000224', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('225', '000000002000000225', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('226', '000000002000000226', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('227', '000000002000000227', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('228', '000000002000000228', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('229', '000000002000000229', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('230', '000000002000000230', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('231', '000000002000000231', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('232', '000000002000000232', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('233', '000000002000000233', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('234', '000000002000000234', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('235', '000000002000000235', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('236', '000000002000000236', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('237', '000000002000000237', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('238', '000000002000000238', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('239', '000000002000000239', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('240', '000000002000000240', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('241', '000000002000000241', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('242', '000000002000000242', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('243', '000000002000000243', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('244', '000000002000000244', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('245', '000000002000000245', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('246', '000000002000000246', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('247', '000000002000000247', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('248', '000000002000000248', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('249', '000000002000000249', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);
INSERT INTO `orders` VALUES ('250', '000000002000000250', 'XSD-20180113-hhs003', '3', 'wenchen', 'hehaishui', '21fza', 'wenchen', '2018-01-13', null);

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `NAME` varchar(255) DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '内部员工');
INSERT INTO `role` VALUES ('2', '超级管理员');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wine
-- ----------------------------
INSERT INTO `wine` VALUES ('1', '金龙泉啤酒', '3', '2018-01-03', 'fazfdfdsfdsfdsfsda');
INSERT INTO `wine` VALUES ('2', '雪花啤酒', '3', '2018-01-03', 'dfvfefefe');
INSERT INTO `wine` VALUES ('3', '青岛啤酒', '3', '2018-01-02', 'rewrere');
INSERT INTO `wine` VALUES ('4', '台湾啤酒', '3', '2018-01-03', 'babadasd 参数的菜单发生的');
INSERT INTO `wine` VALUES ('5', '米酒', '5', '2018-01-12', 'fdsafsdfsf');

-- ----------------------------
-- View structure for `v_order`
-- ----------------------------
DROP VIEW IF EXISTS `v_order`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_order` AS (select `o`.`ID` AS `ORDER_ID`,`o`.`TXM` AS `TXM`,`o`.`XSDH` AS `XSDH`,`w`.`MC` AS `WINE_MC`,`u1`.`NAME` AS `SHY`,`u2`.`NAME` AS `YWY`,`u3`.`NAME` AS `KDR`,`c`.`NAME` AS `SHZ`,`c`.`PHONE` AS `KHDH`,`c`.`ADDRESS` AS `SHDZ`,`o`.`DATE` AS `DATE`,`d`.`MC` AS `BMMC`,`d`.`TITLE` AS `BM_TITLE`,`d`.`PIC_URL` AS `PIC_URL`,`o`.`REMARK` AS `REMARK` from ((((((`orders` `o` join `wine` `w` on((`w`.`ID` = `o`.`WINE_ID`))) join `chu_user` `u1` on((`u1`.`UNAME` = `o`.`SHY`))) join `chu_user` `u2` on((`u2`.`UNAME` = `o`.`YWY`))) join `chu_user` `u3` on((`u3`.`UNAME` = `o`.`KDR`))) join `customer` `c` on((`c`.`UNAME` = `o`.`SHZ`))) join `dept` `d` on((`d`.`ID` = `u3`.`BM_ID`)))) ;
