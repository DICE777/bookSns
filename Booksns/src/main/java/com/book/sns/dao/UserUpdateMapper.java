package com.book.sns.dao;

import com.book.sns.dto.SnsUser;

public interface UserUpdateMapper {
	public SnsUser selectOneUser(String id);
	public SnsUser emailCheck(String email);
	public int updateUser(SnsUser user);
}
