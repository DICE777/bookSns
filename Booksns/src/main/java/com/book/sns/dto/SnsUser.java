package com.book.sns.dto;

public class SnsUser {
	
	private int userNum;
	private String userId;
	private String email;
	private String userPwd;

	private String originFile;
	private String saveFile;
	private String introduce;
	
	public SnsUser() { }
	
	public SnsUser(int userNum, String userId, String email, String userPwd, String originFile, String saveFile, String introduce) {
		this.userNum = userNum;
		this.userId = userId;
		this.email = email;
		this.userPwd = userPwd;
		this.originFile = originFile;
		this.saveFile = saveFile;
		this.introduce = introduce;
	}
	
	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getOriginFile() {
		return originFile;
	}
	
	public void setOriginFile(String originFile) {
		this.originFile = originFile;
	}
	
	public String getSaveFile() {
		return saveFile;
	}
	
	public void setSaveFile(String saveFile) {
		this.saveFile = saveFile;
	}
	
	public String getIntroduce() {
		return introduce;
	}
	
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	@Override
	public String toString() {
		return "SnsUser [userNum=" + userNum + ", userId=" + userId + ", email=" + email + ", userPwd=" + userPwd
				+ ", originFile=" + originFile + ", saveFile=" + saveFile + ", introduce=" + introduce + "]";
	}
}
