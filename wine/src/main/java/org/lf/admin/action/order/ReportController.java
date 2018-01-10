package org.lf.admin.action.order;

import java.text.ParseException;

import org.lf.admin.db.pojo.VOrder;
import org.lf.admin.service.order.QueryService;
import org.lf.utils.DateUtils;
import org.lf.utils.EasyuiDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午5:54:05 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/order/")
public class ReportController {

	private final String ROOT_URL="/admin/order/report";
	
	@Autowired
	private QueryService queryService;
	
	@RequestMapping("reportUI")
	public String reportUI (){
		return ROOT_URL+"/reportUI";
	}
	
	@RequestMapping("getReportList")
	@ResponseBody
	public EasyuiDatagrid<VOrder> getReportList (VOrder order,String chrq,int page,int rows){
		try {
			if (!StringUtils.isEmpty(chrq)){
				order.setDate(DateUtils.strToDate(chrq));
			}
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
		return queryService.getVOrderList(order,page,rows);
	}
	
}
