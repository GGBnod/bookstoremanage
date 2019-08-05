package com.bookstoremanage.service.impl;

import com.bookstoremanage.mapper.PurchaseMapper;
import com.bookstoremanage.pojo.*;
import com.bookstoremanage.service.PurchaseService;
import com.bookstoremanage.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class PurchaseServiceImpl  implements PurchaseService {
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    StaffService staffService;


    @Override
    public List<Purchase> list() {
        PurchaseExample example =new PurchaseExample();
        example.setOrderByClause("id desc");
        return purchaseMapper.selectByExample(example);
    }

    @Override
    public Purchase get(int id) {
        return purchaseMapper.selectByPrimaryKey(id);
    }

    @Override
    public Purchase get(String number) {
        PurchaseExample example = new PurchaseExample();
        example.createCriteria().andNumberEqualTo(number);
        List<Purchase> result = purchaseMapper.selectByExample(example);
        if (result.isEmpty())
            return null;
        return result.get(0);
    }

    @Override
    public void update(Purchase purchase) {
        purchaseMapper.updateByPrimaryKeySelective(purchase);
    }

    @Override
    public void fill(List<Purchase> ps) {
        for (Purchase p :
                ps) {
            fill(p);
        }
    }

    public void fill(Purchase p) {
        if (null == p.getSid())
            return;
        Staff staff = staffService.get(p.getSid());
        p.setStaff(staff);
    }

    @Override
    public void delete(int id) {
        purchaseMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int add(Purchase purchase) {
        return purchaseMapper.insert(purchase);
    }

}