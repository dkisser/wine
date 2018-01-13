package org.lf.admin.db.dao;

import java.util.List;

import org.lf.admin.db.pojo.VOrder;

public interface VOrderMapper extends BaseMapper<VOrder>{
    int insert(VOrder record);

    int insertSelective(VOrder record);
    
    /**
     * 根据xsdh进行group by
     * @return
     */
    List<VOrder> getVOrderList (VOrder order);
}