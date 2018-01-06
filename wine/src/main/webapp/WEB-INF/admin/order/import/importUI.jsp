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
   <div id="dlgImportMain" >
   <form id="ImportWineForm" enctype="multipart/form-data" method="POST">
   		<table><tr><td style="height: 40px;"></td></tr></table>
   		<table>
   			<tr><td style="width:120px;"></td><td style="text-align: right;">酒品种:</td><td><input id="importWine_txbwineId" name="wineName"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">业务员:</td><td><input id="importWine_txbywy" name="ywyName"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">送货员:</td><td><input id="importWine_txbshy" name="shyName"/></td><td></td></tr>
   			<tr><td></td><td style="text-align: right;">收货人:</td><td><input id="importWine_txbshr" name="shrName"/></td><td></td></tr>
   			<tr><td style="width:105px;"></td><td style="text-align: right;">录入文件:</td><td><input id="importWine_txbfile" name="file"/></td><td></td></tr>
   		</table>
   </form>
   		<table>
   			<tr><td style="height: 40px;"></td></tr>
   			<tr><td style="width:140px;"></td><td style="width:200px; text-align:center;"><a id="importBtn" onclick="importWine.importWine()">确认</a></td></tr>
   		</table>
  </div>
<script type="text/javascript">
	var importWine = {
		
		importWine: function () {
			$.messager.progress();
			$("#ImportWineForm").form("submit",{
				url: getContextPath() + "/order/importWine",
				onSubmit: function (param) {
					var validate = $("#ImportWineForm").form("validate");
					if (!validate) {
						$.messager.progress("close");
						return validate;
					}
					param.wineId=$("#importWine_txbwineId").attr("wineId");
					param.shy = $("#importWine_txbshy").attr("shy");
					param.ywy = $("#importWine_txbywy").attr("ywy");
					param.shz = $("#importWine_txbshr").attr("shr");
				},
				success:function (result) {
					result = eval("("+result+")");
					$.messager.progress("close");
					if (result == "success") {
						$("#importWine_txbwineId").textbox("clear");
						$("#importWine_txbshy").textbox("clear");
						$("#importWine_txbywy").textbox("clear");
						$("#importWine_txbshr").textbox("clear");
						$("#importWine_txbfile").textbox("clear");
						$.messager.alert("提示"," 上传成功","info");
					} else {
						$.messager.alert("提示",result,"info");
					}
				}
				
			});
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
		inline:true,
		onClose:function (){
			$("#dlgImportMain").remove();
		}
	});
	
	$("#importWine_txbwineId").textbox({
		width: 200,
		required: true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var import_newChooseWine = $("<div id='import_newChooseWine'></div>");
	    	import_newChooseWine.appendTo("#center");
			$("#import_newChooseWine").dialog ({
				href: getContextPath() + "/order/chooseWineUI",
				title: "选择送货员",
				width: 1024,
				height: 600,
				inline: true,
				modal:true,
				onClose:function (){
					$("#import_newChooseWine").remove();
				}
			});
	    }
	});
	
	$("#importWine_txbshy").textbox({
		width: 200,
		required:true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var import_newChooseShy = $("<div id='import_newChooseShy'></div>");
	    	import_newChooseShy.appendTo("#center");
			$("#import_newChooseShy").dialog ({
				href: getContextPath() + "/order/chooseShyUI",
				title: "选择送货员",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#import_newChooseShy").remove();
				}
			});
	    }
	});
	
	$("#importWine_txbywy").textbox({
		width: 200,
		required:true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var import_newChooseYwy = $("<div id='import_newChooseYwy'></div>");
	    	import_newChooseYwy.appendTo("#center");
			$("#import_newChooseYwy").dialog ({
				href: getContextPath() + "/order/chooseYwyUI",
				title: "选择业务员",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#import_newChooseYwy").remove();
				}
			});
	    }
	});
	
	$("#importWine_txbshr").textbox({
		width: 200,
		required:true,
		editable:false,
		buttonText:'查找',    
	    iconAlign:'right',
	    onClickButton: function (){
	    	var import_newChooseShr = $("<div id='import_newChooseShr'></div>");
	    	import_newChooseShr.appendTo("#center");
			$("#import_newChooseShr").dialog ({
				href: getContextPath() + "/order/chooseShrUI",
				title: "选择收货人",
				width: 612,
				height: 400,
				inline: true,
				modal:true,
				onClose:function (){
					$("#import_newChooseShr").remove();
				}
			});
	    }
	});
	
	$("#importWine_txbfile").filebox({
		buttonText:"选择文件",
		width: 200,
		required:true,
		editable:false,
		accept:[".xlsx",".txt",".xls"]
	});
	
</script>
  </body>
</html>
