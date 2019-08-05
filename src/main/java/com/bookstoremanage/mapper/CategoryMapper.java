package com.bookstoremanage.mapper;

import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.CategoryExample;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CategoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Category record);

    int insertSelective(Category record);

    List<Category> selectByExample(CategoryExample example);

    Category selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);
    @Select(" select * from category order by id desc")
    @Results({
            @Result(property = "id", column = "id"),
            @Result(property = "ms", javaType = List.class, column = "id", many = @Many(select = "com.bookstoremanage.mapper.MinceMapper.listByCategory") )
    })
    List<Category> list();
}