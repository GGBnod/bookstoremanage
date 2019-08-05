package com.bookstoremanage.service;
 
import java.util.List;

import com.bookstoremanage.pojo.User;

public interface UserService {
    void add(User c);
    void update(User c);
    User get(int id);
    List<User> list();
    boolean isExist(String name);
    User get(String name);
    User get(String name, String password);
}

