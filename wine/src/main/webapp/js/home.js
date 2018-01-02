function getContextPath() {
	var localObj = window.location;
	var contextPath = localObj.pathname.split("/")[1];
	return localObj.protocol + "//" + localObj.host + "/" + contextPath;
}

function parseServerMsg (jsonStr) {
	var json = eval("("+jsonStr+")");
	if (json.action == 1) {
		window.location.href = getContextPath() + json.data[0];
	} else if (json.action == 0) {
		return json.data;//这个地方返回的是一个JSONArray
	} else {
		return  null;
	}
	
}

function compactMsg (serviceName,methodName,data) {
	if (data == null) {
		return "{\"methodName\":\""+methodName+"\",\"serviceName\":\""+serviceName+"\"}";
	}
	return "{\"methodName\":\""+methodName+"\",\"serviceName\":\""+serviceName+"\",\"data\":"+data+"}";
}
//修改密码
function updatepwd(uid) {
	$('#pwddialog').dialog({
		title : '修改密码',
		width : 512,
		height : 300,
		closed : false,
		cache : false,
		href : getContextPath() + '/home/updatePwdUI',
		modal : true
	});
}

//当前用户信息
function currUser() {
	$('#currUser').dialog({
		title : '用户信息',
		width : 512,
		height : 300,
		closed : false,
		cache : false,
		href : getContextPath() + '/home/currUser',
		modal : true
	});
}
// 退出系统
function quit() {
	$.messager.confirm('退出系统', '确定要退出系统吗?', function(r) {
		if (r) {
			window.location.href = getContextPath() + '/home/quit';
		}
	});
}
//刷新center窗口
function changeCenter(url){
//	$('#center').panel('refresh',url);
	$("#center").panel({
		cache : false,
		href : url
	});
}


