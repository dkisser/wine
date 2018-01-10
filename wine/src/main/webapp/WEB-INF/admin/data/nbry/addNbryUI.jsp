<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title></title>
	<meta charset="utf-8">
  </head>
  
  <body>
   <form id="addNbryForm">
   	<div>
   		<table><tr><td style="height: 30px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">用户名:</td><td><input id="addNbry_txbuname" name="uname"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">姓名:</td><td><input id="addNbry_txbname" name="name"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">密码:</td><td><input id="addNbry_txbupw" type="password" name="upw"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">联系电话:</td><td><input id="addNbry_txbphone" name="phone"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">人员类型:</td><td><input id="addNbry_cbxrylx" name="rylx"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">系统类型:</td><td><input id="addNbry_cbxrole" name="role"/></td><td></td></tr>
   		</table>
   		<table>
   			<tr><td style="height: 20px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="addNbry.insertNbry()" href="#">确认</a></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="addNbry.cancel()" href="#">取消</a></td></tr>
   		</table>
   	</div>
  </form>
<script type="text/javascript">
	var addNbry = {
		
		cancel: function () {
			$("#Nbry_newAdd").dialog ("close");
		},
		
		insertNbry: function () {
			$.messager.progress();
			$("#addNbryForm").form("submit",{
				url: getContextPath() + "/data/addNbry",
				onSubmit: function (param) {
					
					var validate = $("#addNbryForm").form("validate");
					
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					var is = false;
					$.ajax({
						url: getContextPath() + "/data/checkNbryByUname",
						cache: false,
						async:false,
						data:{"uname":$("#addNbry_txbuname").val()},
						dataType: "json",
						success: function (result) {
							alert(result);
							if (result == "success") {
								is = true;
							} else {
								$.messager.alert("提示",result,"info");
							}
						},
						error: function () {
							alert("Ajax error!");
						}
					});
					if (!is){
						$.messager.progress("close");
						return is; 
					}
					
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#Nbry_newAdd").dialog ("close");
						$("#dgNbryList").datagrid("reload");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
		}
			
	};
	
	$("#addNbry_txbuname").textbox({
		required: true,
	});
	
	$("#addNbry_txbuname").textbox("textbox").blur(function () {

		$.ajax({
			url: getContextPath() + "/data/checkNbryByUname",
			cache: false,
			async:true,
			data:{"uname":$("#addNbry_txbuname").val()},
			dataType: "json",
			success: function (result) {
				if (result == "success") {
					
				} else {
					$.messager.alert("提示",result,"info");
				}
			},
			error: function () {
				alert("Ajax error!");
			}
		});
	});
	
	$("#addNbry_txbname").textbox({
		required: true
	});
	
	$("#addNbry_txbupw").textbox({
		required:true,
	});
	
	$("#addNbry_txbphone").numberbox({
		required:true,
	});
	$("#addNbry_cbxrylx").combobox({
		required:true,
		editable:false,
		valueField: 'id',    
	    textField: 'text',
	    data:[{
	    	id:'0',
	    	text:"业务员"
	    },{
	    	id:'1',
	    	text:"送货员"
	    }]
	});
	$("#addNbry_cbxrole").combobox({
		required:true,
		editable:false,
		valueField: 'id',    
	    textField: 'text',
	    data:[{
	    	id:'1',
	    	text:"普通员工"
	    },{
	    	id:'2',
	    	text:"超级管理员"
	    }]
	});
	
	
</script>
  </body>
</html>
