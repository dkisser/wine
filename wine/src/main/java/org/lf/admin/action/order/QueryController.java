package org.lf.admin.action.order;

import java.text.ParseException;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.lf.admin.action.BaseController;
import org.lf.admin.db.pojo.Orders;
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
 * @date 创建时间：2018年1月2日 下午5:53:53 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/order/")
public class QueryController extends BaseController{

	private final String ROOT_URL="/admin/order/query";
	
	@Autowired
	private QueryService queryService;
	
	@RequestMapping("queryUI")
	public String queryUI (){
		return ROOT_URL+"/queryUI";
	}
	
	@RequestMapping("getVOrderList")
	@ResponseBody
	public EasyuiDatagrid<VOrder> getVOrderList (VOrder order,String chrq,int page,int rows){
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
	
	@RequestMapping("addOrderUI")
	public String addOrderUI (){
		return ROOT_URL+"/addOrderUI";
	}
	
	@RequestMapping("editOrderUI")
	public String editOrderUI (){
		return ROOT_URL+"/editOrderUI";
	}
	
	@RequestMapping("addChooseYwyUI")
	public String addChooseYwyUI (){
		return ROOT_URL+"/addChooseYwyUI";
	}
	@RequestMapping("addChooseWineUI")
	public String addChooseWineUI (){
		return ROOT_URL+"/addChooseWineUI";
	}
	@RequestMapping("addChooseShyUI")
	public String addChooseShyUI (){
		return ROOT_URL+"/addChooseShyUI";
	}
	@RequestMapping("addChooseShrUI")
	public String addChooseShrUI (){
		return ROOT_URL+"/addChooseShrUI";
	}
	
	@RequestMapping("addOrder")
	@ResponseBody
	public String addOrder (HttpSession session,Orders order){
		order.setDate(new Date());
		order.setKdr(getUname(session));
		if (!queryService.addOrder(order)){
			return "添加失败，请重试";
		}
		return SUCCESS;
	}
	
	@RequestMapping("delOrder")
	@ResponseBody
	public String delOrder (String txm){
		if (!queryService.delOrder(txm)){
			return "删除失败，请重试";
		}
		return SUCCESS;
	}
	
}
