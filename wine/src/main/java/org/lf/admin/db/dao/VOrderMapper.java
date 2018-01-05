package org.lf.admin.db.dao;

import org.lf.admin.db.pojo.VOrder;

public interface VOrderMapper extends BaseMapper<VOrder>{
    int insert(VOrder record);

    int insertSelective(VOrder record);
}