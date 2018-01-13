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
	<div id="ChooseShyToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;"></div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">姓名：</div>
	        <div style="float: left;padding-top: 5px;"><input id="txbChooseShyName" name="name"/></div>
	        <div style="float: left;padding-left:30px;padding-top: 5px;">电话号码：</div>
	        <div style="float: left;padding-right:30px;padding-top: 5px;"><input id="txbChooseShyPhone" name="phone"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgChooseShyList"></div>
<script type="text/javascript">

	var ChooseShy = {
		choose:function (index){
			var chooseRow = $("#dgChooseShyList").datagrid("getData").rows[index];
			$("#addOrder_txbshy").textbox("setValue",chooseRow.name);
			$("#addOrder_txbshy").attr("shy",chooseRow.uname);
			$("#addOrder_newChooseShy").dialog("close");
		}	
	};
	
	$("#txbChooseShyName").textbox({
		width: 140,
		 buttonText:'查看',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getShyList?name="+$("#txbChooseShyName").textbox("getText")+"&phone="+$("#txbChooseShyPhone").textbox("getText");
			$("#dgChooseShyList").datagrid("reload",url);
		 },
	});
	
	$("#txbChooseShyPhone").textbox({
		 width: 140,
		 buttonText:'查看',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getShyList?name="+$("#txbChooseShyName").textbox("getText")+"&phone="+$("#txbChooseShyPhone").textbox("getText");
			$("#dgChooseShyList").datagrid("reload",url);
		 },
	});
	
	$("#dgChooseShyList").datagrid({
		url: getContextPath() + "/order/getShyList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#ChooseShyToolbar",
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
			          title: "简称",
				      field: "jc",
				      align: "center", 
			       },{
			    	  width: "14%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      formatter: function (value,row,index) {
				    	  return "<a class='chooseCusBtn' onclick='ChooseShy.choose("+index+")'>选择</a>";
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
