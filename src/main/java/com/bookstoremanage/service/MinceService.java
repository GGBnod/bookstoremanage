package com.bookstoremanage.service;

import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.Mince;

import java.util.List;
public interface MinceService{
    List<Mince> list();
    List<Mince> list(int cid);
    int add(Mince mince);
    void delete(int id);
    Mince get(int id);
    Mince get(String name);
    void update(Mince mince);

    void fillNunmer(List<Mince> ms);
}