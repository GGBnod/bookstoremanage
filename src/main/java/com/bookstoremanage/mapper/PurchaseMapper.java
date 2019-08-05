package com.bookstoremanage.mapper;

import com.bookstoremanage.pojo.Purchase;
import com.bookstoremanage.pojo.PurchaseExample;
import java.util.List;

public interface PurchaseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Purchase record);

    int insertSelective(Purchase record);

    List<Purchase> selectByExample(PurchaseExample example);

    Purchase selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Purchase record);

    int updateByPrimaryKey(Purchase record);
}