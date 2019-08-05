package com.bookstoremanage.service.impl;
import com.bookstoremanage.mapper.BookMapper;
import com.bookstoremanage.pojo.Book;
import com.bookstoremanage.pojo.BookExample;
import com.bookstoremanage.pojo.Details;
import com.bookstoremanage.service.BookService;
import com.bookstoremanage.service.OrderItemService;
import com.bookstoremanage.service.ReviewService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class BookServiceImpl implements BookService {
    @Autowired
    BookMapper bookMapper;

    @Autowired
    OrderItemService orderItemService;

    @Autowired
    ReviewService reviewService;

    @Override
    public List<Book> list() {
        BookExample example =new BookExample();
        example.setOrderByClause("id desc");
        List<Book> result = bookMapper.selectByExample(example);
        return result;
    }

    @Override
    public List<Book> list(int min) {
        BookExample example = new BookExample();
        example.createCriteria().andMidEqualTo(min);
        example.setOrderByClause("id desc");
        List<Book> result = bookMapper.selectByExample(example);
        return result;
    }

    @Override
    public int add(Book book) {
        return bookMapper.insert(book);
    }

    @Override
    public void delete(int id) {
        bookMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Book get(int id) {
        return bookMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(Book book) {
        bookMapper.updateByPrimaryKeySelective(book);
    }

    @Override
    public List<Book> listBy(String number) {
        BookExample example = new BookExample();
        example.createCriteria().andBooknumberEqualTo(number);
        example.setOrderByClause("id desc");
        List<Book> result = bookMapper.selectByExample(example);
        return result;
    }

    @Override
    public void addStock(List<Details> ds) {
        for (Details details : ds) {
            addStock(details);
        }
    }

    @Override
    public void addStock(Details details) {
        List<Book> result = list(details);
        int stock = 0;
        for (Book book : result) {
            if (10 == book.getBooknumber().length()) {
                stock = details.getNumber();
                if ("出库".equals(details.getInAndOut()))
                    stock = -stock;
                book.setStock(book.getStock() + stock);
                update(book);
            }
        }
    }

    @Override
    public List<Book> list(Details details) {
        BookExample example = new BookExample();
        example.createCriteria().andNameEqualTo(details.getName()).andAuthorEqualTo(details.getAuthor()).andPublisEqualTo(details.getPublis());
        example.setOrderByClause("id desc");
        List<Book> result = bookMapper.selectByExample(example);
        return result;
    }

    @Override
    public void setSaleAndReviewNumber(Book b) {
        int saleCount = orderItemService.getSaleCount(b.getId());
        b.setSaleCount(saleCount);

        int reviewCount = reviewService.getCount(b.getId());
        b.setReviewCount(reviewCount);
    }

    @Override
    public void setSaleAndReviewNumber(List<Book> bs) {
        for (Book b : bs) {
            setSaleAndReviewNumber(b);
        }
    }

    @Override
    public List<Book> search(String keyword) {
        BookExample example = new BookExample();
        example.createCriteria().andNameLike("%"+keyword.trim()+"%");
        example.setOrderByClause("id desc");
        List<Book> result = bookMapper.selectByExample(example);
        return result;
    }

    @Override
    public String generate() {
        PageHelper.offsetPage(0,1);
        List<Book> bs = list();

        if (null == bs) {
            return null;
        }
        Book book = bs.get(0);
        if (null == book.getBooknumber())
            return  null;
        String booknumber = book.getBooknumber();
        String s = booknumber.substring(0, 3);
        int number = Integer.valueOf(booknumber.substring(3, booknumber.length()));
        number++;

        return s + number;
    }
}