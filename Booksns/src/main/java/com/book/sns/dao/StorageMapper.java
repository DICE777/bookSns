package com.book.sns.dao;

import java.util.ArrayList;

import com.book.sns.dto.Feed;
import com.book.sns.dto.PersonalStatistics;
import com.book.sns.dto.Photo;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;

public interface StorageMapper {
	
	
	public ArrayList<Feed> selectFeed(String userId);
	public ArrayList<Feed> selectMention(Feed feed);
	public ArrayList<Photo> selectPhoto(int feedNum);
	public ArrayList<Feed> selectDepthOne(int originalFeedNum);
	public ArrayList<Feed> selectNoMentionFeed(int feedNum);

	public boolean follow(Relationship relationship);
	public ArrayList<Relationship> following(String userId);
}
