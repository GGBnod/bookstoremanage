package com.bookstoremanage.service;

import com.bookstoremanage.pojo.Staff;

import java.util.List;

public interface StaffService {

    void add(Staff staff);
    void delete(int id);
    void update(Staff staff);
    Staff get(int id);
    Staff get(String name);
    Staff get(String identifier, String password);
    List<Staff> list(String department);
    List<Staff> list();
    String y2z(String department);
    String increase(String identifier);
    List<String> sort(String department);
    String site(String department);
}
