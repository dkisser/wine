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
   <form id="editNbryForm">
   	<div>
   		<table><tr><td style="height: 30px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">用户名:</td><td><input id="editNbry_txbuname" name="uname"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">姓名:</td><td><input id="editNbry_txbname" name="name"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">联系电话:</td><td><input id="editNbry_txbphone" name="phone"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">人员类型:</td><td><input id="editNbry_cbxrylx" name="rylx"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">系统类型:</td><td><input id="editNbry_cbxrole" name="role"/></td><td></td></tr>
   		</table>
   		<table>
   			<tr><td style="height: 20px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="editNbry.insertNbry()" href="#">确认</a></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="editNbry.cancel()" href="#">取消</a></td></tr>
   		</table>
   	</div>
  </form>
<script type="text/javascript">
	var editNbry = {
		
		cancel: function () {
			$("#Nbry_newEdit").dialog ("close");
		},
		
		insertNbry: function () {
			$.messager.progress();
			$("#editNbryForm").form("submit",{
				url: getContextPath() + "/data/editNbry",
				onSubmit: function (param) {
					
					var validate = $("#editNbryForm").form("validate");
					
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					param.id="${nbry.id}";
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#Nbry_newEdit").dialog ("close");
						$("#dgNbryList").datagrid("reload");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
		}
			
	};
	
	$("#editNbry_txbuname").textbox({
		disabled:true,
		value:"${nbry.uname}"
	});
	
	$("#editNbry_txbname").textbox({
		required: true,
		value:"${nbry.name}"
	});
	
	$("#editNbry_txbphone").numberbox({
		required:true,
		value:"${nbry.phone}"
	});
	$("#editNbry_cbxrylx").combobox({
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
	    }],
	    onLoadSuccess:function (){
	    	$(this).combobox("setValue","${nbry.rylx}");
	    }
	});
	$("#editNbry_cbxrole").combobox({
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
	    }],
	    onLoadSuccess:function (){
	    	$(this).combobox("setValue","${nbry.role}");
	    }
	});
	
	
</script>
  </body>
</html>
