package com.bookstoremanage.mapper;

import com.bookstoremanage.pojo.Mince;
import com.bookstoremanage.pojo.MinceExample;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface MinceMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(Mince record);

    int insertSelective(Mince record);

    List<Mince> selectByExample(MinceExample example);

    Mince selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Mince record);

    int updateByPrimaryKey(Mince record);

    @Select(" select * from mince where cid = #{cid}")
    @Results({
            @Result(property = "id", column = "id"),
            @Result(property = "bs", javaType = List.class, column = "id", many = @Many(select = "com.bookstoremanage.mapper.BookMapper.listByMince") )
    })
    public List<Mince> listByCategory(int cid);
}