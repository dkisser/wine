package org.lf.admin.service;

import java.util.List;

import org.lf.admin.db.dao.ChuUserMapper;
import org.lf.admin.db.dao.MenuMapper;
import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.db.pojo.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/** * @author  wenchen 
 * @date 创建时间：2017年7月5日 上午10:27:23 
 * @version 1.0 
 * @parameter */
@Service("homeService")
public class HomeService {
	
	@Autowired
	private ChuUserMapper userDao;
	
	
	@Autowired
	private MenuMapper menuDao;
	
	public ChuUser getUser(ChuUser user){
		return userDao.select(user);
	}
	
	public List<ChuUser> getUserList(ChuUser user){
		return userDao.selectList(user);
	}
	
	/**
	 * 功能:获得菜单选项的一个json数组
	 * @param uname
	 * @return
	 */
	public JSONArray getMenuByUname (String uname) {
		JSONArray resultArr = new JSONArray();
		List<Menu> menuList = menuDao.getMenuByUname(uname);
		for (Menu parentMenu : menuList) {
			if (parentMenu.getPid()==0) {
				JSONArray arr = new JSONArray();
				JSONObject obj = new JSONObject();
				for (Menu childMenu : menuList) {
					if (parentMenu.getId()==childMenu.getPid()) {
						arr.add(childMenu);
					}
				}
				obj.put("parent", parentMenu);
				obj.put("child", arr);
				resultArr.add(obj);
			}
		}
		return resultArr;
	}

	public Boolean updateUser(ChuUser user) {
		return userDao.updateByPrimaryKeySelective(user) > 0 ? true : false;
	}
	
	public List<ChuUser> getTestJson () {
		ChuUser record = new ChuUser();
		return userDao.selectList(record);
	}
}
