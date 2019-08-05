package com.bookstoremanage.mapper;

import com.bookstoremanage.pojo.Book;
import com.bookstoremanage.pojo.BookExample;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BookMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Book record);

    int insertSelective(Book record);

    List<Book> selectByExample(BookExample example);

    Book selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);

    @Select(" select * from book where mid = #{mid} limit 0,5")
    public List<Book> listByMince(int mid);
}