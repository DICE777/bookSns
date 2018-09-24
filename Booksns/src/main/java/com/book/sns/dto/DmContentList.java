package com.book.sns.dto;

public class DmContentList {
	
	private int dmNum; 
	private String fromId;
	private String toId;
    private String dmContent;
    private String dmRegdate;
    
    private int alarmCheck;

	public DmContentList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DmContentList(int dmNum, String fromId, String toId, String dmContent, String dmRegdate, int alarmCheck) {
		super();
		this.dmNum = dmNum;
		this.fromId = fromId;
		this.toId = toId;
		this.dmContent = dmContent;
		this.dmRegdate = dmRegdate;
		this.alarmCheck = alarmCheck;
	}

	public int getDmNum() {
		return dmNum;
	}

	public void setDmNum(int dmNum) {
		this.dmNum = dmNum;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}

	public String getDmContent() {
		return dmContent;
	}

	public void setDmContent(String dmContent) {
		this.dmContent = dmContent;
	}

	public String getDmRegdate() {
		return dmRegdate;
	}

	public void setDmRegdate(String dmRegdate) {
		this.dmRegdate = dmRegdate;
	}

	public int getAlarmCheck() {
		return alarmCheck;
	}

	public void setAlarmCheck(int alarmCheck) {
		this.alarmCheck = alarmCheck;
	}

	@Override
	public String toString() {
		return "DmContentList [dmNum=" + dmNum + ", fromId=" + fromId + ", toId=" + toId + ", dmContent=" + dmContent
				+ ", dmRegdate=" + dmRegdate + ", alarmCheck=" + alarmCheck + "]";
	}
	
   
	
    
}
