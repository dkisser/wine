package org.lf.admin.db.pojo;

public class ChuUser {
    private Integer id;

    private String uname;

    private String upw;

    private Integer role;

    private String name;

    private String phone;

    private Integer bmId;

    private Integer rylx;

    private String jc;

    private Integer xs;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname == null ? null : uname.trim();
    }

    public String getUpw() {
        return upw;
    }

    public void setUpw(String upw) {
        this.upw = upw == null ? null : upw.trim();
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Integer getBmId() {
        return bmId;
    }

    public void setBmId(Integer bmId) {
        this.bmId = bmId;
    }

    public Integer getRylx() {
        return rylx;
    }

    public void setRylx(Integer rylx) {
        this.rylx = rylx;
    }

    public String getJc() {
        return jc;
    }

    public void setJc(String jc) {
        this.jc = jc == null ? null : jc.trim();
    }

    public Integer getXs() {
        return xs;
    }

    public void setXs(Integer xs) {
        this.xs = xs;
    }
}