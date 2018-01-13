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
   <form id="addOrderForm">
   		<table><tr><td style="height: 30px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">条形码:</td><td><input id="addOrder_txbtxm" name="txm"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">销售单号:</td><td><input id="addOrder_txbxsdh" name="xsdh"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">酒品种:</td><td><input id="addOrder_txbwineId" name="wineName"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">业务员:</td><td><input id="addOrder_txbywy" name="ywyName"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">送货员:</td><td><input id="addOrder_txbshy" name="shyName"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">收货人:</td><td><input id="addOrder_txbshr" name="shrName"/></td><td></td></tr>
   		</table>
   </form>
   		<table>
   			<tr><td style="height: 20px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:100px; text-align:center;"><a id="importBtn" onclick="addOrder.addOrder()">确认</a></td><td style="width:100px; text-align:center;"><a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="addOrder.cancel()" href="#">取消</a></td></tr>
   		</table>
<script type="text/javascript">
	var addOrder = {
			
		addOrder: function () {
			$.messager.progress();
			$("#addOrderForm").form("submit",{
				url: getContextPath() + "/order/addOrder",
				onSubmit: function (param) {
					var validate = $("#addOrderForm").form("validate");
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					param.wineId=$("#addOrder_txbwineId").attr("wineId");
					param.shy = $("#addOrder_txbshy").attr("shy");
					param.ywy = $("#addOrder_txbywy").attr("ywy");
					param.shz = $("#addOrder_txbshr").attr("shr");
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#addOrder_txbwineId").textbox("clear");
						$("#addOrder_txbshy").textbox("clear");
						$("#addOrder_txbywy").textbox("clear");
						$("#addOrder_txbshr").textbox("clear");
						$("#addOrder_txbfile").textbox("clear");
						$("#Query_newAdd").dialog("close");
						$.messager.alert("提示","添加成功","info");
						$("#dgQueryList").datagrid("reload");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
		},
		
		cancel:function (){
			$("#Query_newAdd").dialog("close");
		}
			
	};
	
	$("#importBtn").linkbutton({
		iconCls:"icon-ok",
	});
	
	$("#dlgImportMain").dialog({
		title : '数据录入',
		width : 512,
		height : 300,
		closed : false,
		cache : false,
		modal : true,
		onClose:function (){
			$("#dlgImportMain").remove();
		}
	});
	
	$("#addOrder_txbtxm").numberbox({
		width: 200,
		required: true
	});
	
	$("#addOrder_txbxsdh").textbox({
		width: 200,
		required: true
	});
	
	$("#addOrder_txbwineId").textbox({
		width: 200,
		required: true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var addOrder_newChooseWine = $("<div id='addOrder_newChooseWine'></div>");
	    	addOrder_newChooseWine.appendTo("body");
			$("#addOrder_newChooseWine").dialog ({
				href: getContextPath() + "/order/addChooseWineUI",
				title: "选择送货员",
				width: 1024,
				height: 600,
				inline: true,
				modal:true,
				onClose:function (){
					$("#addOrder_newChooseWine").remove();
				}
			});
	    }
	});
	
	$("#addOrder_txbshy").textbox({
		width: 200,
		required:true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var addOrder_newChooseShy = $("<div id='addOrder_newChooseShy'></div>");
	    	addOrder_newChooseShy.appendTo("body");
			$("#addOrder_newChooseShy").dialog ({
				href: getContextPath() + "/order/addChooseShyUI",
				title: "选择送货员",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#addOrder_newChooseShy").remove();
				}
			});
	    }
	});
	
	$("#addOrder_txbywy").textbox({
		width: 200,
		required:true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var addOrder_newChooseYwy = $("<div id='addOrder_newChooseYwy'></div>");
	    	addOrder_newChooseYwy.appendTo("body");
			$("#addOrder_newChooseYwy").dialog ({
				href: getContextPath() + "/order/addChooseYwyUI",
				title: "选择业务员",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#addOrder_newChooseYwy").remove();
				}
			});
	    }
	});
	
	$("#addOrder_txbshr").textbox({
		width: 200,
		required:true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var addOrder_newChooseShr = $("<div id='addOrder_newChooseShr'></div>");
	    	addOrder_newChooseShr.appendTo("body");
			$("#addOrder_newChooseShr").dialog ({
				href: getContextPath() + "/order/addChooseShrUI",
				title: "选择收货人",
				width: 612,
				height: 400,
				inline: true,
				modal:true,
				onClose:function (){
					$("#addOrder_newChooseShr").remove();
				}
			});
	    }
	});
	
</script>
  </body>
</html>
