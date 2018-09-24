package com.book.sns.dto;

public class Book {

	private int bookNum;
	private String isbn;
	private String authors;
	private String title;
	private String publisher;
	private String contents;
	private String userId;
	private String categories;
	private String regDate;
	private String noticeDate;
	private String memo;
	private String price;
	private String thumbnail;
	private String readYN;
	
	public Book() { }

	public int getBookNum() {
		return bookNum;
	}

	public void setBookNum(int bookNum) {
		this.bookNum = bookNum;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getAuthors() {
		return authors;
	}

	public void setAuthors(String authors) {
		this.authors = authors;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCategories() {
		return categories;
	}

	public void setCategories(String categories) {
		this.categories = categories;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getReadYN() {
		return readYN;
	}

	public void setReadYN(String readYN) {
		this.readYN = readYN;
	}

	@Override
	public String toString() {
		return "Book [bookNum=" + bookNum + ", isbn=" + isbn + ", authors=" + authors + ", title=" + title
				+ ", publisher=" + publisher + ", contents=" + contents + ", userId=" + userId + ", categories="
				+ categories + ", regDate=" + regDate + ", noticeDate=" + noticeDate + ", memo=" + memo + ", price="
				+ price + ", thumbnail=" + thumbnail + ", readYN=" + readYN + "]";
	}
}