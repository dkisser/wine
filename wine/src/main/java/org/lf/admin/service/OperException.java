package org.lf.admin.service;

import com.alibaba.fastjson.JSONObject;

public class OperException extends Exception {
	private static final long serialVersionUID = -5347192739172461123L;
	
	private OperErrCode errCode;

	public OperException(OperErrCode errCode) {
		super(errCode.getCode() + ": " + errCode.getMsg());
		this.errCode = errCode;
	}
	
	public OperException(String code, String msg) {
		super(code + ": " + msg);
		this.errCode = new OperErrCode(code, msg);
	}
	
	public OperException(JSONObject json) {
		this(json.getString(OperErrCode.ERR_CODE), json.getString(OperErrCode.ERR_MSG));
	}

	public OperErrCode getErrCode() {
		return errCode;
	}
	
	@Override
	public String getMessage() {
		return errCode.getMsg();
	}
}
