package org.lf.admin.service;
/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月4日 下午12:48:27 
 * @version 1.0 
 * @parameter
 */
public enum ChuUserType {
	
	送货员(0),业务员(1);

	private int value;
	
	private ChuUserType(int value) {
		value = this.value;
	}
	
	public int getValue (){
		return value;
	}
	
	public static ChuUserType valueOf(int value) {
		return ChuUserType.values()[value];
	}
	
}
