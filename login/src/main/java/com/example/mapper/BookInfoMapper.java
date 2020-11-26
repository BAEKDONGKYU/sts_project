package com.example.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.example.model.Books;

public interface BookInfoMapper {	
	public void inertBookInfo(Books book) throws Exception;
	
	public ArrayList<Books> selectBooksInfo() throws Exception;
	
	public void deleteBookInfo(int book_no) throws Exception;
	
	public Books selectBookInfo(int book_no) throws Exception;
	
	public void updateBookInfo(Books book) throws Exception;
}
