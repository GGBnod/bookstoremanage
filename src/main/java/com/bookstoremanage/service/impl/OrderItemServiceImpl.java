/**
* 模仿天猫整站ssm 教程 为how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	

package com.bookstoremanage.service.impl;

import java.util.List;

import com.bookstoremanage.mapper.OrderItemMapper;
import com.bookstoremanage.pojo.*;
import com.bookstoremanage.service.BookService;
import com.bookstoremanage.service.OrderItemService;
import com.bookstoremanage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class OrderItemServiceImpl implements OrderItemService {
    @Autowired
    OrderItemMapper orderItemMapper;
    @Autowired
    BookService bookService;
    @Autowired
    UserService userService;

    @Override
    public void add(OrderItem orderItem) {
        orderItemMapper.insert(orderItem);
    }

    @Override
    public void delete(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(OrderItem orderItem) {
        orderItemMapper.updateByPrimaryKeySelective(orderItem);
    }

    @Override
    public OrderItem get(int id) {
        OrderItem result = orderItemMapper.selectByPrimaryKey(id);
//        setProduct(result);
        return result;
    }

    public List<OrderItem> list(){
        OrderItemExample example =new OrderItemExample();
        example.setOrderByClause("id desc");
        return orderItemMapper.selectByExample(example);

    }

    @Override
    public void fill(List<Order> os) {
        for (Order o : os) {
            fill(o);
        }
    }

    @Override
    public int getSaleCount(int bid) {
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andBidEqualTo(bid);
        List<OrderItem> ois =orderItemMapper.selectByExample(example);
        int result =0;
        for (OrderItem oi : ois) {
            Integer number = 0;
                    if(null!=oi.getNumber())
                        number = oi.getNumber();
            result+=number;
        }
        return result;
    }

    @Override
    public List<OrderItem> listByUser(int uid) {
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andUidEqualTo(uid).andOidIsNull();
        List<OrderItem> result =orderItemMapper.selectByExample(example);
//        setProduct(result);
        return result;
    }

    @Override
    public List<OrderItem> listByOrder(int oid) {
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andOidEqualTo(oid);
        List<OrderItem> result =orderItemMapper.selectByExample(example);
//        setProduct(result);
        return result;
    }

    public void fill(Order o) {
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andOidEqualTo(o.getId());
        example.setOrderByClause("id desc");
        List<OrderItem> ois =orderItemMapper.selectByExample(example);
//        setBook(ois);

        float total = 0;
        int totalNumber = 0;
        for (OrderItem oi : ois) {
            Book book = bookService.get(oi.getBid());
            oi.setBook(book);
            total+=oi.getNumber()*book.getPrice();
            totalNumber+=oi.getNumber();
        }
        User user = userService.get(o.getUid());
        o.setUser(user);
        o.setTotal(total);
        o.setTotalNumber(totalNumber);
        o.setOrderItems(ois);


    }

//    public void setBook(List<OrderItem> ois){
//        for (OrderItem oi: ois) {
//            setBook(oi);
//        }
//    }
//
//    private void setBook(OrderItem oi) {
//        Book book = bookService.get(oi.getBid());
//        bookService.setFirstProductImage(p);
//        oi.setProduct(p);
//    }




}
