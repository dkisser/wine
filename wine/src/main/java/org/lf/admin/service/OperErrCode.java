package org.lf.admin.service;


/**
 * 资产管理错误码
 */
public class OperErrCode {
	public static final String ERR_CODE = "errcode";
	public static final String ERR_MSG = "errmsg";

	private String code;
	private String msg;
	
	public static final OperErrCode 数据库操作失败 = new OperErrCode("00001", "数据库操作失败");
	public static final OperErrCode 网络连接失败 = new OperErrCode("00002", "网络连接失败");

	public OperErrCode(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	public OperErrCode(String code, String msg, Object... params) {
		this(code, String.format(msg, params));
	}

	public String getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OperErrCode other = (OperErrCode) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}
	
}