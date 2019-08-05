package com.bookstoremanage.pojo;

import java.util.List;

public class Mince {
    private Integer id;

    private Integer cid;

    private String name;

    /*非数据库字段*/
    private Category category;

    private List<Book> bs;

    private int number;

    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }

    public List<Book> getBs() {
        return bs;
    }
    public void setBs(List<Book> bs) {
        this.bs = bs;
    }

    public int getNumber() {
//        List<Book> bs = new BookDAO().list(id);
//        for (Book book : bs) {
//            number += book.getStock();
//        }
        return number;
    }
    public void setNumber(int number) {
        this.number = number;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
}