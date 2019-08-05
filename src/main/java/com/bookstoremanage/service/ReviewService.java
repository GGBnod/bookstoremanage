package com.bookstoremanage.service;
 
import java.util.List;

import com.bookstoremanage.pojo.Review;

public interface ReviewService {

    void add(Review c);
    void delete(int id);
    void update(Review c);
    Review get(int id);
    List<Review> list(int bid);

    int getTotal(int bid);
    int getCount(int bid);
    boolean isExist(String content, int bid);
}

