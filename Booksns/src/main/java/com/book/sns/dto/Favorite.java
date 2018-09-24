package com.book.sns.dto;

public class Favorite {
	private int favNum;
	private int feedNum;
	private String id;
	
	public Favorite() {	}
	public Favorite(int favNum, int feedNum, String id) {
		super();
		this.favNum = favNum;
		this.feedNum = feedNum;
		this.id = id;
	}
	public int getFavNum() {
		return favNum;
	}
	public void setFavNum(int favNum) {
		this.favNum = favNum;
	}
	public int getFeedNum() {
		return feedNum;
	}
	public void setFeedNum(int feedNum) {
		this.feedNum = feedNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "Favorite [favNum=" + favNum + ", feedNum=" + feedNum + ", id=" + id + "]";
	}
	
	
}
