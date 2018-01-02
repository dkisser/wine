package org.lf.admin.action.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@RequestMapping("reportUI")
	public String reportUI (){
		return ROOT_URL+"/reportUI";
	}
	
}
