package org.lf.admin.action;

import javax.servlet.http.HttpSession;

import org.lf.admin.db.pojo.ChuUser;
import org.lf.admin.service.HomeService;
import org.lf.utils.Constants;
import org.lf.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午2:05:12 
 * @version 1.0 
 * @parameter
 */
@Controller()
@RequestMapping("/home/")
public class HomeController extends BaseController{
	
	private final String ROOT_URL="/admin"; 
	
	@Autowired
	private HomeService homeService;
	
	@RequestMapping("test")
	public void test (){
		System.out.println("aaaa");
	}
	
	@RequestMapping("loginUI")
	public String loginUI (){
		return "/loginUI";
	}
	
	@RequestMapping("loginAction")
	@ResponseBody
	public JSONObject loginAction (String uname,String upw,HttpSession session) {
		JSONObject resutlObj = new JSONObject();
		ChuUser user = new ChuUser();
		user.setUname(uname);
		ChuUser preUser = homeService.getUser(user);
		if (preUser != null) {
			String checkUpw = StringUtils.toMD5(preUser.getUname()+upw);
			if (checkUpw.equals(preUser.getUpw())) {
				session.setAttribute(Constants.USER_INFO, preUser);
				resutlObj.put(SUCCESS, true);
			}else{
				resutlObj.put(SUCCESS, false);
			}
		} else {
			resutlObj.put(SUCCESS, false);
		}
		return resutlObj;
	}
	
	@RequestMapping("getMenuByUname.do")
	@ResponseBody
	public JSONArray getMenuByUname (String uname) {
		return homeService.getMenuByUname(uname);
	}
	
	@RequestMapping("main")
	public String main (){
		return ROOT_URL+"/main";
	}
	
	@RequestMapping("welcome")
	public String welcome (){
		return ROOT_URL+"/welcome";
	}
	
	@RequestMapping("quit")
	public String quit (HttpSession session){
		session.setAttribute(Constants.USER_INFO, null);
		return "redirect:/home/loginUI";
	}
	
	@RequestMapping("currUser")
	public String currUser (){
		return ROOT_URL+"/home/currUser";
	}
	
	@RequestMapping("updatePwdUI")
	public String updatePwd (){
		return ROOT_URL+"/home/updatePwdUI";
	}
	
	@RequestMapping("updateUpwAction")
	@ResponseBody
	public JSONObject updateUpwAction(String uname,String old_upw,String new_upw) {
		JSONObject obj = new JSONObject();
		ChuUser user = new ChuUser();
		user.setUname(uname);
		ChuUser preUser = homeService.getUser(user);
		String checkUpw =StringUtils.toMD5(uname+old_upw);
		if (checkUpw.equals(preUser.getUpw())) {
			preUser.setUpw(StringUtils.toMD5(uname+new_upw));
			homeService.updateUser(preUser);
			obj.put(SUCCESS, true);
		} else {
			obj.put(SUCCESS, false);
		}
		return obj;
	}
	
}
