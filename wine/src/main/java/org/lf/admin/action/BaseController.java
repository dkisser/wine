package org.lf.admin.action;

import javax.servlet.http.HttpSession;

import org.lf.admin.db.pojo.ChuUser;
import org.lf.utils.Constants;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午4:08:04 
 * @version 1.0 
 * @parameter
 */
public class BaseController {
	
	public final String SUCCESS = "success";
	
	public String getUname (HttpSession session) {
		ChuUser preUser = getCurUser(session);
		return preUser == null ? null : preUser.getUname();
	}
	
	public ChuUser getCurUser (HttpSession session) {
		return (ChuUser) session.getAttribute(Constants.USER_INFO);
	}
	
}
