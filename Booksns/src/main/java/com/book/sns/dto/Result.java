package com.book.sns.dto;

public class Result {
	
	String success;
	String content;
	
	public Result() { }

	public Result(String success, String content) {
		super();
		this.success = success;
		this.content = content;
	}

	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Result [success=" + success + ", content=" + content + "]";
	}
}
