package com.bookstoremanage.service.impl;
import com.bookstoremanage.mapper.CategoryMapper;
import com.bookstoremanage.pojo.Book;
import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.CategoryExample;
import com.bookstoremanage.pojo.Mince;
import com.bookstoremanage.service.BookService;
import com.bookstoremanage.service.CategoryService;
import com.bookstoremanage.service.MinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
@Service
public class CategoryServiceImpl  implements CategoryService {
    @Autowired
    CategoryMapper categoryMapper;

    @Autowired
    MinceService minceService;

    @Autowired
    BookService bookService;

    @Override
    public List<Category> list() {
        List<Category> cs = listName();
        List<Mince> ms = minceService.list();
        List<Book> bs = bookService.list();

        HashMap<Integer,List<Book>> minces = new HashMap<>();
        HashMap<Integer,List<Mince>> categorys = new HashMap<>();
        for (int i = 1 ; i<=ms.get(0).getId();i++){
            List<Book> books = new ArrayList<>();
            minces.put(i,books);
        }
        for (int i = 1 ; i<=cs.get(0).getId();i++){
            List<Mince> mincehm = new ArrayList<>();
            categorys.put(i,mincehm);
        }
        for (Book book :
                bs) {
            List<Book> books = minces.get(book.getMid());
            books.add(book);
            minces.put(book.getMid(),books);
        }
        for (Mince m :
                ms) {
            List<Book> books = minces.get(m.getId());
            m.setBs(books);
        }
        for (Mince m :
                ms) {
            List<Mince> mincehm = categorys.get(m.getCid());
            mincehm.add(m);
            categorys.put(m.getCid(),mincehm);
        }
        for (Category c :
                cs) {
            List<Mince> mincehm = categorys.get(c.getId());
            c.setMs(mincehm);
        }
        return  cs;
//        return categoryMapper.list();
    }

    @Override
    public Category get(int id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public Category get(String name) {
        CategoryExample example = new CategoryExample();
        example.createCriteria().andNameLike("%"+name+"%");
        example.setOrderByClause("id desc");
        List<Category> result = categoryMapper.selectByExample(example);
        return result.get(0);
    }

    @Override
    public void update(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
    }

    @Override
    public List<Category> listName() {
        CategoryExample example =new CategoryExample();
        example.setOrderByClause("id desc");
        return categoryMapper.selectByExample(example);
    }

    @Override
    public void delete(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int add(Category category) {
        return categoryMapper.insert(category);
    }

}