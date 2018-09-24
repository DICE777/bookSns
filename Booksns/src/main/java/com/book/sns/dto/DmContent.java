package com.book.sns.dto;

public class DmContent {
	private int dmContentId;
	private int dmNum;
	private String dmUserId;
    private String dmContent;
    private String dmRegdate;
	
    public DmContent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DmContent(int dmContentId, int dmNum, String dmUserId, String dmContent, String dmRegdate) {
		super();
		this.dmContentId = dmContentId;
		this.dmNum = dmNum;
		this.dmUserId = dmUserId;
		this.dmContent = dmContent;
		this.dmRegdate = dmRegdate;
	}

	public int getDmContentId() {
		return dmContentId;
	}

	public void setDmContentId(int dmContentId) {
		this.dmContentId = dmContentId;
	}

	public int getDmNum() {
		return dmNum;
	}

	public void setDmNum(int dmNum) {
		this.dmNum = dmNum;
	}

	public String getDmUserId() {
		return dmUserId;
	}

	public void setDmUserId(String dmUserId) {
		this.dmUserId = dmUserId;
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

	@Override
	public String toString() {
		return "DmContent [dmContentId=" + dmContentId + ", dmNum=" + dmNum + ", dmUserId=" + dmUserId + ", dmContent="
				+ dmContent + ", dmRegdate=" + dmRegdate + "]";
	}
    
    

}
