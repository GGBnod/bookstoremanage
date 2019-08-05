package com.bookstoremanage.mapper;

import com.bookstoremanage.pojo.Information;
import com.bookstoremanage.pojo.InformationExample;
import java.util.List;

public interface InformationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Information record);

    int insertSelective(Information record);

    List<Information> selectByExample(InformationExample example);

    Information selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Information record);

    int updateByPrimaryKey(Information record);
}