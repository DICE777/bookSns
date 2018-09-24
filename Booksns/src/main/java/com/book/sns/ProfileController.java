package com.book.sns;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.BookMapper;
import com.book.sns.dao.FavoriteMapper;
import com.book.sns.dao.ProfileMapper;
import com.book.sns.dto.Favorite;
import com.book.sns.dto.Feed;
import com.book.sns.dto.PersonalStatistics;
import com.book.sns.dto.Photo;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;

@Controller
public class ProfileController {

	
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * profile �럹�씠吏�
	 * @return
	 */
	@RequestMapping(value = "/profileForm", method = RequestMethod.GET)
	public String profileForm(String userId, Model model, HttpSession session) {

		ProfileMapper mapper = sqlSession.getMapper(ProfileMapper.class);
		FavoriteMapper mapper2 = sqlSession.getMapper(FavoriteMapper.class);
		String loginId = (String) session.getAttribute("userId");

		
		if (mapper.selectProfile(userId) != null) {
			

			// statistics
			SnsUser user = mapper.selectProfile(userId);
			ArrayList<PersonalStatistics> ps = mapper.selectStatistics(userId);
			ArrayList<Relationship> followList = mapper.followingList(loginId);
			System.out.println(followList);
			
			boolean tf = false;
			
			if(followList  != null) {
				for (int i = 0; i < followList.size(); i++) {
					if (followList.get(i).getFollowId().equals(userId)) {
						tf = true;
						break;
					}
				}
			}
			System.out.println(tf);
			model.addAttribute("user", user);
			model.addAttribute("ps", ps);
			model.addAttribute("follow", tf);
			
			
			// feed 媛��졇�삤湲�
			ArrayList<Feed> feed = mapper.selectAllFeed(userId);
			
			
			// targetId�뿉�꽌 @鍮쇨린
			for (int i = 0; i < feed.size(); i++) {
				if (feed.get(i).getTargetId() != null) {
					String[] targetId = feed.get(i).getTargetId().split("@");
					
					feed.get(i).setViewTargetId(targetId);
				}
				feed.get(i).getFeedNum();
				Favorite fav = new Favorite();
				fav.setFeedNum(feed.get(i).getFeedNum());
				fav.setId(loginId);
				
				feed.get(i).setFavoriteCheck(mapper2.selectFavorite(fav));
			}
			
			
			//getProfilePic
			for (int i = 0; i < feed.size(); i++) {
				
				String profilePic = mapper.selectProfile(feed.get(i).getUserId()).getSaveFile();
				
				feed.get(i).setProfilePic(profilePic);
			}
			
			
			//�궗吏꾧��졇�삤湲�
			ArrayList<Photo> photo = new ArrayList<Photo>();
			for (int i = 0; i < feed.size(); i++) {
				
				if (feed.get(i).getPhotoYN().equals("Y")) {
					photo = mapper.selectPhoto(feed.get(i).getFeedNum());
					String saveFile="";
					
					for(int j=0;j<photo.size();j++) {
						
						
						if(j<photo.size()-1) {
							saveFile+=photo.get(j).getSaveImg()+",";
						}else {
							saveFile+=photo.get(j).getSaveImg();
						}
						
					}
					
					feed.get(i).setSaveFile(saveFile);
				}
			}
			
			
			
			model.addAttribute("feed", feed);

			int follower = follower(userId);
			int following = following(userId);
			model.addAttribute("follower", follower);
			model.addAttribute("following", following);
		} else {
			model.addAttribute("noResult", "noResult");
			return "noResult";
		}
		
		
		return "profile";
	}
	
	
	@RequestMapping(value = "/selectMention", method = RequestMethod.GET)
	public @ResponseBody ArrayList<Feed> selectMention(Feed feed,HttpSession session) {

		System.out.println("!!" + feed);

		ProfileMapper mapper = sqlSession.getMapper(ProfileMapper.class);
		FavoriteMapper mapper2 = sqlSession.getMapper(FavoriteMapper.class);
		ArrayList<Feed> oneMention = new ArrayList<Feed>();
		Favorite fav = new Favorite();
		String loginId = (String) session.getAttribute("userId");
		//no reply
		if (feed.getTargetFeedNum() == 0) {
			
			oneMention = mapper.selectDepthOne(feed.getOriginalFeedNum());
			
			if (oneMention.isEmpty()) {
				ArrayList<Feed> noMention = mapper.selectNoMentionFeed(feed.getFeedNum());
				

				// targetId
				for (int i = 0; i < noMention.size(); i++) {
					if (noMention.get(i).getTargetId() != null) {
						String[] targetId = noMention.get(i).getTargetId().split("@");
						noMention.get(i).setViewTargetId(targetId);
					}
					
					List<Photo> photo=null;
					if (noMention.get(i).getPhotoYN().equals("Y")) {
						photo = mapper.selectPhoto(noMention.get(i).getFeedNum());
						String saveFile="";
						
						for(int j=0;j<photo.size();j++) {
							
							
							if(j<photo.size()-1) {
								saveFile+=photo.get(j).getSaveImg()+",";
							}else {
								saveFile+=photo.get(j).getSaveImg();
							}
							
						}
						
						noMention.get(i).setSaveFile(saveFile);
						fav.setFeedNum(noMention.get(i).getFeedNum());
		                fav.setId(loginId);
		                noMention.get(i).setFavoriteCheck(mapper2.selectFavorite(fav));
					}
					SnsUser user = mapper.selectProfile(noMention.get(i).getUserId());
					String profilePic = user.getSaveFile();
					noMention.get(i).setProfilePic(profilePic);
					fav.setFeedNum(noMention.get(i).getFeedNum());
		            fav.setId(loginId);
		            noMention.get(i).setFavoriteCheck(mapper2.selectFavorite(fav));
				}
			
				return noMention;
			}
		}
		
		
		// feed�뿉 �떖由� depth1吏쒕━ 硫섏뀡
		if (feed.getTargetFeedNum() == 0) {
			oneMention = mapper.selectDepthOne(feed.getOriginalFeedNum());
			
			// targetId�뿉�꽌 @鍮쇨린
			for (int i = 0; i < oneMention.size(); i++) {
				if (oneMention.get(i).getTargetId() != null) {	
					String[] targetId = oneMention.get(i).getTargetId().split("@");
					oneMention.get(i).setViewTargetId(targetId);
				}
				List<Photo> photo=null;
				if (oneMention.get(i).getPhotoYN().equals("Y")) {
					photo = mapper.selectPhoto(oneMention.get(i).getFeedNum());
					String saveFile="";
					
					for(int j=0;j<photo.size();j++) {
						
						
						if(j<photo.size()-1) {
							saveFile+=photo.get(j).getSaveImg()+",";
						}else {
							saveFile+=photo.get(j).getSaveImg();
						}
						
					}
					
					oneMention.get(i).setSaveFile(saveFile);
					
		            fav.setFeedNum(oneMention.get(i).getFeedNum());
		            fav.setId(loginId);
		            oneMention.get(i).setFavoriteCheck(mapper2.selectFavorite(fav));
				}
				SnsUser user = mapper.selectProfile(oneMention.get(i).getUserId());
				String profilePic = user.getSaveFile();
				oneMention.get(i).setProfilePic(profilePic);
				fav.setFeedNum(oneMention.get(i).getFeedNum());
	            fav.setId(oneMention.get(i).getUserId());
	            oneMention.get(i).setFavoriteCheck(mapper2.selectFavorite(fav));
			}
			
			return oneMention;
			
		}
		

		// ���옒 媛��졇�삤湲�
		if (feed.getTargetFeedNum() != 0) {
			ArrayList<Feed> mention = mapper.selectMention(feed);


			// targetId�뿉�꽌 @鍮쇨린
			for (int i = 0; i < mention.size(); i++) {
				if (mention.get(i).getTargetId() != null) {
					String[] targetId = mention.get(i).getTargetId().split("@");
					mention.get(i).setViewTargetId(targetId);
				}
				
				List<Photo> photo=null;
				if (mention.get(i).getPhotoYN().equals("Y")) {
					photo = mapper.selectPhoto(mention.get(i).getFeedNum());
					String saveFile="";
					
					for(int j=0;j<photo.size();j++) {
						
						
						if(j<photo.size()-1) {
							saveFile+=photo.get(j).getSaveImg()+",";
						}else {
							saveFile+=photo.get(j).getSaveImg();
						}
						
					}
					mention.get(i).setSaveFile(saveFile);
					
				}
				
				SnsUser user = mapper.selectProfile(mention.get(i).getUserId());
				String profilePic = user.getSaveFile();
				mention.get(i).setProfilePic(profilePic);
				
				fav.setFeedNum(mention.get(i).getFeedNum());
	            fav.setId(loginId);
	            mention.get(i).setFavoriteCheck(mapper2.selectFavorite(fav));
			}
			
			return mention;

		}
	return null;
	}
	
