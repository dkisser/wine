<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" import="org.lf.utils.AdminProperties"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北白云边酒业管理平台</title>
<%String baseUrl = AdminProperties.SERVER_URL; %>
<link rel="stylesheet" type="text/css" href="<%=baseUrl %>/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=baseUrl %>/js/easyui/themes/icon.css">
<script type="text/javascript" src="<%=baseUrl %>/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=baseUrl %>/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=baseUrl %>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=baseUrl %>/js/swh_admin.js"></script>
<script src="<%=baseUrl %>/dist/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="<%=baseUrl %>/dist/sweetalert.css">
<style type="text/css">
*{margin:0;padding: 0}
a{text-decoration: none;color: #eee} 
.header-right ul{
    list-style: none;
    width: 50%;
    height: 25px;
    right: 0;
    bottom:1px;
    position: absolute;
}
.header-right ul li{
    float: left;
    margin:0 5px;
    width: 100px;
    height:100%;
    background:url(../images/main/btn.png);
    text-align: center;
    color: #eee; 
    line-height:25px;
    font-family: "微软雅黑";	
    border-radius: 4px;
    font-size: 14px;
}

.header-right ul li a:hover {
 	font-size: 15px;
 	font-weight: bold;
}

.welcomeBg{
	width:100%;
	hieght:600px;
	background:url(../images/main/welcome.jpg);
    background-size:100% 100%;
    filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/main/welcome.jpg',sizingMethod='scale');
}
.style7 {font-size: 12px; color: #FFF; }
.STYLE3 {
    font-size: 12px;
    color: #435255;
}
/*td{background:#fe1002}*/
.STYLE4 {font-size: 12px}
.STYLE5 {font-size: 12px; font-weight: bold; }
.link_color{color:#3399CC; text-decoration:none;font-weight:bold;}/*链接设置*/
.link_color:visited{color:#3399CC; text-decoration:none;font-weight:bold;}/*访问过的链接设置*/
.link_color:hover{color:#3399CC; text-decoration:none;font-weight:bold;}/*鼠标放上的链接设置*/
</style>
</head>
<body >
	<div class="easyui-layout" data-options="border:true,fit:true">
        <div style="height:132px;padding: 0px;margin: 0px;overflow: hidden;"
            data-options="border:true,region:'north',split:false">            
            <div class="header" style="width:100%;height:100px;background:url(../images/main/top.png);background-size:cover">
                 <div class="header-left" style="width:50%;height:100%;float:left"></div>
                 <div class="header-right" style="width:50%;height:100%;float:right;position:relative" >
                     <ul>
                        <li><a href="###" onclick="updatepwd();" >修改密码</a></li>
                        <li><a href="###" onclick="currUser();">用户信息</a></li>
                        <li><a href="###" onclick="quit();">退出系统</a></li>
                     </ul>
                 </div>
            </div> 
            <div class="menu" style="width:100%;height:32px;background:url(../images/main/nav.png);border:none">   

        	</div>
        </div>
        <div id="center" class="welcomeBg"
                        data-options="region:'center',
                                split:false,
                                href:'<%=baseUrl %>/home/welcome.do'">      
        </div>
     </div>
<script type="text/javascript" src="<%=baseUrl %>/js/home.js"></script> 
<script type="text/javascript">

function getMenuParent(parent,i) {
	return "<a href=\"javascript:void(0)\" id=\"MenuBtn"+i+"\">"+parent+"</a>";
}

function getMenuItem(title,url) {
	return "<div data-options=\"iconCls:'icon-filter'\" onclick=\"changeCenter('${pageContext.servletContext.contextPath }"+url+"')\">"+title+"</div>";
}

var resultStr ="";

$.ajax ({
	url: getContextPath() + "/home/getMenuByUname.do",
	cache:  false,
	async: true,
	data: {"uname":"${sessionScope.loginInfo.uname}"},
	dataType:"json",
	success: function (result) {
		for (var i=0;i<result.length;i++) {
			resultStr += "<div style=\"float: left;margin: 3px;\">"
							+ getMenuParent(result[i].parent.name,i)
							+"<div id=\"menu"+i+"\">";
			for (var j=0;j<result[i].child.length;j++) {
				resultStr += getMenuItem(result[i].child[j].name,result[i].child[j].url);
							
			}
			resultStr += "</div>"
						+"</div>";
		}
		resultStr += "<div style=\"float:right;width:150px;line-height:30px;color:#fff;text-align: center;margin-right:50px;background-color:rgba(255,255,255,0.4);border-radius:10px;font-size:15px\">欢迎:${sessionScope.loginInfo.name}</div>"
			        +"<div id=\"pwddialog\" style=\"display: none;overflow:hidden;\"></div>"
			        +"<div id=\"currUser\" style=\"display: none;overflow:hidden;\"></div>";
		$(".menu").html(resultStr);
		
		for (var i=0;i<result.length;i++) {
			$('#MenuBtn'+i).css('color','#fff');
			$('#MenuBtn'+i).menubutton({
				iconCls : 'icon-large-picture',
				plain : true,
				menu : '#menu'+i,
			});
		}
	},
	error: function () {
		
	}
	
	
});

</script>                      
</body>
</html>