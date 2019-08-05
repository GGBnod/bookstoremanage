package com.bookstoremanage.service.impl;
import com.bookstoremanage.mapper.MinceMapper;
import com.bookstoremanage.pojo.Book;
import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.Mince;
import com.bookstoremanage.pojo.MinceExample;
import com.bookstoremanage.service.BookService;
import com.bookstoremanage.service.CategoryService;
import com.bookstoremanage.service.MinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class MinceServiceImpl  implements MinceService {
    @Autowired
    MinceMapper minceMapper;

    @Autowired
    CategoryService categoryService;

    @Autowired
    BookService bookService;


    @Override
    public List<Mince> list() {
        MinceExample example =new MinceExample();
        example.setOrderByClause("id desc");
        return minceMapper.selectByExample(example);
    }

    @Override
    public List<Mince> list(int cid) {
        MinceExample example = new MinceExample();
        example.createCriteria().andCidEqualTo(cid);
        example.setOrderByClause("id desc");
        List<Mince> result = minceMapper.selectByExample(example);
        return result;
    }

    @Override
    public Mince get(int id) {
        Mince m = minceMapper.selectByPrimaryKey(id);
        Category c = categoryService.get(m.getCid());
        m.setCategory(c);
        return m;
    }

    @Override
    public Mince get(String name) {
        MinceExample example = new MinceExample();
        example.createCriteria().andNameEqualTo(name);
        example.setOrderByClause("id desc");
        List<Mince> result = minceMapper.selectByExample(example);
        return result.get(0);
    }

    @Override
    public void update(Mince mince) {
        minceMapper.updateByPrimaryKeySelective(mince);
    }

    @Override
    public void fillNunmer(List<Mince> ms) {
        for (Mince m :
                ms) {
            List<Book> bs = bookService.list(m.getId());
            int number = 0;
            for (Book b :
                    bs) {
                number += b.getStock();
            }
            m.setNumber(number);
        }
    }

    @Override
    public void delete(int id) {
        minceMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int add(Mince mince) {
        return minceMapper.insert(mince);
    }

}