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
  <div id="dlgCustomerMain">
    <div id="CustomerToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;">
	      	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="Customer.add()">新增</a>
	      </div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">姓名：</div>
	        <div style="float: left;padding-top: 5px;"><input id="txbCustomerName" name="name"/></div>
	        <div style="float: left;padding-left: 30px;padding-top: 5px;">电话号码：</div>
	        <div style="float: left;padding-right: 30px;padding-top: 5px;"><input id="txbCustomerPhone" name="phone"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgCustomerList"></div>
  </div>
<script type="text/javascript">

	var Customer = {
			
		add:function (){
			var Customer_newAdd = $("<div id='Customer_newAdd'></div>");
			Customer_newAdd.appendTo("body");
			$("#Customer_newAdd").dialog ({
				href: getContextPath() + "/data/addCustomerUI",
				title: "新增客户信息",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#Customer_newAdd").remove();
				}
			});
		},
		
		edit: function (index){
			var Customer_newEdit = $("<div id='Customer_newEdit'></div>");
			var row = $("#dgCustomerList").datagrid("getData").rows[index];
			Customer_newEdit.appendTo("body");
			$("#Customer_newEdit").dialog ({
				href: getContextPath() + "/data/editCustomerUI?uname="+row.uname,
				title: "修改客户信息",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#Customer_newEdit").remove();
				}
			});
		},
		
		del: function (index){
			var row = $("#dgCustomerList").datagrid("getData").rows[index];
			$.messager.confirm ("提示","您确定要删除该客户的记录吗?(删除操作不可回退)",function (sure) {
				if (sure){
					$.ajax({
						url: getContextPath() + "/data/delCustomer",
						async: false,
						data:{"id":row.id},
						dataType: "json",
						success: function (result){
							if (result=="success") {
								$("#dgCustomerList").datagrid("reload");
								swal({
									title:"提示",
									text:"恭喜您删除成功!",
									type:"success"
								});
							} else {
								swal({
									title:"提示",
									text:"没找到姓名为"+row.name+"的用户",
									type:"error"
								});
							}
						},
						error: function () {
							swal({
								title: "提示",
								text: "delete error!",
								type:"error",
							});
						}
					});
				}
			});
		},
		
	};
	
	$("#dlgCustomerMain").dialog({
		title : '客户管理',
		width : 1024,
		height : 600,
		closed : false,
		cache : false,
		modal : true,
		inline:true,
		onClose:function (){
			$("#dlgCustomerMain").remove();
		}
	});
		
	$("#txbCustomerName").textbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getCustomerList?name="+$("#txbCustomerName").textbox("getText")+"&phone="+$("#txbCustomerPhone").textbox("getText");
			$("#dgCustomerList").datagrid("reload",url);
		 },
	});
	
	$("#txbCustomerPhone").textbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getCustomerList?name="+$("#txbCustomerName").textbox("getText")+"&phone="+$("#txbCustomerPhone").textbox("getText");
			$("#dgCustomerList").datagrid("reload",url);
		 },
	});

	$("#dgCustomerList").datagrid({
		url: getContextPath() + "/data/getCustomerList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#CustomerToolbar",
		pagination:true,
		pageSize:15,
		pageList:['15'],
		columns: [[
		           {
		        	  width: "19%",
		        	  title: "客户名称",
		        	  field: "uname",
		        	  align: "center",
		        	  resizable: false
		           },{
		        	  width: "15%",
		        	  title: "负责人",
			          field: "name",
			          align: "center",
			          resizable: false
		           },{
		        	  width: "18%",
		        	  title: "联系电话",
			          field: "phone",
			          align: "center",
			          resizable: false
		           },{
		        	  width: "32%",
			          title: "送货地址",
				      field: "address",
				      align: "center",
				      resizable: false
			       },{
			    	  width: "14%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      resizable: false,
				      formatter: function (value,row,index) {
				    	  return "<a class='editCusBtn' onclick='Customer.edit("+index+")'>修改</a>&nbsp;&nbsp;&nbsp;<a class='delCusBtn' onclick='Customer.del("+index+")'>删除</a>";
				      }
				   }
		           ]],
		           onLoadSuccess: function () {
		        	 $(".editCusBtn").linkbutton({
		        		 iconCls: "icon-edit",
		        		 iconAlign: "left",
		        		 height: 24,
		        	 });
		        	 
		        	 $(".delCusBtn").linkbutton({
		        		 iconCls: "icon-no",
		        		 iconAlign: "left",
		        		 height: 24,
		        	 }); 
		        	 
		           },
	});
</script>  
</body>
</html>
