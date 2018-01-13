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
	<div id="ChooseYwyToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;"></div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">姓名：</div>
	        <div style="float: left;padding-top: 5px;"><input id="txbChooseYwyName" name="name"/></div>
	        <div style="float: left;padding-left:30px;padding-top: 5px;">电话号码：</div>
	        <div style="float: left;padding-right:30px;padding-top: 5px;"><input id="txbChooseYwyPhone" name="phone"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgChooseYwyList"></div>
<script type="text/javascript">

	var ChooseYwy = {
		choose:function (index){
			var chooseRow = $("#dgChooseYwyList").datagrid("getData").rows[index];
			$("#addOrder_txbywy").textbox("setValue",chooseRow.name);
			$("#addOrder_txbywy").attr("ywy",chooseRow.uname);
			$("#addOrder_newChooseYwy").dialog("close");
		}	
	};
	
	$("#txbChooseYwyName").textbox({
		width: 140,
		 buttonText:'查看',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getYwyList?name="+$("#txbChooseYwyName").textbox("getText")+"&phone="+$("#txbChooseYwyPhone").textbox("getText");
			$("#dgChooseYwyList").datagrid("reload",url);
		 },
	});
	
	$("#txbChooseYwyPhone").textbox({
		 width: 140,
		 buttonText:'查看',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getYwyList?name="+$("#txbChooseYwyName").textbox("getText")+"&phone="+$("#txbChooseYwyPhone").textbox("getText");
			$("#dgChooseYwyList").datagrid("reload",url);
		 },
	});
	
	$("#dgChooseYwyList").datagrid({
		url: getContextPath() + "/order/getYwyList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#ChooseYwyToolbar",
		pagination:true,
		pageSize:5,
		pageList:['5'],
		columns: [[
		           {
		        	  width: "17%",
		        	  title: "用户名",
		        	  field: "uname",
		        	  align: "center",
		           },{
		        	  width: "17%",
		        	  title: "姓名",
			          field: "name",
			          align: "center", 
		           },{
		        	  width: "28%",
		        	  title: "联系电话",
			          field: "phone",
			          align: "center", 
		           },{
		        	  width: "20%",
			          title: "今日销售数",
				      field: "xs",
				      align: "center", 
			       },{
			    	  width: "14%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      formatter: function (value,row,index) {
				    	  return "<a class='chooseCusBtn' onclick='ChooseYwy.choose("+index+")'>选择</a>";
				      }
				   }
		           ]],
		           onLoadSuccess: function () {
		        	 $(".chooseCusBtn").linkbutton({
		        		 iconCls: "icon-ok",
		        		 iconAlign: "left",
		        		 height: 24,
		        	 });
		           },
	});
</script>
</body>
</html>
