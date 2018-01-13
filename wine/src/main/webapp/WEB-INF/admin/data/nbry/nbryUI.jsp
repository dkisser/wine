<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="org.lf.admin.service.ChuUserType" %>
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
  <div id="dlgNbryMain">
    <div id="NbryToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;">
	      	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="Nbry.add()">新增</a>
	      </div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">用户名：</div>
	        <div style="float: left;padding-top: 5px;"><input id="txbNbryUname" name="uname"/></div>
	        <div style="float: left;padding-left: 10px;padding-top: 5px;">联系电话：</div>
	        <div style="float: left;padding-right: 10px;padding-top: 5px;"><input id="txbNbryPhone" name="phone"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgNbryList"></div>
  </div>
<script type="text/javascript">
	var Nbry = {
			
		add:function (){
			var Nbry_newAdd = $("<div id='Nbry_newAdd'></div>");
			Nbry_newAdd.appendTo("body");
			$("#Nbry_newAdd").dialog ({
				href: getContextPath() + "/data/addNbryUI",
				title: "新增内部人员",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#Nbry_newAdd").remove();
				}
			});
		},
		
		edit: function (index){
			var Nbry_newEdit = $("<div id='Nbry_newEdit'></div>");
			var row = $("#dgNbryList").datagrid("getData").rows[index];
			Nbry_newEdit.appendTo("body");
			$("#Nbry_newEdit").dialog ({
				href: getContextPath() + "/data/editNbryUI?id="+row.id,
				title: "修改内部人员信息",
				width: 512,
				height: 300,
				inline: true,
				modal:true,
				onClose:function (){
					$("#Nbry_newEdit").remove();
				}
			});
		},
		
		del: function (index){
			var row = $("#dgNbryList").datagrid("getData").rows[index];
			$.messager.confirm ("提示","您确定要删除该人员的相关记录吗?(删除操作不可回退)",function (sure) {
				if (sure){
					$.ajax({
						url: getContextPath() + "/data/delNbry",
						async: false,
						data:{"id":row.id},
						dataType: "json",
						success: function (result){
							if (result=="success") {
								$("#dgNbryList").datagrid("reload");
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
		reset: function (index){
			var row = $("#dgNbryList").datagrid("getData").rows[index];
			$.messager.confirm ("提示","您确定要将该人员的密码重置吗?(该操作将会使密码改人员的密码变为123456)",function (sure) {
				if (sure){
					$.ajax({
						url: getContextPath() + "/data/resetNbry",
						async: false,
						data:{"id":row.id,"uname":row.uname},
						dataType: "json",
						success: function (result){
							if (result=="success") {
								$("#dgNbryList").datagrid("reload");
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
	
	$("#dlgNbryMain").dialog({
		title : '内部人员管理',
		width : 1024,
		height : 600,
		closed : false,
		cache : false,
		modal : true,
		inline:true,
		onClose:function (){
			$("#dlgNbryMain").remove();
		}
	});
		
	$("#txbNbryUname").textbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getNbryList?uname="+$("#txbNbryUname").textbox("getText")+"&phone="+$("#txbNbryPhone").textbox("getText");
			$("#dgNbryList").datagrid("reload",url);
		 },
	});
	
	$("#txbNbryPhone").numberbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getNbryList?uname="+$("#txbNbryUname").textbox("getText")+"&phone="+$("#txbNbryPhone").textbox("getText");
			$("#dgNbryList").datagrid("reload",url);
		 },
	});

	$("#dgNbryList").datagrid({
		url: getContextPath() + "/data/getNbryList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#NbryToolbar",
		pagination:true,
		pageSize:15,
		pageList:['15'],
		columns: [[
		           {
		        	  width: "15%",
		        	  title: "用户名",
		        	  field: "uname",
		        	  align: "center",
		        	  resizable: false
		           },{
		        	  width: "15%",
		        	  title: "姓名",
			          field: "name",
			          align: "center", 
			          resizable: false
		           },{
		        	  width: "13%",
			          title: "系统角色",
				      field: "role",
				      align: "center",
				      resizable: false,
				      formatter:function (value,row,index){
				    	  if (value==1){
				    		  return "内部员工";
				    	  }
				    	  if (value==2){
				    		  return "超级管理员";
				    	  }
				      }
			       },{
		        	  width: "17%",
		        	  title: "联系电话",
			          field: "phone",
			          align: "center",
			          resizable: false,
		           },{
		        	  width: "10%",
			          title: "人员类型",
				      field: "rylx",
				      align: "center",
				      resizable: false,
				      formatter:function (value,row,index){
				    	  if (value==0){
				    		  return "业务员";
				    	  }
				    	  if (value==1){
				    		  return "送货员";
				    	  }
				      }
			       },{
		        	  width: "8%",
			          title: "日售单数",
				      field: "xs",
				      align: "center",
				      resizable: false
				   },{
			    	  width: "21%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      resizable: false,
				      formatter: function (value,row,index) {
				    	  return "<a class='editUserBtn' onclick='Nbry.edit("+index+")'>修改</a>&nbsp;&nbsp;&nbsp;<a class='resetUserBtn' onclick='Nbry.reset("+index+")'>重置</a>&nbsp;&nbsp;&nbsp;<a class='delUserBtn' onclick='Nbry.del("+index+")'>删除</a>";
				      }
				   }
		           ]],
		           onLoadSuccess: function () {
		        	 $(".editUserBtn").linkbutton({
		        		 iconCls: "icon-edit",
		        		 iconAlign: "left",
		        		 height: 24,
		        	 });
		        	 
		        	 $(".delUserBtn").linkbutton({
		        		 iconCls: "icon-no",
		        		 iconAlign: "left",
		        		 height: 24,
		        	 }); 
		        	 
		        	 $(".resetUserBtn").linkbutton({
		        		 iconCls: "icon-reload",
		        		 iconAlign: "left",
		        		 height: 24,
		        	 }); 
		        	 
		           },
	});
</script> 
</body>
</html>
