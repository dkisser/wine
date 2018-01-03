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
   <form id="editWineForm">
   	<div>
   		<table><tr><td style="height: 40px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">酒名:</td><td><input id="editWine_txbmc" name="mc"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">零售价:</td><td><input id="editWine_txbprice" name="price"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">出厂日期:</td><td><input id="editWine_txbdate" name="date"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">备注:</td><td><input id="editWine_txbremark" name="remark"/></td><td></td></tr>
   		</table>
   		<table>
   			<tr><td style="height: 40px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="editWine.editWine()" href="#">确认</a></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="editWine.cancel()" href="#">取消</a></td></tr>
   		</table>
   	</div>
  </form>
<script type="text/javascript">
function FormatDate(date) {
	
	return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}
	var editWine = {
		
		cancel: function () {
			$("#Wine_newEdit").dialog ("close");
		},
		
		editWine: function () {
			$.messager.progress();
			$("#editWineForm").form("submit",{
				url: getContextPath() + "/data/editWine",
				onSubmit: function (param) {
					var validate = $("#editWineForm").form("validate");
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					param.id = "${wine.id}";
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#Wine_newEdit").dialog ("close");
						$("#dgWineList").datagrid("reload");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
		}
			
	};
	$("#editWine_txbmc").textbox({
		value:"${wine.mc}",
		required: true,
		disabled:true
	});
	
	$("#editWine_txbprice").numberbox({
		value:"${wine.price}",
		required: true
	});
	
	$("#editWine_txbdate").datebox({
		value:FormatDate(new Date("${wine.date}")),
		required:true,
		editable:false
	});
	
	$("#editWine_txbremark").textbox({
		value:"${wine.remark}",
		height:60,
		multiline:true
	});
	
	
</script>
  </body>
</html>
