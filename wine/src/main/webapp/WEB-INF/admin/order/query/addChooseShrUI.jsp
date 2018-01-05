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
	<div id="ChooseShrToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;"></div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">姓名：</div>
	        <div style="float: left;padding-top: 5px;"><input id="txbChooseShrName" name="name"/></div>
	        <div style="float: left;padding-left: 30px;padding-top: 5px;">电话号码：</div>
	        <div style="float: left;padding-right: 30px;padding-top: 5px;"><input id="txbChooseShrPhone" name="phone"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgChooseShrList"></div>
<script type="text/javascript">

	var ChooseShr = {
		choose:function (index){
			var chooseRow = $("#dgChooseShrList").datagrid("getData").rows[index];
			$("#addOrder_txbshr").textbox("setValue",chooseRow.name);
			$("#addOrder_txbshr").attr("shr",chooseRow.uname);
			$("#addOrder_newChooseShr").dialog("close");
		}	
	};
	
	$("#txbChooseShrName").textbox({
		width: 200,
		 buttonText:'查看',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getCustomerList?name="+$("#txbChooseShrName").textbox("getText")+"&phone="+$("#txbChooseShrPhone").textbox("getText");
			$("#dgChooseShrList").datagrid("reload",url);
		 },
	});
	
	$("#txbChooseShrPhone").textbox({
		 width: 200,
		 buttonText:'查看',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getCustomerList?name="+$("#txbChooseShrName").textbox("getText")+"&phone="+$("#txbChooseShrPhone").textbox("getText");
			$("#dgChooseShrList").datagrid("reload",url);
		 },
	});
	
	$("#dgChooseShrList").datagrid({
		url: getContextPath() + "/data/getCustomerList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#ChooseShrToolbar",
		pagination:true,
		pageSize:10,
		pageList:['10'],
		columns: [[
		           {
		        	  width: "15%",
		        	  title: "用户名",
		        	  field: "uname",
		        	  align: "center",
		           },{
		        	  width: "15%",
		        	  title: "姓名",
			          field: "name",
			          align: "center", 
		           },{
		        	  width: "18%",
		        	  title: "联系电话",
			          field: "phone",
			          align: "center", 
		           },{
		        	  width: "36%",
			          title: "送货地址",
				      field: "address",
				      align: "center", 
				      formatter:function (value,row,index){
							if (value.length>12){
								return value.substring(0,12)+"...";
							}
							return value;
				      }
			       },{
			    	  width: "14%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      formatter: function (value,row,index) {
				    	  return "<a class='chooseCusBtn' onclick='ChooseShr.choose("+index+")'>选择</a>";
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
