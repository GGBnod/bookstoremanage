package com.bookstoremanage.mapper;

import com.bookstoremanage.pojo.Details;
import com.bookstoremanage.pojo.DetailsExample;
import java.util.List;

public interface DetailsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Details record);

    int insertSelective(Details record);

    List<Details> selectByExample(DetailsExample example);

    Details selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Details record);

    int updateByPrimaryKey(Details record);
}