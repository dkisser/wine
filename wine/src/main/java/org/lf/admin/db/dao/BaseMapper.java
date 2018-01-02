package org.lf.admin.db.dao;

import java.util.List;

/** * @author  wenchen 
 * @date 创建时间：2017年7月5日 下午4:06:43 
 * @version 1.0 
 * @parameter */
public interface BaseMapper<T> {
	
	T select(T record);
	
	List<T> selectList(T record);
}
