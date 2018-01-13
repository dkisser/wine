package org.lf.admin.db.dao;

import org.lf.admin.db.pojo.Customer;

public interface CustomerMapper extends BaseMapper<Customer>{
    int deleteByPrimaryKey(Integer id);

    int insert(Customer record);

    int insertSelective(Customer record);

    Customer selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);
    
    Customer selectCustomerByUname (String uname);
    
    int getCount(Customer record);
}