package com.bookstoremanage.service;

import com.bookstoremanage.pojo.Order;
import com.bookstoremanage.pojo.OrderItem;

import java.util.List;

public interface OrderItemService {

    void add(OrderItem c);

    void delete(int id);
    void update(OrderItem c);
    OrderItem get(int id);
    List list();

    void fill(List<Order> os);

    void fill(Order o);

    List<OrderItem> listByUser(int uid);

    List<OrderItem> listByOrder(int oid);

    int getSaleCount(int bid);
}

