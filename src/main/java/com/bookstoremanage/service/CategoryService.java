package com.bookstoremanage.service;

import com.bookstoremanage.pojo.Category;

import java.util.List;
public interface CategoryService{
    List<Category> list();
    int add(Category category);
    void delete(int id);
    Category get(int id);
    Category get(String name);
    void update(Category category);
    List<Category> listName();
}