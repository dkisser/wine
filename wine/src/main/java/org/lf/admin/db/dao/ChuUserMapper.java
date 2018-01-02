package org.lf.admin.db.dao;

import org.lf.admin.db.pojo.ChuUser;

public interface ChuUserMapper extends BaseMapper<ChuUser>{
    int deleteByPrimaryKey(Integer id);

    int insert(ChuUser record);

    int insertSelective(ChuUser record);

    ChuUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ChuUser record);

    int updateByPrimaryKey(ChuUser record);
}