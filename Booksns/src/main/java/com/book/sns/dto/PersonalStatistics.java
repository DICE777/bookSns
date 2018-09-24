package com.book.sns.dto;

public class PersonalStatistics {
	
	private String userId;
	private String categories;
	private int cnt;
	
	
	public PersonalStatistics() {
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCategories() {
		return categories;
	}
	public void setCategories(String categories) {
		this.categories = categories;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	@Override
	public String toString() {
		return "PersonalStatistics [userId=" + userId + ", categories=" + categories + ", cnt=" + cnt + "]";
	}
	
	
	
	
	
}
