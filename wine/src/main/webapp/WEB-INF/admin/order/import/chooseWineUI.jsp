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
   <div id="ChooseWineToolbar" style="height: 30px;width:100%;line-height: 20px;">
    <div style="height: 100%;float: left;">
      <div style="float: left;"></div>
    </div>
    <div style="height: 100%;float: right;">
      <div>
        <div style="float: left;padding-top: 5px;">酒&nbsp;&nbsp;&nbsp;名：</div>
        <div style="float: left;padding-top: 5px;"><input id="txbChooseWineMc" name="mc"/></div>
        <div style="float: left;padding-left: 10px;padding-top: 5px;">出厂日期：</div>
        <div style="float: left;padding-right: 10px;padding-top: 5px;"><input id="txbChooseWineDate" name="date"/></div>
        <div style="float: left;padding-left: 10px;padding-top: 5px;">零售价：</div>
        <div style="float: left;padding-right: 10px;padding-top: 5px;"><input id="txbChooseWinePrice" name="price"/></div>
      </div>
    </div>
  	</div>
   <div id="dgChooseWineList"></div>
<script type="text/javascript">

function FormatDate(date) {
	
	return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}

	var ChooseWine = {
			
		choose:function (index){
			var chooseRow = $("#dgChooseWineList").datagrid("getData").rows[index];
			$("#importWine_txbwineId").textbox("setValue",chooseRow.mc);
			$("#importWine_txbwineId").attr("wineId",chooseRow.id);
			$("#import_newChooseWine").dialog("close");
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
		
	$("#txbChooseWineMc").textbox({
		 width: 200,
		 buttonText:'Search',   
		 iconCls:'icon-search', 
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getWineList?mc="+$("#txbChooseWineMc").textbox("getText")+"&price="+$("#txbChooseWinePrice").textbox("getText")+"&date="+$("#txbChooseWineDate").datebox("getText");
			$("#dgChooseWineList").datagrid("reload",url);
		 },
	});
	
	$("#txbChooseWineDate").datebox({
		 editable:false,
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getWineList?mc="+$("#txbChooseWineMc").textbox("getText")+"&price="+$("#txbChooseWinePrice").textbox("getText")+"&date="+$("#txbChooseWineDate").datebox("getText");
			$("#dgChooseWineList").datagrid("reload",url);
		 },
	});
	
	$("#txbChooseWinePrice").numberbox({
		 width: 200,
		 buttonText:'Search',   
		 iconCls:'icon-search', 
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/data/getWineList?mc="+$("#txbChooseWineMc").textbox("getText")+"&price="+$("#txbChooseWinePrice").textbox("getText")+"&date="+$("#txbChooseWineDate").datebox("getText");
			$("#dgChooseWineList").datagrid("reload",url);
		 },
	});

	$("#dgChooseWineList").datagrid({
		url: getContextPath() + "/data/getWineList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		rownumbers: true,
		singleSelect: true,
		showHeader: true,
		toolbar:"#ChooseWineToolbar",
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
		        	  width: "10%",
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
		        	  width: "41%",
			          title: "备注",
				      field: "remark",
				      align: "center", 
			       },{
			    	  width: "14%",
				      title: "操作",
				      field: "option",
				      align: "center",
				      formatter: function (value,row,index) {
				    	  return "<a class='chooseCusBtn' onclick='ChooseWine.choose("+index+")'>选择</a>";
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
