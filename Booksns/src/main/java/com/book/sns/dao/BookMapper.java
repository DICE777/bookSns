package com.book.sns.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.book.sns.dto.Book;

public interface BookMapper {
	public String test(String keyword);
	
	public boolean insertBook(Book book);
	public ArrayList<Book> dbBookFind(Book book);
	public ArrayList<Book> selectBookCover(Book book);
	public ArrayList<Book> selectBookCover(Book book, RowBounds rb);
	public int bookUpdate(Book book);
	public int getBooksCount(String userid);
	public Book selectOneBook(String bookNum);
	public boolean deleteBook(String bookNum);
	public int getTotal(); //페이징처리
}
