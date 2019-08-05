package com.bookstoremanage.mapper;

import com.bookstoremanage.pojo.Entrepot;
import com.bookstoremanage.pojo.EntrepotExample;
import java.util.List;

public interface EntrepotMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Entrepot record);

    int insertSelective(Entrepot record);

    List<Entrepot> selectByExample(EntrepotExample example);

    Entrepot selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Entrepot record);

    int updateByPrimaryKey(Entrepot record);
}