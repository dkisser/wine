package org.lf.admin.service.order;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.lf.admin.db.dao.ChuUserMapper;
import org.lf.admin.db.dao.OrdersMapper;
import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.db.pojo.Orders;
import org.lf.admin.service.OperErrCode;
import org.lf.admin.service.OperException;
import org.lf.utils.EasyuiDatagrid;
import org.lf.utils.ExcelFileUtils;
import org.lf.utils.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.druid.util.StringUtils;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月4日 下午12:42:35 
 * @version 1.0 
 * @parameter
 */
@Service
public class ImportService {
	
	public static final OperErrCode 读取Excel文件异常 = new OperErrCode("002001", "读取Excel文件异常");
	public static final OperErrCode Excel文件关闭异常 = new OperErrCode("002002", "Excel文件关闭异常");

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
	 * @throws OperException 
	 */
	public Boolean importWine (Orders Orders,MultipartFile file) throws IOException, OperException{
		String fileName = file.getOriginalFilename();
		String suffixName = fileName.split("\\.")[1];
		if (suffixName.equals("txt")){
			return importWineByTxt(Orders, file);
		} else if (suffixName.equals("xls")){
			return importWineByExcel(Orders, file,true);
		} else if (suffixName.equals("xlsx")){
			return importWineByExcel(Orders, file,false);
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
	 * @throws OperException 
	 */
	@Transactional(rollbackFor=Exception.class)
	private Boolean importWineByExcel (Orders Orders,MultipartFile file,Boolean isXls) throws OperException{
		List<Orders> oList=getAddWineListByExcel(Orders, file,isXls);
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
	 * @throws OperException 
	 */
	private List<Orders> getAddWineListByExcel (Orders orders,MultipartFile file,Boolean isXls) throws OperException{
		List<Orders> oList = null;
		InputStream in = ExcelFileUtils.importExcel(file);
		Workbook wb = null;
		try {
			if (isXls){
				wb = new HSSFWorkbook(in);
				oList = parseHSSF(wb, orders);
			} else {
				wb = new XSSFWorkbook(in);
				oList = parseXSSF(wb, orders);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new OperException(读取Excel文件异常);
		} finally {
			if (wb != null){
				try {
					wb.close();
				} catch (IOException e) {
					throw new OperException(Excel文件关闭异常);
				}
			}
			if (in!=null){
				try {
					in.close();
				} catch (IOException e) {
					throw new OperException(Excel文件关闭异常);
				}
			}
		}
		return oList;
	}
	
	/**
	 * 解析xlsx格式的
	 * @return
	 * @throws IOException 
	 * @throws OperException 
	 */
	private List<Orders> parseXSSF (Workbook wb,Orders orders) throws IOException, OperException{
		List<Orders> oList = new ArrayList<Orders>();
		XSSFSheet sheet = (XSSFSheet) wb.getSheetAt(0);
		XSSFRow row = null;
		Orders order= null;
		int lastRow = sheet.getLastRowNum();
		if (lastRow <= 0) {
			wb.close();
			throw new OperException(读取Excel文件异常);
		}
		for (int i=0;i<=lastRow;i++){
			row = sheet.getRow(i);
			String txm = row.getCell(0).getStringCellValue();
			if (StringUtils.isEmpty(txm)){
				continue;
			}
			order = new Orders();
			order.setDate(orders.getDate());
			order.setKdr(orders.getKdr());
			order.setShy(orders.getShy());
			order.setShz(orders.getShz());
			order.setTxm(txm);
			order.setWineId(orders.getWineId());
			order.setYwy(orders.getYwy());
			oList.add(order);
		}
		return oList;
	}
	/**
	 * 解析xls格式的
	 * @return
	 * @throws IOException 
	 * @throws OperException 
	 */
	private List<Orders> parseHSSF (Workbook wb,Orders orders) throws IOException, OperException{
		List<Orders> oList = new ArrayList<Orders>();
		HSSFSheet sheet = (HSSFSheet) wb.getSheetAt(0);
		HSSFRow row = null;
		Orders order= null;
		int lastRow = sheet.getLastRowNum();
		if (lastRow <= 0) {
			wb.close();
			throw new OperException(读取Excel文件异常);
		}
		for (int i=0;i<=lastRow;i++){
			row = sheet.getRow(i);
			String txm = row.getCell(0).getStringCellValue();
			if (StringUtils.isEmpty(txm)){
				continue;
			}
			order = new Orders();
			order.setDate(orders.getDate());
			order.setKdr(orders.getKdr());
			order.setShy(orders.getShy());
			order.setShz(orders.getShz());
			order.setTxm(txm);
			order.setWineId(orders.getWineId());
			order.setYwy(orders.getYwy());
			oList.add(order);
		}
		return oList;
	}
	
}
