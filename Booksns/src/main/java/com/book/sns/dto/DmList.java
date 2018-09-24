package com.book.sns.dto;

public class DmList {
	private int dmNum;
    private String fromId;
    private String toId;
    private String regdate;
	
    public DmList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DmList(int dmNum, String fromId, String toId, String regdate) {
		super();
		this.dmNum = dmNum;
		this.fromId = fromId;
		this.toId = toId;
		this.regdate = regdate;
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

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
    
	@Override
	public String toString() {
		return "DmList [dmNum=" + dmNum + ", fromId=" + fromId + ", toId=" + toId + ", regdate=" + regdate
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
}
