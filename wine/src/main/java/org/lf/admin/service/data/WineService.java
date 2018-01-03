package org.lf.admin.service.data;

import java.util.List;

import org.lf.admin.db.dao.WineMapper;
import org.lf.admin.db.pojo.Wine;
import org.lf.utils.EasyuiDatagrid;
import org.lf.utils.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月3日 下午4:54:39 
 * @version 1.0 
 * @parameter
 */
@Service
public class WineService {

	@Autowired
	private WineMapper wineDao;
	
	/**
	 * 根据条件来查询得到符合条件的wine中的记录
	 * @param mc
	 * @param date
	 * @param price
	 * @return
	 */
	public EasyuiDatagrid<Wine> getWineList (Wine wine,int page,int rows){
		List<Wine> wList = wineDao.selectList(wine);
		PageNavigator<Wine> pg = new PageNavigator<>(wList, rows);
		EasyuiDatagrid<Wine> result = new EasyuiDatagrid<>(pg.getPage(page), wList.size());
		return result;
	}
	
	/**
	 * 根据mc来查找wine得到记录
	 * @param mc
	 * @return
	 */
	public Wine getWineByMc (String mc){
		return wineDao.selectWineByMc(mc);
	}
	
	/**
	 * 根据Id找到wine表的一条记录
	 * @param id
	 * @return
	 */
	public Wine getWineById (Integer id){
		return wineDao.selectByPrimaryKey(id);
	}
	
	/**
	 * 插入一条记录到wine表
	 * @param wine
	 * @return
	 */
	public Boolean addWine (Wine wine){
		return wineDao.insertSelective(wine) > 0 ? true : false;
	}
	
	/**
	 * 根据ID删除一条记录
	 * @param id
	 * @return
	 */
	public Boolean delWine (Integer id){
		return wineDao.deleteByPrimaryKey(id)>0?true:false;
	}
	
	/**
	 * 修改一条酒的记录
	 * @param wine
	 * @return
	 */
	public Boolean editWine (Wine wine){
		return wineDao.updateByPrimaryKeySelective(wine)>0?true:false;
	}
	
}
