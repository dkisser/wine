package org.lf.admin.db.pojo;

import java.util.Date;

public class VOrder {
    private Integer orderId;

    private String txm;

    private String xsdh;

    private String wineMc;

    private String shy;

    private String ywy;

    private String kdr;

    private String shz;

    private String khdh;

    private String shdz;

    private Date date;

    private String bmmc;

    private String bmTitle;

    private String picUrl;

    private String remark;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getTxm() {
        return txm;
    }

    public void setTxm(String txm) {
        this.txm = txm == null ? null : txm.trim();
    }

    public String getXsdh() {
        return xsdh;
    }

    public void setXsdh(String xsdh) {
        this.xsdh = xsdh == null ? null : xsdh.trim();
    }

    public String getWineMc() {
        return wineMc;
    }

    public void setWineMc(String wineMc) {
        this.wineMc = wineMc == null ? null : wineMc.trim();
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

    public String getKdr() {
        return kdr;
    }

    public void setKdr(String kdr) {
        this.kdr = kdr == null ? null : kdr.trim();
    }

    public String getShz() {
        return shz;
    }

    public void setShz(String shz) {
        this.shz = shz == null ? null : shz.trim();
    }

    public String getKhdh() {
        return khdh;
    }

    public void setKhdh(String khdh) {
        this.khdh = khdh == null ? null : khdh.trim();
    }

    public String getShdz() {
        return shdz;
    }

    public void setShdz(String shdz) {
        this.shdz = shdz == null ? null : shdz.trim();
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getBmmc() {
        return bmmc;
    }

    public void setBmmc(String bmmc) {
        this.bmmc = bmmc == null ? null : bmmc.trim();
    }

    public String getBmTitle() {
        return bmTitle;
    }

    public void setBmTitle(String bmTitle) {
        this.bmTitle = bmTitle == null ? null : bmTitle.trim();
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl == null ? null : picUrl.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}