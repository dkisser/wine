package org.lf.utils.schedule;

import org.lf.admin.db.dao.ChuUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月6日 下午12:28:10 
 * @version 1.0 
 * @parameter
 */
@Component
public class DBSchedule{
	
	@Autowired
	private ChuUserMapper chuUserDao;
	
	/**
	 * 每天晚上12点清空chuUser的xs字段，让其置0
	 */
	@Scheduled(cron="59 59 23 * * ? ")
	public void resetChuUser (){
		chuUserDao.resetChuUser();
	}
	
}
