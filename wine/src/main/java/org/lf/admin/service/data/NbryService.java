package org.lf.admin.service.data;

import java.util.List;

import org.lf.admin.db.dao.ChuUserMapper;
import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.service.BMLX;
import org.lf.utils.EasyuiDatagrid;
import org.lf.utils.PYUtils;
import org.lf.utils.PageNavigator;
import org.lf.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月3日 下午4:54:39 
 * @version 1.0 
 * @parameter
 */
@Service
public class NbryService {

	@Autowired
	private ChuUserMapper chuUserDao;
	
	/**
	 * 根据传入的条件查询得到ChuUser表中的记录
	 * @param user
	 * @param page
	 * @param rows
	 * @return
	 */
	public EasyuiDatagrid<ChuUser> getNbryList (ChuUser user,int page,int rows){
		List<ChuUser> uList = chuUserDao.selectListFuzzy(user);
		PageNavigator<ChuUser> pg = new PageNavigator<>(uList, rows);
		return new EasyuiDatagrid<>(pg.getPage(page), uList.size());
	}
	
	/**
	 * 查询ChuUser表中是否存在该用户名
	 * @param uname
	 * @return
	 */
	public Boolean checkNbryByUname (String uname){
		Boolean is = false;
		ChuUser record = new ChuUser();
		record.setUname(uname);
		if (chuUserDao.select(record)!=null){
			is = true;
		}
		return is;
	}
	
	/**
	 * 往ChuUser中插入一条记录
	 * @param user
	 * @return
	 */
	public Boolean addNbry (ChuUser user){
		user.setUpw(StringUtils.toMD5(user.getUname()+user.getUpw()));
		user.setBmId(BMLX.湖北白云边.getValue());
		user.setJc(PYUtils.convertHanzi2Pinyin(user.getName(), false));
		return chuUserDao.insertSelective(user)>0?true:false;
	}
	
	/**
	 * 跟据主键id删除一个chuUser
	 * @param id
	 * @return
	 */
	public Boolean delNbry (Integer id){
		return chuUserDao.deleteByPrimaryKey(id)>0?true:false;
	}
	
	/**
	 * 将密码重置为123456
	 * @param user
	 * @return
	 */
	public Boolean resetNbry (ChuUser user){
		user.setUpw(StringUtils.toMD5(user.getUname()+"123456"));
		return chuUserDao.updateByPrimaryKeySelective(user)>0?true:false;
	}
	
	/**
	 * 根据条件得到一条ChuUser记录
	 * @param user
	 * @return
	 */
	public ChuUser getUser (ChuUser user){
		return chuUserDao.select(user);
	}
	
	/**
	 * 根据id更新ChuUser相关记录
	 * @param user
	 * @return
	 */
	public Boolean updateNbry (ChuUser user){
		return chuUserDao.updateByPrimaryKeySelective(user)>0?true:false;
	}
}
