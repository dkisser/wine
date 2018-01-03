package org.lf.admin.action.data;

import java.text.ParseException;

import org.lf.admin.action.BaseController;
import org.lf.admin.db.pojo.Wine;
import org.lf.admin.service.data.WineService;
import org.lf.utils.DateUtils;
import org.lf.utils.EasyuiDatagrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月2日 下午5:53:15 
 * @version 1.0 
 * @parameter
 */
@Controller
@RequestMapping("/data/")
public class WineController extends BaseController{

	private final String ROOT_URL="/admin/data/wine";

	@Autowired
	private WineService wineService;
	
	@RequestMapping("wineUI")
	public String wineUI (){
		return ROOT_URL+"/wineUI";
	}
	
	@RequestMapping("getWineList")
	@ResponseBody
	public EasyuiDatagrid<Wine> getWineList (String mc,String date,Integer price,int page,int rows){
		Wine wine = new Wine();
		if (!StringUtils.isEmpty(mc)){
			wine.setMc(mc);
		}
		if (!StringUtils.isEmpty(date)){
			try {
				wine.setDate(DateUtils.strToDate(date));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (price!=null){
			wine.setPrice(price);
		}
		return wineService.getWineList(wine, page, rows);
	}
	
	@RequestMapping("addWineUI")
	public String addWineUI (){
		return ROOT_URL+"/addWineUI";
	}
	
	@RequestMapping("addWine")
	@ResponseBody
	public String addWine (String mc,Integer price,String date,String remark){
		if (StringUtils.isEmpty(mc)){
			return "酒名不能为空";
		}
		if (price==null){
			return "零售价不能为空";
		}
		if (StringUtils.isEmpty(date)){
			return "日期不能为空";
		}
		if (checkWineByName(mc).equals(SUCCESS)){
			Wine wine = new Wine();
			wine.setMc(mc);
			try {
				wine.setDate(DateUtils.strToDate(date));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			wine.setPrice(price);
			wine.setRemark(remark);
			wineService.addWine(wine);
		}
		return SUCCESS;
	}
	
	@RequestMapping("checkWineByName")
	@ResponseBody
	public String checkWineByName (String mc){
		if (wineService.getWineByMc(mc)!=null){
			return "该酒已经存在，请前去核查";
		}
		return SUCCESS;
	}
	
	@RequestMapping("editWineUI")
	public String editWineUI (Integer id,Model model){
		model.addAttribute("wine", wineService.getWineById(id));
		return ROOT_URL+"/editWineUI";
	}
	
	@RequestMapping("editWine")
	@ResponseBody
	public String editWine (Integer id,Integer price,String remark,String date){
		if (id==null){
			return "提交错误，请重试";
		}
		if (price==null){
			return "零售价不可为空";
		}
		if (StringUtils.isEmpty(date)){
			return "出厂日期不可为空";
		}
		Wine wine = new Wine();
		wine.setId(id);
		wine.setPrice(price);
		wine.setRemark(remark);
		try {
			wine.setDate(DateUtils.strToDate(date));
		} catch (ParseException e) {
			e.printStackTrace();
			return "修改失败，请重试";
		}
		return wineService.editWine(wine) ? SUCCESS : "修改失败，请重试";
	}
	
	@RequestMapping("delWine")
	@ResponseBody
	public String delWine (Integer id){
		return wineService.delWine(id) ? SUCCESS : "删除失败，请重试";
	}
	
	
}
