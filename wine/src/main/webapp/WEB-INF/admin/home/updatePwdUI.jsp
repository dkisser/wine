<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'home.jsp' starting page</title>
   	<link>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/css/jcdj.css">
	
  </head>
  <body>
  <form id="updatePwdForm">
   		<table>
			<tr><td style="height: 70px;"></td></tr>
			<tr><td style="width: 130px;"></td><td style="text-align: right;">用户名:</td><td><input style="width:180px;" id="txbUpwduname" name="uname" /></td></tr>
			<tr><td></td><td style="text-align: right;">原密码:</td><td><input style="width:180px;" type="password" id="oldupwtxb" name="old_upw" /></td></tr>
			<tr><td></td><td style="text-align: right;">新密码:</td><td><input style="width:180px;" type="password" id="newupwtxb" name="new_upw" /></td></tr>
		</table>
  </form>
		<table>
			<tr><td style="height: 30px"></td></tr>
			<tr><td style="width: 140px;"></td><td style="width: 100px;text-align: center;"><a id="updateSave" class="easyui-linkbutton" iconCls="icon-ok">保存</a></td><td style="width: 100px;text-align: center;"><a id="updateCancel" class="easyui-linkbutton" iconCls="icon-cancel" >取消</a></td></tr>
		</table>
		<script type="text/javascript">
		$("#updateCancel").bind ("click",function () {
			$("#pwddialog").dialog("close");
		});
		
		$("#txbUpwduname").textbox ({
			disabled: true,
			iconAlign:"right",
			iconCls:"icon-lock",
			value:'${sessionScope.loginInfo.uname}',
		});
		
		$("#newupwtxb").textbox ({
			prompt:"请在此处输入新密码",
			required: true,
		});
		
		$("#oldupwtxb").textbox ({
			prompt:"请在此处输入原始密码",
			required: true,
		});
		$("#updateSave").bind("click",function () {
			$("#updatePwdForm").form("submit",{
				url: getContextPath() + "/home/updateUpwAction",
				onSubmit: function (param) {
					var validate = $("#updatePwdForm").form("validate");
					if (!validate) {
						return false;
					}
					param.uname="${loginInfo.uname}";
					
				},
				success: function (result) {
					result = eval("("+result+")");
					if (result.success) {
						alert("密码修改成功，请重新登录!");
						$("#pwddialog").dialog("close");
						window.location.href=getContextPath() +"/home/loginUI";
					} else {
						$.messager.alert("提示","原密码错误！","info");
					}
				},
			});
		});
		
		</script>
  </body>
</html>
