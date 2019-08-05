package com.bookstoremanage.service;

import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.Entrepot;
import com.bookstoremanage.pojo.Information;

import java.util.List;
public interface InformationService{
    List<Information> list();
    int add(Information information);
    void delete(int id);
    Information get(int id);
    void update(Information information);
}