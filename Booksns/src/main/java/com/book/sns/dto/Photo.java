package com.book.sns.dto;

public class Photo {
	private int pNum;
	private int feedNum;
	private String saveImg;
	private String originImg;
	public Photo(int pNum, int feedNum, String saveImg, String originImg) {
		super();
		this.pNum = pNum;
		this.feedNum = feedNum;
		this.saveImg = saveImg;
		this.originImg = originImg;
	}
	public Photo() {
		super();
	}
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public int getFeedNum() {
		return feedNum;
	}
	public void setFeedNum(int feedNum) {
		this.feedNum = feedNum;
	}
	public String getSaveImg() {
		return saveImg;
	}
	public void setSaveImg(String saveImg) {
		this.saveImg = saveImg;
	}
	public String getOriginImg() {
		return originImg;
	}
	public void setOriginImg(String originImg) {
		this.originImg = originImg;
	}
	@Override
	public String toString() {
		return "Photo [pNum=" + pNum + ", feedNum=" + feedNum + ", saveImg=" + saveImg + ", originImg=" + originImg
				+ "]";
	}
	
}
