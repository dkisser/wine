package org.lf.admin.db.dao;

import java.util.List;

import org.lf.admin.db.pojo.ChuUser;

public interface ChuUserMapper extends BaseMapper<ChuUser>{
    int deleteByPrimaryKey(Integer id);

    int insert(ChuUser record);

    int insertSelective(ChuUser record);

    ChuUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ChuUser record);

    int updateByPrimaryKey(ChuUser record);
    
    List<ChuUser> selectListFuzzy (ChuUser user);
    
    /**
     * 用于定时任务，让其每天晚上12点将xs置0
     * @return
     */
    int resetChuUser();
}