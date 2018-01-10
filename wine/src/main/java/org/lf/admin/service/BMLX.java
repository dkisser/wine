package org.lf.admin.service;
/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月10日 下午2:27:53 
 * @version 1.0 
 * @parameter
 */
public enum BMLX {
	
	湖北白云边(0);
	
	private int value;
	
	private BMLX(int value) {
		value = this.value;
	}
	
	public int getValue (){
		return value;
	}
	
	public static BMLX valueOf(int value) {
		return BMLX.values()[value];
	}	
}
