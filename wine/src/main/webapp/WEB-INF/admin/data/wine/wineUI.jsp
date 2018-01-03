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
  <div id="dlgWineMain">
    <div id="WineToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;">
	      	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="Wine.add()">新增</a>
	      </div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">酒&nbsp;&nbsp;&nbsp;名：</div>
	        <div style="float: left;padding-top: 5px;"><input id="txbWineMc" name="mc"/></div>
	        <div style="float: left;padding-left: 10px;padding-top: 5px;">出厂日期：</div>
	        <div style="float: left;padding-right: 10px;padding-top: 5px;"><input id="txbWineDate" name="date"/></div>
	        <div style="float: left;padding-left: 10px;padding-top: 5px;">零售价：</div>
	        <div style="float: left;padding-right: 10px;padding-top: 5px;"><input id="txbWinePrice" name="price"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgWineList"></div>
  </div>
<script type="text/javascript">

function FormatDate(date) {
	
	return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}

	Wine = {
			
		add:function (){
			var Wine_newAdd = $("<div id='Wine_newAdd'></div>");
			Wine_newAdd.appendTo("body");
			$("#Wine_newAdd").dialog ({
				href: getContextPath() + "/data/addWineUI",
				title: "新增酒品信息",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#Wine_newAdd").remove();
				}
			});
		},
		
		edit: function (index){
			var Wine_newEdit = $("<div id='Wine_newEdit'></div>");
			var row = $("#dgWineList").datagrid("getData").rows[index];
			Wine_newEdit.appendTo("body");
			$("#Wine_newEdit").dialog ({
				href: getContextPath() + "/data/editWineUI?id="+row.id,
				title: "修改客户信息",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#Wine_newEdit").remove();
				}
			});
		},
		
		del: function (index){
			var row = $("#dgWineList").datagrid("getData").rows[index];
			$.messager.confirm ("提示","您确定要删除该酒品的记录吗?(删除操作不可回退)",function (sure) {
				if (sure){
					$.ajax({
						url: getContextPath() + "/data/delWine",
						async: false,
						data:{"id":row.id},
						dataType: "json",
						success: function (result){
							if (result=="success") {
								$("#dgWineList").datagrid("reload");
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
	
	$("#dlgWineMain").dialog({
		title : '酒品管理',
		width : 1024,
		height : 600,
		closed : false,
		cache : false,
		modal : true,
		inline:true,
		onClose:function (){
			$("#dlgWineMain").remove();
		}
	});
		
	$("#txbWineMc").textbox({
		 width: 200,
		 buttonText:'Search',   
		 iconCls:'icon-search', 
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getWineList?mc="+$("#txbWineMc").textbox("getText")+"&price="+$("#txbWinePrice").textbox("getText")+"&date="+$("#txbWineDate").datebox("getText");
			$("#dgWineList").datagrid("reload",url);
		 },
	});
	
	$("#txbWineDate").datebox({
		 editable:false,
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getWineList?mc="+$("#txbWineMc").textbox("getText")+"&price="+$("#txbWinePrice").textbox("getText")+"&date="+$("#txbWineDate").datebox("getText");
			$("#dgWineList").datagrid("reload",url);
		 },
	});
	
	$("#txbWinePrice").numberbox({
		 width: 200,
		 buttonText:'Search',   
		 iconCls:'icon-search', 
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getWineList?mc="+$("#txbWineMc").textbox("getText")+"&price="+$("#txbWinePrice").textbox("getText")+"&date="+$("#txbWineDate").datebox("getText");
			$("#dgWineList").datagrid("reload",url);
		 },
	});

	$("#dgWineList").datagrid({
		url: getContextPath() + "/data/getWineList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#WineToolbar",
		pagination:true,
		pageSize:15,
		pageList:['15'],
		columns: [[
		           {
		        	  width: "15%",
		        	  title: "酒名",
		        	  field: "mc",
		        	  align: "center",
		           },{
		        	  width: "15%",
		        	  title: "零售价",
			          field: "price",
			          align: "center", 
		           },{
		        	  width: "18%",
		        	  title: "出厂日期",
			          field: "date",
			          align: "center",
			          formatter:function (value,row,index){
			        	  return FormatDate(new Date(value));
			          }
		           },{
		        	  width: "36%",
			          title: "备注",
				      field: "remark",
				      align: "center", 
			       },{
			    	  width: "14%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      formatter: function (value,row,index) {
				    	  return "<a class='editCusBtn' onclick='Wine.edit("+index+")'>修改</a>&nbsp;&nbsp;&nbsp;<a class='delCusBtn' onclick='Wine.del("+index+")'>删除</a>";
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
