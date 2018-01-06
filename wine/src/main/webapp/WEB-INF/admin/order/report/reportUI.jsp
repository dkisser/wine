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
	      	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="Print.print()">打印</a>
	      </div>
	    </div>
	    <div style="height: 100%;float: right;">
	      <div>
	        <div style="float: left;padding-top: 5px;">条形码：</div>
	        <div style="float: left;padding-top: 5px;padding-right: 10px;"><input id="txbPrintTxm" name="txm"/></div>
	        <div style="float: left;padding-left: 5px;padding-top: 5px;">收货电话：</div>
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

	var Print = {
		
		print:function (){
			
		},
		
		chooseAll:function (){
			var oldVal = $("#reportUI_chooseAll").attr("checked");
			if (oldVal=="checked"){
				$(".reportRadio").attr("checked",null);
				$("#reportUI_chooseAll").attr("checked",null);
			} else {
				$(".reportRadio").attr("checked","checked");
				$("#reportUI_chooseAll").attr("checked","checked");
			}
		}
		
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
		
	$("#txbPrintTxm").numberbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getVOrderList?txm="+$("#txbPrintTxm").textbox("getText")+"&khdh="+$("#txbPrintKhdh").textbox("getText")+"&chrq="+$("#txbPrintChrq").datebox("getValue");
			$("#dgPrintList").datagrid("reload",url);
		 },
	});
	
	$("#txbPrintKhdh").numberbox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getVOrderList?txm="+$("#txbPrintTxm").textbox("getText")+"&Khdh="+$("#txbPrintKhdh").textbox("getText")+"&chrq="+$("#txbPrintChrq").datebox("getValue");
			$("#dgPrintList").datagrid("reload",url);
		 },
	});
	
	$("#txbPrintChrq").datebox({
		 width: 200,
		 buttonText:'Search',   
		 iconAlign:'right',
		 onClickButton: function () {
			var url = getContextPath() + "/order/getVOrderList?txm="+$("#txbPrintTxm").textbox("getText")+"&Khdh="+$("#txbPrintKhdh").textbox("getText")+"&chrq="+$("#txbPrintChrq").datebox("getValue");
			$("#dgPrintList").datagrid("reload",url);
		 },
	});

	$("#dgPrintList").datagrid({
		url: getContextPath() + "/order/getVOrderList",
		fit:true,
		striped: true,
		nowrap: true,
		loadMsg: "数据正在加载中,请稍后...",
		emptyMsg: "目前暂无任何数据额...",
		singleSelect: true,
		showHeader: true,
		toolbar:"#PrintToolbar",
		pagination:true,
		pageSize:15,
		pageList:['15'],
		columns: [[
		           {
		        	  width: "3%",
		        	  title: "<input id='reportUI_chooseAll' type='radio' onclick='Print.chooseAll()'/>",
		        	  field: "all",
		        	  align: "center",
		        	  resizable: false,
		        	  formatter:function (value,row,index){
		        		return "<input id='radio"+index+"' class='reportRadio' type='radio'/>";  
		        	  }
		           },{
		        	  width: "16%",
		        	  title: "销售单号",
		        	  field: "xsdh",
		        	  align: "center",
		        	  resizable: false,
		        	  formatter:function (value,row,index){
		        		  return "<span class='tooltips' title='"+row.xsdh+"'>"+value+"</spans>";
		        	  }
		           },{
		        	  width: "16%",
		        	  title: "条形码",
		        	  field: "txm",
		        	  align: "center",
		        	  resizable: false,
		        	  formatter:function (value,row,index){
		        		  return "<span class='tooltips' title='"+row.txm+"'>"+value+"</span>";
		        	  }
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
			       }
		           ]],
		           onLoadSuccess: function () {
		        	 
		        	 $('.tooltips').tooltip({    
		        		 onShow: function(){        
		        			 $(this).tooltip('tip').css({            
		        				 borderColor: '#666'        
		        				 });    
		        			 }});
		           },
		           onClickRow:function (index, row){
		        	   var oldVal = $("#radio"+index).attr("checked");
		        	   if (oldVal=="checked"){
		        		   $("#radio"+index).attr("checked",null);
		        	   } else {
		        		   $("#radio"+index).attr("checked","checked");
		        	   }
		        	   
		           }
	});
</script>  
</body>
</html>
