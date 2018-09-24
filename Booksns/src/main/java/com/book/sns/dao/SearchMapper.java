package com.book.sns.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.book.sns.dto.Book;
import com.book.sns.dto.Feed;
import com.book.sns.dto.SnsUser;

public interface SearchMapper {
	public List<Book> searchBook(HashMap<String, String> map);
	public List<SnsUser> searchUser(String keyword);
	public ArrayList<Feed> selectSearchFeedOrTag(HashMap<String, String> map);
}