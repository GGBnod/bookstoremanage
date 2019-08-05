package com.bookstoremanage.pojo;

import java.util.Date;
import java.util.List;

public class Entrepot {
    private Integer id;

    private String num;

    private Integer sid;

    private Date complete;

    private Integer enterNumber;

    private Integer outNumber;

    /*非数据库字段*/
    private Staff staff;

    private List<Details> ds;

    public Staff getStaff() {
        return staff;
    }
    public void setStaff(Staff staff) {
        this.staff = staff;
    }
    public List<Details> getDs() {
        return ds;
    }
    public void setDs(List<Details> ds) {
        this.ds = ds;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num == null ? null : num.trim();
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Date getComplete() {
        return complete;
    }

    public void setComplete(Date complete) {
        this.complete = complete;
    }

    public Integer getEnterNumber() {
        return enterNumber;
    }

    public void setEnterNumber(Integer enterNumber) {
        this.enterNumber = enterNumber;
    }

    public Integer getOutNumber() {
        return outNumber;
    }

    public void setOutNumber(Integer outNumber) {
        this.outNumber = outNumber;
    }
}