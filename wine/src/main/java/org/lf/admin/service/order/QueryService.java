package org.lf.admin.service.order;

import java.util.List;

import org.lf.admin.db.dao.OrdersMapper;
import org.lf.admin.db.dao.VOrderMapper;
import org.lf.admin.db.pojo.Orders;
import org.lf.admin.db.pojo.VOrder;
import org.lf.utils.EasyuiDatagrid;
import org.lf.utils.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月5日 下午3:04:29 
 * @version 1.0 
 * @parameter
 */
@Service
public class QueryService {
	
	@Autowired
	private VOrderMapper vorderDao;
	
	@Autowired
	private OrdersMapper ordersDao;
	
	/**
	 * 根据传进来的条件进行模糊查询
	 * @param order
	 * @param page
	 * @param rows
	 * @return
	 */
	public EasyuiDatagrid<VOrder> getVOrderList (VOrder order,int page,int rows){
		List<VOrder> voList = vorderDao.selectListFuzzy(order);
		PageNavigator<VOrder> pg = new PageNavigator<>(voList, rows);
		return new EasyuiDatagrid<>(pg.getPage(page), voList.size());
	}
	
	/**
	 * 往Orders表中添加一条数据
	 * @return
	 */
	public Boolean addOrder (Orders orders){
		return ordersDao.insertSelective(orders)>0?true:false;
	}
	
	/**
	 * 根据条形码删除一条orders的记录
	 * @param txm
	 * @return
	 */
	public Boolean delOrder (String txm){
		return ordersDao.deleteByTXM(txm)>0?true:false;
	}
	
}
