<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>白云边酒业后勤管理平台</title>
   	<link>
	<meta charset="utf-8">
	<script type="text/javascript" src="${pageContext.servletContext.contextPath }/js/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath }/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath }/js/swh_admin.js"></script>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath }/js/home.js"></script> 
	<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/css/byb.css">
	<style type="text/css">
		body{
			
			margin: 0;
			padding: 0;
		
		}
		.container{
            width: 100%;
            height: 100%;
            background-image: url(images/home/home_bg.jpg) ;
            background-repeat: no-repeat;
			background-size: 100% 100%;
            background-attachment: fixed;
            overflow: hidden;
	   }
	   .login_glass{
       		width:600px;
       		height:400px;
       		margin: auto;
       		margin-top: 100px;
       }
       .headimg{
       		margin: auto;
       		width: 50px;
       		height:50px;
       		padding-top: 30px;
       		
       }
       .headtext{
       		width: 200px;
       		margin: auto;
       		color: #FFDE00;
       		text-align: center;
       		font-size: 30px;
       		padding-top: 10px;
       }
       .loginitemdiv{
       		width: 300px;
       		margin: auto;
       		padding-left: 50px;
       		margin-top: 60px;
       		color:#f99;
       		font-size: 20px;
       }
       .loginitem{
       		width:150px;
       		height:30px;
       		padding-left: 5px;
       		background-color: #fff;
       		border: none;
       }
       .loginbutton{
       		margin:auto;
       		margin-top:50px;
       		width:100px;
       		height: 30px;
       		font-size: 20px;
       		text-align: center;
       		color: #fff;
       		border: 3px solid #fff;
       		cursor: pointer;
       		background-color: #FDDE00;
       }
       .loginbutton:hover
		{
			background-color: #DDDD00;
		}
    </style>
  </head>
  
  <body>
   	<div class='container'>
   	<form id="loginForm">
        <div class='login_glass yuanjiao touming2'>
       		<div class='headimg'><img src="${pageContext.servletContext.contextPath }/images/home/liandao.png" width="50px" height="50"></div>
        	<div class='headtext'>管理员登录</div>
        	<div class='loginitemdiv'>
        		<div style="margin-bottom: 20px;">账号：<input name="uname" class="loginitem yuanjiao"></div>
        		<div>密码：<input name="upw" type="password" class="loginitem yuanjiao"></div>
        	</div>
        	<div class="yuanjiao loginbutton" onclick="login()">登录</div>
        </div>
    </form>
    </div>
    <script type="text/javascript">
   	function login(){
		$("#loginForm").form("submit",{
			url: getContextPath() + "/home/loginAction",
			onSubmit: function () {
				
			},
			success: function (result) {
				var re = eval("("+result+")");
				if (re.success) {
					window.location.href = "${pageContext.servletContext.contextPath}/home/main";
				} else {
					alert("用户名密码错误!");
					window.location.href = "${pageContext.servletContext.contextPath}/home/loginUI";
				}
			},
		});    		
   	}
    </script>
  </body>
</html>
