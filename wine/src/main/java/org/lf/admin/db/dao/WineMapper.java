package org.lf.admin.db.dao;

import org.lf.admin.db.pojo.Wine;

public interface WineMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Wine record);

    int insertSelective(Wine record);

    Wine selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Wine record);

    int updateByPrimaryKey(Wine record);
}