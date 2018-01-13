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
   <form id="editCustomerForm">
   	<div>
   		<table><tr><td style="height: 40px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">客户名称:</td><td style="padding-left: 10px;"><input id="editCustomer_txbuname" name="uname"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">负责人:</td><td style="padding-left: 10px;"><input id="editCustomer_txbname" name="name"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">联系电话:</td><td style="padding-left: 10px;"><input id="editCustomer_txbphone" name="phone"/></td><td></td></tr>
   			<tr><td></td><td>送货地址:</td><td style="padding-left: 10px;"><input id="editCustomer_txbaddress" name="address"/></td><td></td></tr>
   		</table>
   		<table>
   			<tr><td style="height: 20px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="editCustomer.insertCustomer()" href="#">确认</a></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="editCustomer.cancel()" href="#">取消</a></td></tr>
   		</table>
   	</div>
  </form>
<script type="text/javascript">
	var editCustomer = {
		
		cancel: function () {
			$("#Customer_newEdit").dialog ("close");
		},
		
		insertCustomer: function () {
			$.messager.progress();
			$("#editCustomerForm").form("submit",{
				url: getContextPath() + "/data/editCustomer",
				onSubmit: function (param) {
					var validate = $("#editCustomerForm").form("validate");
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					param.id = ${customer.id};
					alert("${customer.uname}");
					param.uname = "${customer.uname}";
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#Customer_newEdit").dialog ("close");
						$("#dgCustomerList").datagrid("reload");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
		}
			
	};
	
	$("#editCustomer_txbuname").textbox({
		required: true,
		value:"${customer.uname}",
		disabled:true,
		width: 200,
	});
	
	$("#editCustomer_txbname").textbox({
		value:"${customer.name}",
		required: true,
		width: 200,
	});
	
	$("#editCustomer_txbphone").textbox({
		value:"${customer.phone}",
		width: 200,
	});
	
	$("#editCustomer_txbaddress").textbox({
		value:"${customer.address}",
		multiline:true,
		width: 200,
		height:60
	});
	
	
</script>
  </body>
</html>
