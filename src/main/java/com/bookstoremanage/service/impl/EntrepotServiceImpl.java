package com.bookstoremanage.service.impl;
import com.bookstoremanage.mapper.EntrepotMapper;
import com.bookstoremanage.pojo.Entrepot;
import com.bookstoremanage.pojo.EntrepotExample;
import com.bookstoremanage.pojo.Staff;
import com.bookstoremanage.service.EntrepotService;
import com.bookstoremanage.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class EntrepotServiceImpl  implements EntrepotService {
    @Autowired
    EntrepotMapper entrepotMapper;
    @Autowired
    StaffService staffService;


    @Override
    public List<Entrepot> list() {
        EntrepotExample example =new EntrepotExample();
        example.setOrderByClause("id desc");
        return entrepotMapper.selectByExample(example);
    }

    @Override
    public Entrepot get(int id) {
        return entrepotMapper.selectByPrimaryKey(id);
    }

    @Override
    public Entrepot get(String num) {
        EntrepotExample example = new EntrepotExample();
        example.createCriteria().andNumEqualTo(num);
        example.setOrderByClause("id desc");
        List<Entrepot> result = entrepotMapper.selectByExample(example);
        if (result.size() == 0)
            return null;
        return result.get(0);
    }

    @Override
    public void update(Entrepot entrepot) {
        entrepotMapper.updateByPrimaryKeySelective(entrepot);
    }

    @Override
    public void fill(List<Entrepot> es) {
        for (Entrepot e :
                es) {
            fill(e);
        }
    }

    public void fill(Entrepot e) {
        if (null == e.getSid())
            return;
        Staff staff = staffService.get(e.getSid());
        e.setStaff(staff);
    }

    @Override
    public void delete(int id) {
        entrepotMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int add(Entrepot entrepot) {
        return entrepotMapper.insert(entrepot);
    }

}