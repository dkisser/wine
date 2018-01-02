$(function(){
	$("#bdyx img").hover(function(){
		var bdyxwidth = $("#bdyx img").width();
		var bdyxheight = $("#bdyx img").height();
		$(this).stop().animate({
			width:bdyxwidth+10,
			height:bdyxheight+10,
			right:0,
			top:0
		},400);
	},function(){
		$(this).stop().animate({
			width:180,
			height:280,
			right:0,
			top:0
		},400);
	});
	$("#showgirl img").hover(function(){
		var showgirlwidth = $("#showgirl img").width()*1.1;
		var showgirlheight = $("#showgirl img").height()*1.1;
		$(this).stop().animate({
			width:showgirlwidth,
			height:showgirlheight,
			left:(-(0.5 * $(this).width())/2),
			top:(-(0.5 * $(this).height())/2)
		},100);
	},function(){
		$(this).stop().animate({
			width:289,
			height:291,
			left:0,
			top:0
		},100);
	});
});
function login() {
	layui.use(['layer','form'], function(){ 
		  var $ = layui.jquery,
		  layer = layui.layer,
		  form = layui.form(),
		  $ = layui.jquery;
	      var index = layer.open({
	        type: 2
	        ,title: false //不显示标题栏
	        ,closeBtn: false
	        ,area: ['400px','240px']
	        ,shade: 0.4
	        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
//	        ,btn: ['登录', '取消']
	        ,moveType: 1 //拖拽模式，0或者1
	        ,content: [getContextPath() + '/web/loginUI.do']
	        ,success: function(layero){
//	          var btn = layero.find('.layui-layer-btn');
//	          btn.css('text-align', 'center');
//	          btn.find('.layui-layer-btn0').attr({
//	        		  "lay-filter":"login",
//	        		  "lay-submit":""
//	          });
	        }
	      ,end :function(){
	    	  setTimeout(function(){
	    		  location.reload(true);
	    	  },1000);
    	  
	      }
//	      ,yes:function (index, layero) {
//	    	  
//	      }
	    });
	});
}

function regist() {
	layui.use(['layer','form'], function(){ 
		  var $ = layui.jquery,
		  layer = layui.layer,
		  form = layui.form(),
		  $ = layui.jquery;
	      var index = layer.open({
	        type: 2
	        ,title: false //不显示标题栏
	        ,closeBtn: false
	        ,area: ['400px','400px']
	        ,shade: 0.4
	        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
//	        ,btn: ['登录', '取消']
	        ,moveType: 1 //拖拽模式，0或者1
	        ,content: [getContextPath() + '/web/registUI.do']
	        ,success: function(layero){
//	          var btn = layero.find('.layui-layer-btn');
//	          btn.css('text-align', 'center');
//	          btn.find('.layui-layer-btn0').attr({
//	        		  "lay-filter":"login",
//	        		  "lay-submit":""
//	          });
	        }
	      ,end :function(){
	    	  setTimeout(function(){
	    		  location.reload(true);
	    	  },1000);
	      }	
//	      ,yes:function (index, layero) {
//	    	  
//	      }
	    });
	});
}



