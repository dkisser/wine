package org.lf.admin.action.order;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.lf.admin.action.BaseController;
import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.db.pojo.Orders;
import org.lf.admin.service.ChuUserType;
import org.lf.admin.service.OperException;
import org.lf.admin.service.order.ImportService;
import org.lf.utils.EasyuiDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.druid.util.StringUtils;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午5:53:41 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/order/")
public class ImportController extends BaseController{

	private final String ROOT_URL="/admin/order/import";
	
	@Autowired
	private ImportService importService;
	
	@RequestMapping("importUI")
	public String importUI (){
		return ROOT_URL+"/importUI";
	}
	
	@RequestMapping("chooseShrUI")
	public String chooseShrUI (){
		return ROOT_URL+"/chooseShrUI";
	}
	
	@RequestMapping("chooseShyUI")
	public String chooseShyUI (){
		return ROOT_URL+"/chooseShyUI";
	}
	
	@RequestMapping("chooseYwyUI")
	public String chooseYwyUI (){
		return ROOT_URL+"/chooseYwyUI";
	}
	
	@RequestMapping("chooseWineUI")
	public String chooseWineUI (){
		return ROOT_URL+"/chooseWineUI";
	}
	
	/**
	 * 得到所有业务员的列表
	 * @param name
	 * @param phone
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("getYwyList")
	@ResponseBody
	public EasyuiDatagrid<ChuUser> getYwyList (String name,String phone,int page,int rows){
		if (StringUtils.isEmpty(name)){
			name = null;
		}
		if (StringUtils.isEmpty(phone)){
			phone = null;
		}
		return importService.getChuUserList(name, phone, ChuUserType.业务员.getValue(), page, rows);
	}
	
	/**
	 * 得到所有送货员的列表
	 * @param name
	 * @param phone
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("getShyList")
	@ResponseBody
	public EasyuiDatagrid<ChuUser> getShyList (String name,String phone,int page,int rows){
		if (StringUtils.isEmpty(name)){
			name = null;
		}
		if (StringUtils.isEmpty(phone)){
			phone = null;
		}
		return importService.getChuUserList(name, phone, ChuUserType.送货员.getValue(), page, rows);
	}
	
	/**
	 * 提交表单，往order中插入一条数据
	 * @param order
	 * @return
	 */
	@RequestMapping("importWine")
	@ResponseBody
	public String importWine (HttpSession session,Orders order,@RequestParam(value="file",required=true)MultipartFile file){
		order.setKdr(getUname(session));
		order.setDate(new Date());
		try {
			if (!importService.importWine(order, file)){
				return "上传失败，请重试";
			}
		} catch (OperException e) {
			e.printStackTrace();
			return e.getMessage();
		}
		return SUCCESS;
	}
	
}
