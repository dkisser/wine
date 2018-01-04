package org.lf.admin.db.pojo;

import java.util.Date;

public class Orders {
    private Integer id;

    private String txm;

    private Integer wineId;

    private String shy;

    private String ywy;

    private String shz;

    private String kdr;

    private Date date;

    private String remark;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTxm() {
        return txm;
    }

    public void setTxm(String txm) {
        this.txm = txm == null ? null : txm.trim();
    }

    public Integer getWineId() {
        return wineId;
    }

    public void setWineId(Integer wineId) {
        this.wineId = wineId;
    }

    public String getShy() {
        return shy;
    }

    public void setShy(String shy) {
        this.shy = shy == null ? null : shy.trim();
    }

    public String getYwy() {
        return ywy;
    }

    public void setYwy(String ywy) {
        this.ywy = ywy == null ? null : ywy.trim();
    }

    public String getShz() {
        return shz;
    }

    public void setShz(String shz) {
        this.shz = shz == null ? null : shz.trim();
    }

    public String getKdr() {
        return kdr;
    }

    public void setKdr(String kdr) {
        this.kdr = kdr == null ? null : kdr.trim();
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}