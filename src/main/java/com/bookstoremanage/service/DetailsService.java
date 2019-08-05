package com.bookstoremanage.service;
import com.bookstoremanage.pojo.Book;
import com.bookstoremanage.pojo.Details;

import java.util.List;
public interface DetailsService{
    List<Details> list();
    List<Details> list(int eid);
    int add(Details details);
    void delete(int id);
    Details get(int id);
    void update(Details details);
   }