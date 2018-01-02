package org.lf.admin.action.data;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午5:53:01 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/data/")
public class CustomerController {

	private final String ROOT_URL="/admin/data/customer";
	
	@RequestMapping("customerUI")
	public String customerUI (){
		return ROOT_URL+"/customerUI";
	}
	
}
