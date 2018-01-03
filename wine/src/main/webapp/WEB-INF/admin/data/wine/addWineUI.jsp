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
   <form id="addWineForm">
   	<div>
   		<table><tr><td style="height: 40px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">酒名:</td><td><input id="addWine_txbmc" name="mc"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">零售价:</td><td><input id="addWine_txbprice" name="price"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">出厂日期:</td><td><input id="addWine_txbdate" name="date"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">备注:</td><td><input id="addWine_txbremark" name="remark"/></td><td></td></tr>
   		</table>
   		<table>
   			<tr><td style="height: 40px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="addWine.insertWine()" href="#">确认</a></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="addWine.cancel()" href="#">取消</a></td></tr>
   		</table>
   	</div>
  </form>
<script type="text/javascript">
	var addWine = {
		
		cancel: function () {
			$("#Wine_newAdd").dialog ("close");
		},
		
		insertWine: function () {
			$.messager.progress();
			$("#addWineForm").form("submit",{
				url: getContextPath() + "/data/addWine",
				onSubmit: function (param) {
					
					var validate = $("#addWineForm").form("validate");
					
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#Wine_newAdd").dialog ("close");
						$("#dgWineList").datagrid("reload");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
		}
			
	};
	
	$("#addWine_txbmc").textbox({
		required: true,
	});
	
	$("#addWine_txbmc").textbox("textbox").blur(function () {

		$.ajax({
			url: getContextPath() + "/data/checkWineByName",
			cache: false,
			async:true,
			data:{"mc":$("#addWine_txbmc").val()},
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
	
	$("#addWine_txbprice").numberbox({
		required: true
	});
	
	$("#addWine_txbdate").datebox({
		required:true,
		editable:false
	});
	
	$("#addWine_txbremark").textbox({
		height:60,
		multiline:true
	});
	
	
</script>
  </body>
</html>
