package com.book.sns.dto;

public class Relationship {

	private int rNum;
	private String loginId;
	private String followId;
	
	public Relationship() {
	}

	public int getrNum() {
		return rNum;
	}

	public void setrNum(int rNum) {
		this.rNum = rNum;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getFollowId() {
		return followId;
	}

	public void setFollowId(String followId) {
		this.followId = followId;
	}

	@Override
	public String toString() {
		return "Relationship [rNum=" + rNum + ", loginId=" + loginId + ", followId=" + followId + "]";
	}
	
	
}
