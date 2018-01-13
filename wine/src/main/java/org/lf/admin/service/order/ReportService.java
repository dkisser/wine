package org.lf.admin.service.order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.lf.admin.db.dao.ChuUserMapper;
import org.lf.admin.db.dao.VOrderMapper;
import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.db.pojo.VOrder;
import org.lf.admin.service.OperErrCode;
import org.lf.admin.service.OperException;
import org.lf.utils.ExcelFileUtils;
import org.lf.utils.ExportExcelUtils;
import org.lf.utils.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月12日 下午1:57:21 
 * @version 1.0 
 * @parameter
 */
@Service
public class ReportService {
	
	private static OperErrCode 生成Excel失败 = new OperErrCode("002003001", "生成Excel失败");
	
	@Autowired
	private ChuUserMapper chuUserDao;
	
	@Autowired
	private VOrderMapper vOrderDao;
	
	/**
	 * 导出Excel表
	 * @param list
	 * @return
	 * @throws OperException 
	 */
	public boolean exprotExcel (String xsdh,String cdr,HttpServletResponse response) throws OperException{
		Boolean is = false;
		ChuUser record = new ChuUser();
		record.setUname(cdr);
		cdr=chuUserDao.select(record).getName();
		VOrder vorder = new VOrder();
		vorder.setXsdh(xsdh);
		List<VOrder> oList = vOrderDao.selectList(vorder);
		Workbook wb = null;
		try {
			wb = ExportExcelUtils.createExcel(Mode.VERSION_H, oList, cdr);
		} catch (IOException e) {
			e.printStackTrace();
			throw new OperException(生成Excel失败);
		}
		if (wb!=null){
			ExcelFileUtils.exportExcel(wb, response, "湖北白云边酒业产品溯源单.xls");
			is = true;
		}
		return is;
	}
	
	private List<JSONObject> parseArray2List (JSONArray array){
		List<JSONObject> oList = new ArrayList<JSONObject>();
		for (int i=0;i<array.size();i++){
			JSONObject obj = JSONObject.parseObject(array.get(i).toString());
			oList.add(obj);
		}
		return oList;
	}
	
}
