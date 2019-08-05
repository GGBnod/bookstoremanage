package com.bookstoremanage.service;
import com.bookstoremanage.pojo.Purchase;

import java.util.List;
public interface PurchaseService {
    List<Purchase> list();
    int add(Purchase purchase);
    void delete(int id);
    Purchase get(int id);
    Purchase get(String number);
    void update(Purchase purchase);
    void fill(List<Purchase> ps);
}