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
  <div id="dlgQueryMain">
    <div id="QueryToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;">
	      	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="Query.add()">新增</a>
	      </div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">条形码：</div>
	        <div style="float: left;padding-top: 5px;padding-right: 10px;"><input id="txbQueryTxm" name="txm"/></div>
	        <div style="float: left;padding-left: 5px;padding-top: 5px;">收货电话：</div>
	        <div style="float: left;padding-right: 10px;padding-top: 5px;"><input id="txbQueryKhdh" name="khdh"/></div>
	        <div style="float: left;padding-left: 10px;padding-top: 5px;">出货日期：</div>
	        <div style="float: left;padding-right: 30px;padding-top: 5px;"><input id="txbQueryChrq" name="chrq"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgQueryList"></div>
  </div>
<script type="text/javascript">
function FormatDate(date) {
	
	return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}

	var Query = {
			
		add:function (){
			var Query_newAdd = $("<div id='Query_newAdd'></div>");
			Query_newAdd.appendTo("body");
			$("#Query_newAdd").dialog ({
				href: getContextPath() + "/order/addOrderUI",
				title: "新增订单",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#Query_newAdd").remove();
				}
			});
		},
		
		del: function (index){
			var row = $("#dgQueryList").datagrid("getData").rows[index];
			$.messager.confirm ("提示","您确定要删除该订单吗?(删除操作不可回退)",function (sure) {
				if (sure){
					$.ajax({
						url: getContextPath() + "/order/delOrder",
						async: false,
						data:{"txm":row.txm},
						dataType: "json",
						success: function (result){
							if (result=="success") {
								$("#dgQueryList").datagrid("reload");
								swal({
									title:"提示",
									text:"恭喜您删除成功!",
									type:"success"
								});
							} else {
								swal({
									title:"提示",
									text:"没找到条形码为"+row.txm+"的订单",
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
	
	$("#dlgQueryMain").dialog({
		title : '订单管理',
		width : 1024,
		height : 600,
		closed : false,
		cache : false,
		modal : true,
		inline:true,
		onClose:function (){
			$("#dlgQueryMain").remove();
		}
	});
		
	$("#txbQueryTxm").textbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getVOrderList?txm="+$("#txbQueryTxm").textbox("getText")+"&khdh="+$("#txbQueryKhdh").textbox("getText")+"&chrq="+$("#txbQueryChrq").datebox("getValue");
			$("#dgQueryList").datagrid("reload",url);
		 },
	});
	
	$("#txbQueryKhdh").numberbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getVOrderList?txm="+$("#txbQueryTxm").textbox("getText")+"&Khdh="+$("#txbQueryKhdh").textbox("getText")+"&chrq="+$("#txbQueryChrq").datebox("getValue");
			$("#dgQueryList").datagrid("reload",url);
		 },
	});
	
	$("#txbQueryChrq").datebox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getVOrderList?txm="+$("#txbQueryTxm").textbox("getText")+"&Khdh="+$("#txbQueryKhdh").textbox("getText")+"&chrq="+$("#txbQueryChrq").datebox("getValue");
			$("#dgQueryList").datagrid("reload",url);
		 },
	});

	$("#dgQueryList").datagrid({
		url: getContextPath() + "/order/getVOrderList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#QueryToolbar",
		pagination:true,
		pageSize:15,
		pageList:['15'],
		columns: [[
		           {
		        	  width: "12%",
		        	  title: "销售单号",
		        	  field: "xsdh",
		        	  align: "center",
		        	  resizable: true,
		        	  
		           },{
		        	  width: "12%",
		        	  title: "条形码",
		        	  field: "txm",
		        	  align: "center",
		        	  resizable: true,
		           },{
		        	  width: "15%",
		        	  title: "商品名",
			          field: "wineMc",
			          align: "center",
			          resizable: false
		           },{
		        	  width: "10%",
			          title: "出货日期",
				      field: "date",
				      align: "center",
				      resizable: false,
				      formatter:function (value,row,index){
				    	  return FormatDate(new Date(value));
				      }
			       },{
		        	  width: "10%",
		        	  title: "送货员",
			          field: "shy",
			          align: "center",
			          resizable: false
		           },{
		        	  width: "10%",
			          title: "业务员",
				      field: "ywy",
				      align: "center",
				      resizable: false
			       },{
		        	  width: "10%",
			          title: "收货客户",
				      field: "shz",
				      align: "center",
				      resizable: false
			       },{
		        	  width: "12%",
			          title: "客户电话",
				      field: "khdh",
				      align: "center",
				      resizable: false
			       },{
			    	  width: "8%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      resizable: false,
				      formatter: function (value,row,index) {
				    	  var status = "${sessionScope.loginInfo.role}";
				    	  if (status==2){
				    	  	return "<a class='delCusBtn' onclick='Query.del("+index+")'>删除</a>";
				    	  } else {
				    		  return "";
				    	  }
				    	  return "<a class='delCusBtn' onclick='Query.del("+index+")'>删除</a>";
				      }
				   }
		           ]],
		           onLoadSuccess: function () {
		        	 
		        	 $(".delCusBtn").linkbutton({
		        		 iconCls: "icon-no",
		        		 iconAlign: "left",
		        		 height: 24,
		        	 }); 
		        	 
		        	 $('.tooltips').tooltip({    
		        		 onShow: function(){        
		        			 $(this).tooltip('tip').css({            
		        				 borderColor: '#666'        
		        				 });    
		        			 }});
		           },
	});
</script>  
</body>
</html>
