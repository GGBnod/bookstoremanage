package com.bookstoremanage.service.impl;
import com.bookstoremanage.mapper.BookMapper;
import com.bookstoremanage.mapper.DetailsMapper;
import com.bookstoremanage.pojo.Details;
import com.bookstoremanage.pojo.DetailsExample;
import com.bookstoremanage.service.DetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class DetailsServiceImpl  implements DetailsService {
    @Autowired
    DetailsMapper detailsMapper;


    @Override
    public List<Details> list() {
        DetailsExample example =new DetailsExample();
        example.setOrderByClause("id desc");
        return detailsMapper.selectByExample(example);
    }

    @Override
    public List<Details> list(int eid) {
        DetailsExample example = new DetailsExample();
        example.createCriteria().andEidEqualTo(eid);
        example.setOrderByClause("id desc");
        List<Details> result = detailsMapper.selectByExample(example);
        return result;
    }

    @Override
    public int add(Details details) {
        return detailsMapper.insert(details);
    }

    @Override
    public void delete(int id) {
        detailsMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Details get(int id) {
        return detailsMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(Details details) {
        detailsMapper.updateByPrimaryKeySelective(details);
    }
}