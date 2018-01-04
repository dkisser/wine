package org.lf.admin.service.order;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.lf.admin.db.dao.ChuUserMapper;
import org.lf.admin.db.dao.OrdersMapper;
import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.db.pojo.Orders;
import org.lf.utils.EasyuiDatagrid;
import org.lf.utils.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月4日 下午12:42:35 
 * @version 1.0 
 * @parameter
 */
@Service
public class ImportService {

	@Autowired
	private ChuUserMapper chuUserDao;
	
	@Autowired
	private OrdersMapper ordersDao;
	
	/**
	 * 根据name,phone,rylx等条件的到ChuUser表中的记录
	 * @param name
	 * @param phone
	 * @param page
	 * @param rows
	 * @return
	 */
	public EasyuiDatagrid<ChuUser> getChuUserList (String name,String phone,Integer rylx,int page,int rows){
		ChuUser user = new ChuUser();
		user.setName(name);
		user.setPhone(phone);
		user.setRylx(rylx);
		List<ChuUser> uList = chuUserDao.selectListFuzzy(user);
		PageNavigator<ChuUser> pg = new PageNavigator<>(uList, rows);
		EasyuiDatagrid<ChuUser> result = new EasyuiDatagrid<>(pg.getPage(page), uList.size());
		return result;
	}
	
	/**
	 * 根据上传的文件来批量导入数据到订单表Orders
	 * @param Orders
	 * @param file
	 * @return
	 * @throws IOException 
	 */
	public Boolean importWine (Orders Orders,MultipartFile file) throws IOException{
		String fileName = file.getOriginalFilename();
		String suffixName = fileName.split("\\.")[1];
		if (suffixName.equals("txt")){
			return importWineByTxt(Orders, file);
		} else if (suffixName.equals("xls")){
			return importWineByExcel(Orders, file);
		} else if (suffixName.equals("xlsx")){
			return importWineByExcel(Orders, file);
		}else {
			return false;
		}
	}
	
//	  /**
//     * 得到上传文件的文件头
//     * @param src
//     * @return
//     */
//    private String bytesToHexString(byte[] src) {
//        StringBuilder stringBuilder = new StringBuilder();
//        if (src == null || src.length <= 0) {
//            return null;
//        }
//        for (int i = 0; i < src.length; i++) {
//            int v = src[i] & 0xFF;
//            String hv = Integer.toHexString(v);
//            if (hv.length() < 2) {
//                stringBuilder.append(0);
//            }
//            stringBuilder.append(hv);
//        }
//        return stringBuilder.toString();
//    }
	/**
	 * 根据上传的txt文件插入数据到Orders表
	 * @param Orders
	 * @param file
	 * @return
	 * @throws IOException 
	 */
	@Transactional(rollbackFor=Exception.class)
	private Boolean importWineByTxt (Orders Orders,MultipartFile file) throws IOException{
		List<Orders> oList=getAddWineListByTxt(Orders, file);
		Boolean result = false;
		for (Orders o:oList){
			result = ordersDao.insertSelective(o)>0?true:false;
		}
		return result;
	}
	
	/**
	 * 根据传进来的txt将其转换成要插入的Orders列表
	 * @param Orders
	 * @param file
	 * @return
	 * @throws IOException 
	 */
	private List<Orders> getAddWineListByTxt (Orders orders,MultipartFile file) throws IOException{
		InputStream in = file.getInputStream();
		//控制该数组大小（条形码长度+2），从而实现一行一行的读.
		List<Orders> result = new ArrayList<Orders>();
		byte[] array = new byte[11];
		int i=-1;
		while ((i=in.read(array))!=-1){
			String txm = new String(array);
			Orders newOrders = new Orders();
			newOrders.setDate(orders.getDate());
			newOrders.setKdr(orders.getKdr());
			newOrders.setShy(orders.getShy());
			newOrders.setShz(orders.getShz());
			newOrders.setWineId(orders.getWineId());
			newOrders.setYwy(orders.getYwy());
			newOrders.setTxm(txm);
			result.add(newOrders);
		}
		if (in!=null){
			in.close();
		}
		return result;
	}
	
	/**
	 * 根据上传的excel文件插入数据到Orders表
	 * @param Orders
	 * @param file
	 * @return
	 */
	private Boolean importWineByExcel (Orders Orders,MultipartFile file){
		List<Orders> oList=getAddWineListByExcel(Orders, file);
		Boolean result = false;
		for (Orders o:oList){
			result = ordersDao.insertSelective(o)>0?true:false;
		}
		return result;
	}
	
	/**
	 * 根据传进来的Excel将其转换成要插入的Orders列表
	 * @param Orders
	 * @param file
	 * @return
	 */
	private List<Orders> getAddWineListByExcel (Orders Orders,MultipartFile file){
		return null;
	}
	
	
}
