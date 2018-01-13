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
  <div id="dlgReportMain">
    <div id="PrintToolbar" style="height: 30px;width:100%;line-height: 20px;">
	    <div style="height: 100%;float: left;">
	      <div style="float: left;">
	      	<form id="printForm" method="POST"><input type="hidden" name="randomInfo" value="<%=Math.random()%>"/></form>
	      </div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">销售单号：</div>
	        <div style="float: left;padding-top: 5px;padding-right: 10px;"><input id="txbPrintXsdh" name="xsdh"/></div>
	        <div style="float: left;padding-left: 5px;padding-top: 5px;">客户电话：</div>
	        <div style="float: left;padding-right: 10px;padding-top: 5px;"><input id="txbPrintKhdh" name="khdh"/></div>
	        <div style="float: left;padding-left: 10px;padding-top: 5px;">出货日期：</div>
	        <div style="float: left;padding-right: 30px;padding-top: 5px;"><input id="txbPrintChrq" name="chrq"/></div>
	      </div>
	    </div>
   	</div>
    <div id="dgPrintList"></div>
  </div>
<script type="text/javascript">
function FormatDate(date) {
	
	return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}

	var report = {
		print:function (index){
			$.messager.confirm("提示","您确定要打印选中这单商品吗？",function(sure){
				if (sure){
					var row = $("#dgPrintList").datagrid("getData").rows[index];
					$("#printForm").form("submit",{
						url:getContextPath() +"/order/exportExcel",
						onSubmit: function(param){
							param.xsdh = row.xsdh;
						}, 
						onSuccess: function(res){
		 					if(res != "success"){
		 						$.messager.alert('失败',data,'warning');
		 					}
		 				}
					});
				}
			});
		},
		
	};
	
	$("#dlgReportMain").dialog({
		title : '报表打印',
		width : 1024,
		height : 600,
		closed : false,
		cache : false,
		modal : true,
		inline:true,
		onClose:function (){
			$("#dlgReportMain").remove();
		}
	});
		
	$("#txbPrintXsdh").textbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getReportList?xsdh="+$("#txbPrintXsdh").textbox("getText")+"&khdh="+$("#txbPrintKhdh").textbox("getText")+"&chrq="+$("#txbPrintChrq").datebox("getValue");
			$("#dgPrintList").datagrid("reload",url);
		 },
	});
	
	$("#txbPrintKhdh").numberbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getReportList?xsdh="+$("#txbPrintXsdh").textbox("getText")+"&Khdh="+$("#txbPrintKhdh").textbox("getText")+"&chrq="+$("#txbPrintChrq").datebox("getValue");
			$("#dgPrintList").datagrid("reload",url);
		 },
	});
	
	$("#txbPrintChrq").datebox({
		 width: 200,
		 editable:false,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getReportList?xsdh="+$("#txbPrintXsdh").textbox("getText")+"&Khdh="+$("#txbPrintKhdh").textbox("getText")+"&chrq="+$("#txbPrintChrq").datebox("getValue");
			$("#dgPrintList").datagrid("reload",url);
		 },
	});

	$("#dgPrintList").datagrid({
		url: getContextPath() + "/order/getReportList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		singleSelect: true,
		showHeader: true,
		toolbar:"#PrintToolbar",
		pagination:true,
	    selectOnCheck: false,
		checkOnSelect: false,
		singleSelect: true,
		pageSize:100,
		pageList:['100'],
		columns: [[
		           {
		        	  width: "20%",
		        	  title: "销售单号",
		        	  field: "xsdh",
		        	  align: "center",
		        	  resizable: false,
		        	  formatter:function (value,row,index){
		        		  return "<span class='tooltips' title='"+row.xsdh+"'>"+value+"</spans>";
		        	  }
		           },{
		        	  width: "17%",
		        	  title: "商品名",
			          field: "wineMc",
			          align: "center",
			          resizable: false
		           },{
		        	  width: "12%",
			          title: "出货日期",
				      field: "date",
				      align: "center",
				      resizable: false,
				      formatter:function (value,row,index){
				    	  return FormatDate(new Date(value));
				      }
			       },{
		        	  width: "11%",
		        	  title: "送货员",
			          field: "shy",
			          align: "center",
			          resizable: false
		           },{
		        	  width: "11%",
			          title: "业务员",
				      field: "ywy",
				      align: "center",
				      resizable: false
			       },{
		        	  width: "11%",
			          title: "收货客户",
				      field: "shz",
				      align: "center",
				      resizable: false
			       },{
		        	  width: "16%",
			          title: "客户电话",
				      field: "khdh",
				      align: "center",
				      resizable: false
			       },{
			    	  width: "4%",
			          title: "操作",
				      field: "opt",
				      align: "center",
				      resizable: false,
				      formatter:function(value,row,index){
				    	  return "<a href='#' class='editBtn tooltips' title='打印'  onclick='report.print("+index+")'></a>";
				      }
			       }
		           ]],
		           onLoadSuccess: function () {
		        	 
		        	 $('.editBtn').linkbutton({
		        		 iconCls:'icon-save',
		        		 height:24
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
