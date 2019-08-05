package com.bookstoremanage.service.impl;

import com.bookstoremanage.mapper.StaffMapper;
import com.bookstoremanage.pojo.Staff;
import com.bookstoremanage.pojo.StaffExample;
import com.bookstoremanage.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class StaffServiceImpl implements StaffService {
    @Autowired
    StaffMapper staffMapper;

    @Override
    public void add(Staff staff) {
        staffMapper.insert(staff);
    }

    @Override
    public void delete(int id) {
        staffMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Staff staff) {
        staffMapper.updateByPrimaryKeySelective(staff);
    }

    @Override
    public Staff get(int id) {
        return staffMapper.selectByPrimaryKey(id);
    }

    @Override
    public Staff get(String name) {
        StaffExample example = new StaffExample();
        example.createCriteria().andNameEqualTo(name);
        List<Staff> result = staffMapper.selectByExample(example);
        if (result.isEmpty())
            return null;
        return result.get(0);
    }

    @Override
    public Staff get(String identifier, String password) {
        StaffExample example = new StaffExample();
        example.createCriteria().andIdentifierEqualTo(identifier).andPasswordEqualTo(password);
        List<Staff> result = staffMapper.selectByExample(example);
        if (result.size() == 0)
            return null;
        return result.get(0);
    }

    @Override
    public List<Staff> list(String department) {
        StaffExample example = new StaffExample();
        example.createCriteria().andDepartmentEqualTo(department);
        example.setOrderByClause("id desc");
        List<Staff> result = staffMapper.selectByExample(example);
        return result;
    }

    @Override
    public List<Staff> list() {
        StaffExample example = new StaffExample();
        example.setOrderByClause("id desc");
        List<Staff> result = staffMapper.selectByExample(example);
        return result;
    }

    @Override
    public String y2z(String department) {
        switch (department) {
            case "reception":
                return "前台销售部";
            case "purchase":
                return "采购部";
            case "stock":
                return "库存部";
            default:
                break;
        }
        return "all";
    }

    @Override
    public String increase(String identifier) {
        Integer number = Integer.valueOf(identifier.substring(2))+1;
        identifier = identifier.substring(0,2)+number;
        return identifier;
    }

    @Override
    public List<String> sort(String department) {
        List<String> departments = new ArrayList<>();
        departments.add("采购部");
        departments.add("库存部");
        departments.add("前台销售部");
        if (!departments.get(0).equals(department)) {
            int i = departments.indexOf(department);
            departments.set(i, departments.get(0));
            departments.set(0, department);
        }
        return departments;
    }

    @Override
    public String site(String department) {
        switch (department) {
            case "前台销售部":
                return "redirect:/admin_user_list";
            case "采购部":
                return "redirect:/admin_category_list";
            case "库存部":
                return "redirect:/admin_entrepot_list";
            case "管理员":
                return "redirect:/admin_staff_list";
            default:
                return "backgroundLogin";
        }
    }

}