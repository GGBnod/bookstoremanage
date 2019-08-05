package com.bookstoremanage.service.impl;
import com.bookstoremanage.mapper.EntrepotMapper;
import com.bookstoremanage.mapper.InformationMapper;
import com.bookstoremanage.pojo.*;
import com.bookstoremanage.service.InformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class InformationServiceImpl  implements InformationService {
    @Autowired
    InformationMapper informationMapper;


    @Override
    public List<Information> list() {
        InformationExample example =new InformationExample();
        example.setOrderByClause("id desc");
        return informationMapper.selectByExample(example);
    }

    @Override
    public Information get(int id) {
        return informationMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(Information information) {
        informationMapper.updateByPrimaryKeySelective(information);
    }

    @Override
    public void delete(int id) {
        informationMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int add(Information information) {
        return informationMapper.insert(information);
    }

}