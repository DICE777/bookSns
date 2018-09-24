package com.book.sns;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.AlarmMapper;
import com.book.sns.dao.BookMapper;
import com.book.sns.dao.SearchMapper;
import com.book.sns.dao.kshFeedMapper;
import com.book.sns.dto.Alarm;
import com.book.sns.dto.Book;
import com.book.sns.dto.Feed;
import com.book.sns.dto.Photo;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;


@Controller
@RequestMapping(value = "/search")
public class SearchController {
	
	@Autowired SqlSession sqlsession;
	
	@RequestMapping(value = "/book", method = RequestMethod.GET)
	public String searchBook(String keyword, HttpSession session, Model model) {
		System.out.println("/search/book?keyword: " + keyword);
		String id = (String) session.getAttribute("userId");
		
		HashMap<String, String> searchConditions = new HashMap<String, String>();
		searchConditions.put("userId", id);
		searchConditions.put("keyword", keyword);
		
		SearchMapper mapper = sqlsession.getMapper(SearchMapper.class);
		List<Book> booklist = mapper.searchBook(searchConditions);
		System.out.println(booklist);
		
		model.addAttribute("bookShelf", booklist);
		
		return "bookShelf";
	}
	
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String searchUser(String keyword, HttpSession session, Model model) {
		System.out.println("/search/user?keyword: " + keyword);
		String id = (String) session.getAttribute("userId");
		
		SearchMapper searchMapper = sqlsession.getMapper(SearchMapper.class);
		List<SnsUser> userList = searchMapper.searchUser(keyword);
		System.out.println(userList);
		
		kshFeedMapper relationMapper = sqlsession.getMapper(kshFeedMapper.class);
		List<Relationship> relationList = relationMapper.following(id);
		System.out.println(relationList);
		
		BookMapper bookMapper = sqlsession.getMapper(BookMapper.class);
		int bookCount = bookMapper.getBooksCount(keyword);
		System.out.println(bookCount);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("type", "user");
		result.put("userList", userList);
		result.put("relationList", relationList);
		result.put("bookCount", bookCount);
		
		model.addAttribute("result", result);
		
		return "searchResult";
	}
	
	@RequestMapping(value = "/{category}", method = RequestMethod.GET)
	public String searchTag(@PathVariable("category") String category, String keyword, HttpSession session, Model model) {
		String id = (String) session.getAttribute("userId");
		
		// 검색 조건 설정
		HashMap<String, String> searchConditions = new HashMap<String, String>();
		searchConditions.put("category", category);
		searchConditions.put("userId", id);
		searchConditions.put("keyword", keyword);
		
		SearchMapper searchMapper = sqlsession.getMapper(SearchMapper.class);
		
		// feed
		ArrayList<Feed> feed = searchMapper.selectSearchFeedOrTag(searchConditions);
		System.out.println("검색결과: " + feed);
			
		kshFeedMapper feedMapper = sqlsession.getMapper(kshFeedMapper.class);
		
		// targetId
		for (int i = 0; i < feed.size(); i++) {
			if (feed.get(i).getTargetId() != null) {
				String[] targetId = feed.get(i).getTargetId().split("@");
				feed.get(i).setViewTargetId(targetId);
			}
			feed.get(i).getFeedNum();
		}
		
		//getProfilePic
		for (int i = 0; i < feed.size(); i++) {
			String profilePic = feedMapper.selectProfile(feed.get(i).getUserId()).getSaveFile();
			feed.get(i).setProfilePic(profilePic);
		}
		
		//get photo
		ArrayList<Photo> photo = new ArrayList<Photo>();
		for (int i = 0; i < feed.size(); i++) {
			if (feed.get(i).getPhotoYN().equals("Y")) {
				photo = feedMapper.selectPhoto(feed.get(i).getFeedNum());
				String saveFile="";
				
				for(int j=0;j<photo.size();j++) {
					if(j<photo.size()-1) {
						saveFile+=photo.get(j).getSaveImg()+",";
					}else {
						saveFile+=photo.get(j).getSaveImg();
					}
				}
				feed.get(i).setSaveFile(saveFile);
				//System.out.println(feed.get(i).getSaveFile());
			}
		}
		
		model.addAttribute("feed", feed);
		for (int i = 0; i < feed.size(); i++) {
			System.out.println(i + "번째 : " + feed.get(i));
		}
		
		//followList
		ArrayList<Relationship> follow = feedMapper.following(id);
		for (int i = 0; i < follow.size(); i++) {
			System.out.println(follow.get(i));
		}
		
		model.addAttribute("follow", follow);
		model.addAttribute("keyword", keyword);
		model.addAttribute("category", category);
		
		return "feed";
	}
	
	
	
	   @RequestMapping(value = "conutAlarm", method = RequestMethod.GET)
	    public @ResponseBody int countAlarm(HttpSession session,String alarmCheck) {
	       AlarmMapper mapper = sqlsession.getMapper(AlarmMapper.class);
	       String loginId = (String) session.getAttribute("userId");
	    
	       System.out.println(alarmCheck);
	       SnsUser snsUser = new SnsUser();
	       snsUser.setUserId(loginId);
	       
	       Alarm alarm = new Alarm();
	       alarm.setAlarmCheck(loginId);
	       alarm.setAlarmCheck(alarmCheck);
	       int result = mapper.countFavoriteAlarm(snsUser);
	       System.out.println(result+"아이디"+loginId);
	       return result;
	    }
}


