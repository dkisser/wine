package org.lf.utils;

import java.util.List;


public class EasyuiTree {
	
	private Integer id;
	private String text;
	private List<EasyuiTree> children;
	private Boolean checked;
	private String iconCls;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public List<EasyuiTree> getChildren() {
		return children;
	}
	public void setChildren(List<EasyuiTree> children) {
		this.children = children;
	}
	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	public EasyuiTree(Integer id, String text, List<EasyuiTree> children,
			Boolean checked) {
		super();
		this.id = id;
		this.text = text;
		this.children = children;
		this.checked = checked;
	}
	
	public EasyuiTree(Integer id, String text, List<EasyuiTree> children,
			Boolean checked,String iconCls) {
		super();
		this.id = id;
		this.text = text;
		this.children = children;
		this.checked = checked;
		this.iconCls = iconCls;
	}
	
}
