package com.book.sns.dto;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FeedWrite {
	List<MultipartFile> upload;
	String content;
	String tag;
	String targetId;
	public FeedWrite(List<MultipartFile> upload, String content, String tag, String targetId) {
		super();
		this.upload = upload;
		this.content = content;
		this.tag = tag;
		this.targetId = targetId;
	}
	public FeedWrite() {
		super();
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	@Override
	public String toString() {
		return "FeedWrite [upload=" + upload + ", content=" + content + ", tag=" + tag + ", targetId=" + targetId + "]";
	}
	
	
}
