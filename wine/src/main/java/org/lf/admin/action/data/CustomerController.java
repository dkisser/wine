package org.lf.admin.action.data;

import org.lf.admin.action.BaseController;
import org.lf.admin.db.pojo.Customer;
import org.lf.admin.service.data.CustomerService;
import org.lf.utils.EasyuiDatagrid;
import org.lf.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午5:53:01 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/data/")
public class CustomerController extends BaseController{

	private final String ROOT_URL="/admin/data/customer";
	
	@Autowired
	private CustomerService customerService;
	
	@RequestMapping("customerUI")
	public String customerUI (){
		return ROOT_URL+"/customerUI";
	}
	
	@RequestMapping("getCustomerList")
	@ResponseBody
	public EasyuiDatagrid<Customer> getCustomerList (String name,String phone,int rows,int page){
		Customer customer = new Customer();
		if (!StringUtils.isEmpty(name)){
			customer.setName(name);
		}
		if (!StringUtils.isEmpty(phone)){
			customer.setPhone(phone);
		}
		return customerService.getCustomerList(customer,rows,page);
	}
	
	@RequestMapping("delCustomer")
	@ResponseBody
	public String delCustomer (Integer id){
		if (customerService.delCustomer(id)){
			return SUCCESS;
		}
		return "删除失败";
	}
	
	@RequestMapping("addCustomerUI")
	public String addCustomerUI (){
		return ROOT_URL+"/addCustomerUI";
	}
	
	@RequestMapping("editCustomerUI")
	public String editCustomerUI (String uname,Model model){
		model.addAttribute("customer",customerService.getCustomer(uname));
		return ROOT_URL+"/editCustomerUI";
	}
	
	@RequestMapping("editCustomer")
	@ResponseBody
	public String editCustomer (Customer customer){
		if (StringUtils.isEmpty(customer.getUname())){
			return "用户名不能为空";
		}
		if (StringUtils.isEmpty(customer.getName())){
			return "姓名不能为空";
		}
		if (!checkCustomerByUname(customer.getUname()).equals(SUCCESS)){
			return "该用户名已经存在，请换一个";
		}
		if (customerService.editCustomer(customer)){
			return SUCCESS;
		}
		return "更新失败，请重试";
	}
	
	@RequestMapping("checkCustomerByUname")
	@ResponseBody
	public String checkCustomerByUname (String uname){
		Customer customer = customerService.getCusByUname(uname);
		if (customer == null){
			return SUCCESS;
		}
		return "该用户名已经存在，请换一个";
	}
	
	@RequestMapping("addCustomer")
	@ResponseBody
	public String addCustomer (Customer customer){
		if (StringUtils.isEmpty(customer.getUname())){
			return "用户名不能为空";
		}
		if (StringUtils.isEmpty(customer.getName())){
			return "用户姓名不能为空";
		}
		if (customerService.addCustomer(customer)){
			return SUCCESS;
		} else {
			return "新增失败，请重试";
		}
	}
	
}
