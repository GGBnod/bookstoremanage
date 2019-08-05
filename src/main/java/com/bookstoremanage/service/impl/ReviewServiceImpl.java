/**
* 模仿天猫整站ssm 教程 为how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	

package com.bookstoremanage.service.impl;

import java.util.List;

import com.bookstoremanage.mapper.ReviewMapper;
import com.bookstoremanage.pojo.Review;
import com.bookstoremanage.pojo.ReviewExample;
import com.bookstoremanage.pojo.User;
import com.bookstoremanage.service.ReviewService;
import com.bookstoremanage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    ReviewMapper reviewMapper;
    @Autowired
    UserService userService;

    @Override
    public void add(Review review) {
        reviewMapper.insert(review);
    }

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Review c) {
        reviewMapper.updateByPrimaryKeySelective(c);
    }

    @Override
    public Review get(int id) {
        return reviewMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Review> list(int bid){
        ReviewExample example =new ReviewExample();
        example.createCriteria().andBidEqualTo(bid);
        example.setOrderByClause("id desc");

        List<Review> result =reviewMapper.selectByExample(example);
        setUser(result);
        return result;
    }

    @Override
    public int getTotal(int bid) {
        return 0;
    }

    public void setUser(List<Review> reviews){
        for (Review review : reviews) {
            setUser(review);
        }
    }

    private void setUser(Review review) {
        int uid = review.getUid();
        User user =userService.get(uid);
        review.setUser(user);
    }

    @Override
    public int getCount(int bid) {
        return list(bid).size();
    }

    @Override
    public boolean isExist(String content, int bid) {
        ReviewExample example =new ReviewExample();
        example.createCriteria().andBidEqualTo(bid).andContentEqualTo(content);
        example.setOrderByClause("id desc");
        List<Review> result =reviewMapper.selectByExample(example);

        if (result.size()==0)
            return true;

        return false;
    }

}

