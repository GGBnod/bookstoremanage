package com.bookstoremanage.pojo;

import java.util.List;

public class Category {
    private int id;
    private String name;
    private int number;
    List<Mince> ms;

    public int getNumber() {
		number = 0 ;
		if(null != ms){
//			for (Mince mince : ms) {
//				number +=mince.getNumber();
//			}
            number = ms.size() ;
		}
		return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Category [name=" + name + "]";
    }

    public List<Mince> getMs() {
        return ms;
    }

    public void setMs(List<Mince> ms) {
        this.ms = ms;
    }
}