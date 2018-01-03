package org.lf.admin.service.data;

import java.util.List;

import org.lf.admin.db.dao.CustomerMapper;
import org.lf.admin.db.pojo.Customer;
import org.lf.utils.EasyuiDatagrid;
import org.lf.utils.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月3日 下午2:29:46 
 * @version 1.0 
 * @parameter
 */
@Service
public class CustomerService {

	@Autowired
	private CustomerMapper customerDao;
	
	/**
	 * 根据传进来的对象查找到对应的记录
	 * @param customer
	 * @return
	 */
	public Customer getCustomer (Customer customer){
		return customerDao.select(customer);
	}
	
	/**
	 * 根据uname精确查找找customer
	 * @param uname
	 * @return
	 */
	public Customer getCusByUname (String uname){
		return customerDao.selectCustomerByUname(uname);
	}
	
	/**
	 * 根据uname模糊查找找customer
	 * @param uname
	 * @return
	 */
	public Customer getCustomer (String uname){
		Customer customer = new Customer();
		customer.setUname(uname);
		return customerDao.select(customer);
	}
	
	/**
	 * 查询用户表，得到用户信息
	 * @param customer
	 * @param total
	 * @param page
	 * @return
	 */
	public EasyuiDatagrid<Customer> getCustomerList (Customer customer,int rows,int page){
		List<Customer> cList = customerDao.selectList(customer);
		PageNavigator<Customer> pg = new PageNavigator<>(cList, rows);
		EasyuiDatagrid<Customer> result = new EasyuiDatagrid<Customer>(pg.getPage(page),cList.size());
		return result;
	}
	
	/**
	 * 根据customer的ID删除该customer
	 * @param id
	 * @return
	 */
	public Boolean delCustomer (Integer id){
		if (id!=null){
			return customerDao.deleteByPrimaryKey(id) > 0 ? true : false;
		}
		return false;
	}
	
	/**
	 * 新增客户customer
	 * @param customer
	 * @return
	 */
	public Boolean addCustomer (Customer customer){
		if (customerDao.insertSelective(customer) > 0){
			return true;
		}
		return false;
	}
	
	/**
	 * 修改客户信息
	 * @return
	 */
	public Boolean editCustomer (Customer customer){
		if (customerDao.updateByPrimaryKey(customer)>0){
			return true;
		}
		return false;
	}
	
}
