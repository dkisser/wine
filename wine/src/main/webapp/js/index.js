/*
JS:
	JavaScript
	网景(netspace) C-- -->LiveScript  -->ECMAScript --> JavaScript
	脚本语言(无法独立运行，需要嵌入到html中作为脚本运行)  (nodejs可以直接运行js)
	js是一门弱类型语言:任何数据类型在使用的时候无需声明数据类型,还能在运行期间动态改变数据类型，所以
		js是一门动态语言
	
	JS包含三大核心组成部分
		ECMAScript:js基本语法
		BOM:浏览器对象模型
		DOM:文档对象模型
 */
//获取视频播放区域(弹幕出现的区域)
var sc = $('.main');
//获取输入框对象
var txt = $('.txt');
//获取按钮对象
var btn = $('.btn');
//封装函数用于查询指定元素对象
var testSize = 15;

function $(selector)
{
	return document.querySelector(selector);
}
//为按钮设置点击事件
btn.onclick=sendMsgToServer;	

//监听按键事件
txt.addEventListener('keydown',function(e){
	//获取按钮的按键码(键盘上的每一个按键，都对应一个独一无二的数字:ascii码)
	var code = e.keyCode;
	//判断是否按下回车(发送)
	if(code == 13){
		sendMsgToServer();
	}
});

//发送弹幕
function getRandomColor () {
	return Math.floor(Math.random()*256) + "," + Math.floor(Math.random()*256) + "," + Math.floor(Math.random()*256);
}

function autoRun (sp) {
	var left  = parseInt(sp.style.left);
	if (left < - parseInt(sp.style.width) ) {
		sp.remove();		
	} else {
		left --;		
	}
	sp.style.left = left + "px";
	setTimeout(function () {
		autoRun(sp);
	},10);
}

function sendMsg(content){
	//随机获取一个y轴位置
	var height = parseInt(Math.random()*sc.offsetHeight);
	//创建span元素
	var sp = document.createElement('span');
	sp.style.position = 'absolute';//设置定位方式为绝对定位
	sp.style.left = sc.offsetWidth+'px';
	sp.style.top = (height-parseInt(sp.offsetHeight)) + 'px';	//设置span在距离父容器的高度
	sp.style.color = "rgb("+getRandomColor()+")";
	sp.style.testSize = testSize+"px";
	sp.style.width = testSize * content.length+"px";
	sp.innerHTML = content;	//设置span中要显示的文本内容(弹幕内容)
	sc.appendChild(sp);//将产生的弹幕内容追加到屏幕中
	autoRun(sp);
}
 
/**
 * websocket实现进程访问同步
 */
var ws ;
(function socket () {
	if (typeof(WebSocket) !== "undefined") {
		console.info("支持websocket通讯");
		//创建webSocket对象
		ws = new WebSocket("ws://125.220.70.103:8080/admin_6ha/ws");
		//建立连接 发送消息 断开连接 发生异常 的时候都会有回调函数产生
		ws.onopen = function () {
			console.info("建立起连接");
			ws.send("初始化ws连接");
		};
		ws.onmessage = function (event) {
			sendMsg(event.data);
			console.info("服务端的一条消息"+event.data);
		};
		window.onbeforeunload = function(){    
			ws.close();    
		};
	}
	
})();

//发送消息到服务器端
function sendMsgToServer () {
	var content = txt.value;
	ws.send(content);
}
