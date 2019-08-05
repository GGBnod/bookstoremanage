package com.bookstoremanage.service;

import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.Entrepot;

import java.util.List;
public interface EntrepotService{
    List<Entrepot> list();
    int add(Entrepot entrepot);
    void delete(int id);
    Entrepot get(int id);
    Entrepot get(String num);
    void update(Entrepot entrepot);
    void fill(List<Entrepot> es);
}