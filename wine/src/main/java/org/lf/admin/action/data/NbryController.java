package org.lf.admin.action.data;

import org.lf.admin.action.BaseController;
import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.service.data.NbryService;
import org.lf.utils.EasyuiDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午5:53:15 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/data/")
public class NbryController extends BaseController{

	private final String ROOT_URL="/admin/data/nbry";

	@Autowired
	private NbryService nbryService;
	
	@RequestMapping("nbryUI")
	public String wineUI (){
		return ROOT_URL+"/nbryUI";
	}
	
	@RequestMapping("getNbryList")
	@ResponseBody
	public EasyuiDatagrid<ChuUser> getNbryList (ChuUser user,int page,int rows){
		return nbryService.getNbryList(user, page, rows);
	}
	
	@RequestMapping("addNbryUI")
	public String addNbryUI (){
		return ROOT_URL+"/addNbryUI";
	}
	
	@RequestMapping("editNbryUI")
	public String editNbryUI (Model model,ChuUser user){
		model.addAttribute("nbry", nbryService.getUser(user));
		return ROOT_URL+"/editNbryUI";
	}
	
	@RequestMapping("checkNbryByUname")
	@ResponseBody
	public String checkNbryByUname (String uname){
		if (nbryService.checkNbryByUname(uname)){
			return "该用户名已存在，请换一个";
		}
		return SUCCESS;
		
	}
	
	@RequestMapping("addNbry")
	@ResponseBody
	public String addNbry (ChuUser user){
		if (nbryService.checkNbryByUname(user.getUname())){
			return "该用户名已存在，请换一个";
		}
		if (!nbryService.addNbry(user)){
			return "添加失败，请重试";
		}
		return SUCCESS;
	}
	
	@RequestMapping("delNbry")
	@ResponseBody
	public String delNbry (Integer id){
		if (!nbryService.delNbry(id)){
			return "删除失败，请重试";
		}
		return SUCCESS;
	}
	
	@RequestMapping("resetNbry")
	@ResponseBody
	public String resetNbry (ChuUser user){
		if (!nbryService.resetNbry(user)){
			return "重置密码失败，请重试";
		}
		return SUCCESS;
	}
	
	@RequestMapping("editNbry")
	@ResponseBody
	public String editNbry (ChuUser user){
		if (!nbryService.updateNbry(user)){
			return "更新失败，请重试";
		}
		return SUCCESS;
	}
	
}
