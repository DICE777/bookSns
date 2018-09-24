package com.book.sns.dto;

public class DmAlarm {
	
	private int dmNum;
	private String userId;
	private int alarmCheck;
	
	public DmAlarm() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DmAlarm(int dmNum, String userId, int alarmCheck) {
		super();
		this.dmNum = dmNum;
		this.userId = userId;
		this.alarmCheck = alarmCheck;
	}

	public int getDmNum() {
		return dmNum;
	}

	public void setDmNum(int dmNum) {
		this.dmNum = dmNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getAlarmCheck() {
		return alarmCheck;
	}

	public void setAlarmCheck(int alarmCheck) {
		this.alarmCheck = alarmCheck;
	}

	@Override
	public String toString() {
		return "DmAlarm [dmNum=" + dmNum + ", userId=" + userId + ", alarmCheck=" + alarmCheck + "]";
	}
	
	
	
	
}