	private int follower(String userId) {
		
		ProfileMapper mapper = sqlSession.getMapper(ProfileMapper.class);
		
		int count = mapper.followercnt(userId);
		
		return count;
	}
	
	private int following(String userId) {
		
		ProfileMapper mapper = sqlSession.getMapper(ProfileMapper.class);
		
		int count = mapper.followingcnt(userId);
		
		return count;
	}
	
	
	@RequestMapping(value = "/followerList", method = RequestMethod.GET)
	public String followerList(String userId, Model model) {
		
		ProfileMapper mapper = sqlSession.getMapper(ProfileMapper.class);
		ArrayList<Relationship> followerlist = mapper.followerList(userId);
		ArrayList<SnsUser> follower = new ArrayList<>();
		ArrayList<Integer> count = new ArrayList<>();
		
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		
		
		for (int i = 0; i < followerlist.size(); i++) {
			
			String followerId = followerlist.get(i).getLoginId();
			SnsUser user = mapper.selectProfile(followerId);
			follower.add(user);

			int bookCount = bookMapper.getBooksCount(followerlist.get(i).getLoginId());
			count.add(bookCount);
		}

		ArrayList<Relationship> followingList = mapper.followingList(userId);
		
		model.addAttribute("follower", follower);
		model.addAttribute("following", followingList);
		model.addAttribute("count", count);
		
		return "followerList";
	}
	
	@RequestMapping(value = "/followingList", method = RequestMethod.GET)
	public String followingList(String userId, Model model) {
		
		ProfileMapper mapper = sqlSession.getMapper(ProfileMapper.class);
		ArrayList<Relationship> follwingList = mapper.followingList(userId);
		ArrayList<SnsUser> following = new ArrayList<>();
		ArrayList<Integer> count = new ArrayList<>();
		
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		
		
		for (int i = 0; i < follwingList.size(); i++) {
			
			String followingId = follwingList.get(i).getFollowId();
			SnsUser user = mapper.selectProfile(followingId);
			following.add(user);

			int bookCount = bookMapper.getBooksCount(follwingList.get(i).getFollowId());
			count.add(bookCount);
		}

		
		model.addAttribute("following", following);
		model.addAttribute("count", count);
		
		return "followingList";
	}
}
