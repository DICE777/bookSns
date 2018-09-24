package com.book.sns.dto;

public class FollowingList {
	
	private int userNum;
	private String userId;
	private String email;
	private String userPwd;

	private String originFile;
	private String saveFile;
	private String introduce;
	
	private int rNum;
	private String loginId;
	private String followId;
	
	public FollowingList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FollowingList(int userNum, String userId, String email, String userPwd, String originFile, String saveFile,
			String introduce, int rNum, String loginId, String followId) {
		super();
		this.userNum = userNum;
		this.userId = userId;
		this.email = email;
		this.userPwd = userPwd;
		this.originFile = originFile;
		this.saveFile = saveFile;
		this.introduce = introduce;
		this.rNum = rNum;
		this.loginId = loginId;
		this.followId = followId;
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
		return "FollowingList [userNum=" + userNum + ", userId=" + userId + ", email=" + email + ", userPwd=" + userPwd
				+ ", originFile=" + originFile + ", saveFile=" + saveFile + ", introduce=" + introduce + ", rNum="
				+ rNum + ", loginId=" + loginId + ", followId=" + followId + "]";
	}
	
	
	
	
}
