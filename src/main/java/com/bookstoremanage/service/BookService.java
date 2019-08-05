package com.bookstoremanage.service;
import com.bookstoremanage.pojo.Book;
import com.bookstoremanage.pojo.Details;

import java.util.List;
public interface BookService{
    List<Book> list();
    List<Book> list(int min);
    int add(Book book);
    void delete(int id);
    Book get(int id);
    void update(Book book);
    List<Book> listBy(String number);
    void addStock(List<Details> ds);
    void addStock(Details details);
    List<Book> list(Details details);
    void setSaleAndReviewNumber(Book b);
    void setSaleAndReviewNumber(List<Book> bs);
    List<Book> search(String keyword);
    public String generate();
}