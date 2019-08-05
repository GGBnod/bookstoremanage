package com.bookstoremanage.pojo;

import java.util.Date;

public class Details {
    private Integer id;

    private Integer eid;

    private String inAndOut;

    private String name;

    private String author;

    private String publis;

    private Integer number;

    private Date outdate;

    /*非数据库字段*/
    private Entrepot entrepot;

    public Entrepot getEntrepot() {
        return entrepot;
    }

    public void setEntrepot(Entrepot entrepot) {
        this.entrepot = entrepot;
    }
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public String getInAndOut() {
        return inAndOut;
    }

    public void setInAndOut(String inAndOut) {
        this.inAndOut = inAndOut == null ? null : inAndOut.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public String getPublis() {
        return publis;
    }

    public void setPublis(String publis) {
        this.publis = publis == null ? null : publis.trim();
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Date getOutdate() {
        return outdate;
    }

    public void setOutdate(Date outdate) {
        this.outdate = outdate;
    }
}