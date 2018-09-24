package com.book.sns.dao;

import java.util.ArrayList;

import com.book.sns.dto.Feed;
import com.book.sns.dto.PersonalStatistics;
import com.book.sns.dto.Photo;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;

public interface ProfileMapper {
	
	public SnsUser selectProfile(String userId);
	public ArrayList<PersonalStatistics> selectStatistics(String userId);
	public ArrayList<Feed> selectAllFeed(String userId);
	public ArrayList<Feed> selectMention(Feed feed);
	public ArrayList<Photo> selectPhoto(int feedNum);
	public ArrayList<Feed> selectDepthOne(int originalFeedNum);
	public ArrayList<Feed> selectNoMentionFeed(int feedNum);

	public boolean follow(Relationship relationship);
	public ArrayList<Relationship> followingList(String userId);
	public ArrayList<Relationship> followerList(String userId);
	public int followercnt(String userId);
	public int followingcnt(String userId);
	
}
