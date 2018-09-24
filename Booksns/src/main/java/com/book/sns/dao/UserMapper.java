package com.book.sns.dao;

import com.book.sns.dto.SnsUser;

public interface UserMapper {
	public SnsUser login(SnsUser user);
	public int deleteUser(String userId);
	public int userJoin(SnsUser snsUser);
	public int idCheck(String userId);
	public int loginCheck(SnsUser snsUser);
}


