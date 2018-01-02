package org.lf.admin.action.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午5:53:41 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/order/")
public class ImportController {

	private final String ROOT_URL="/admin/order/import";
	
	@RequestMapping("importUI")
	public String importUI (){
		return ROOT_URL+"/importUI";
	}
}
