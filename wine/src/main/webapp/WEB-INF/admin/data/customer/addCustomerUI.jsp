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
   <form id="addCustomerForm">
   	<div>
   		<table><tr><td style="height: 40px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">客户名称:</td><td style="padding-left: 10px;"><input id="addCustomer_txbuname" name="uname"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">负责人:</td><td style="padding-left: 10px;"><input id="addCustomer_txbname" name="name"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">联系电话:</td><td style="padding-left: 10px;"><input id="addCustomer_txbphone" name="phone"/></td><td></td></tr>
   			<tr><td></td><td>送货地址:</td><td style="padding-left: 10px;"><input id="addCustomer_txbaddress" name="address"/></td><td></td></tr>
   		</table>
   		<table>
   			<tr><td style="height: 20px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="addCustomer.insertCustomer()" href="#">确认</a></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="addCustomer.cancel()" href="#">取消</a></td></tr>
   		</table>
   	</div>
  </form>
<script type="text/javascript">
	var addCustomer = {
		
		cancel: function () {
			$("#Customer_newAdd").dialog ("close");
		},
		
		insertCustomer: function () {
			$.messager.progress();
			$("#addCustomerForm").form("submit",{
				url: getContextPath() + "/data/addCustomer",
				onSubmit: function (param) {
					
					var validate = $("#addCustomerForm").form("validate");
					
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#Customer_newAdd").dialog ("close");
						$("#dgCustomerList").datagrid("reload");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
		}
			
	};
	
	$("#addCustomer_txbuname").textbox({
		required: true,
		width: 200
	});
	
	$("#addCustomer_txbuname").textbox("textbox").blur(function () {

		$.ajax({
			url: getContextPath() + "/data/checkCustomerByUname",
			cache: false,
			async:true,
			data:{"uname":$("#addCustomer_txbuname").val()},
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
	
	$("#addCustomer_txbname").textbox({
		required: true,
		width: 200,
	});
	
	$("#addCustomer_txbphone").textbox({
		width: 200,
	});
	
	$("#addCustomer_txbaddress").textbox({
		multiline:true,
		width: 200,
		height:60
	});
	
	
</script>
  </body>
</html>
