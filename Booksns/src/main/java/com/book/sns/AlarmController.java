package com.book.sns;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.AlarmMapper;
import com.book.sns.dao.BookMapper;
import com.book.sns.dao.FavoriteMapper;
import com.book.sns.dao.ProfileMapper;
import com.book.sns.dao.kshFeedMapper;
import com.book.sns.dto.Alarm;
import com.book.sns.dto.Book;
import com.book.sns.dto.Favorite;
import com.book.sns.dto.Feed;
import com.book.sns.dto.Photo;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;

@Controller
public class AlarmController {

	@Autowired
	SqlSession sqlSession;

	@RequestMapping(value = "/alarmView", method = RequestMethod.GET)
	public String alarmView(HttpSession hsession, Model model) {
		AlarmMapper mapper = sqlSession.getMapper(AlarmMapper.class);
		kshFeedMapper feedMapper = sqlSession.getMapper(kshFeedMapper.class);
		mapper.updateReading((String) hsession.getAttribute("userId"));
		List<Alarm> list = mapper.selectListAlarm((String) hsession.getAttribute("userId"));
		List<Alarm> bookAl= mapper.overNoticeDate();
		for(int i=0;i<list.size();i++) {
			bookAl.add(list.get(i));
		}
		
		
		
		for (int i = 0; i < bookAl.size(); i++) {

			System.out.println(bookAl.get(i));
			if (bookAl.get(i).getNoticeType().equals("book")) {
					Book book=null;
					BookMapper bm=sqlSession.getMapper(BookMapper.class);
					book=bm.selectOneBook(String.valueOf(bookAl.get(i).getFkNum()));
					bookAl.get(i).setSaveFile(book.getThumbnail());
					bookAl.get(i).setContent(book.getTitle());
					bookAl.get(i).setRegDate(book.getRegDate());
			} else {
				Feed feed = null;
				feed = feedMapper.selectOneFeed(bookAl.get(i).getFkNum());
				bookAl.get(i).setContent(feed.getContent());
				bookAl.get(i).setTag(feed.getTag());
				bookAl.get(i).setLikeCount(feed.getLikeCount());
				List<Photo> photo = null;
				if (feed.getPhotoYN().equals("Y")) {
					photo = feedMapper.selectPhoto(feed.getFeedNum());
					String saveFile = "";

					for (int j = 0; j < photo.size(); j++) {

						if (j < photo.size() - 1) {
							saveFile += photo.get(j).getSaveImg() + ",";
						} else {
							saveFile += photo.get(j).getSaveImg();
						}

					}

					feed.setSaveFile(saveFile);
					bookAl.get(i).setSaveFile(feed.getSaveFile());
				}
			}

		}

		model.addAttribute("alarmList", bookAl);
		return "AlarmView";
	}

	@RequestMapping(value = "/AlarmFeed", method = RequestMethod.GET)
	public @ResponseBody Feed AlarmFeed(int feedNum) {
		kshFeedMapper al = sqlSession.getMapper(kshFeedMapper.class);
		Feed feed = al.selectOneFeed(feedNum);

		ProfileMapper mapper = sqlSession.getMapper(ProfileMapper.class);
		FavoriteMapper mapper2 = sqlSession.getMapper(FavoriteMapper.class);

		Favorite fav = new Favorite();

		// targetId

		if (feed.getTargetId() != null) {
			String[] targetId = feed.getTargetId().split("@");
			feed.setViewTargetId(targetId);
		}

		List<Photo> photo = null;
		if (feed.getPhotoYN().equals("Y")) {
			photo = mapper.selectPhoto(feed.getFeedNum());
			String saveFile = "";

			for (int j = 0; j < photo.size(); j++) {

				if (j < photo.size() - 1) {
					saveFile += photo.get(j).getSaveImg() + ",";
				} else {
					saveFile += photo.get(j).getSaveImg();
				}

			}

			feed.setSaveFile(saveFile);
		}
		SnsUser user = mapper.selectProfile(feed.getUserId());
		String profilePic = user.getSaveFile();
		feed.setProfilePic(profilePic);
		fav.setFeedNum(feed.getFeedNum());
		fav.setId(feed.getUserId());
		feed.setFavoriteCheck(mapper2.selectFavorite(fav));

		return feed;
	}

	@RequestMapping(value = "conutAlarm", method = RequestMethod.GET)
	public @ResponseBody int countAlarm(HttpSession session, String alarmCheck) {
		AlarmMapper mapper = sqlSession.getMapper(AlarmMapper.class);
		String loginId = (String) session.getAttribute("userId");

		System.out.println(alarmCheck);
		SnsUser snsUser = new SnsUser();
		snsUser.setUserId(loginId);

		Alarm alarm = new Alarm();
		alarm.setAlarmCheck(loginId);
		alarm.setAlarmCheck(alarmCheck);
		int result = mapper.countFavoriteAlarm(snsUser);
		System.out.println(result + "아이디" + loginId);
		return result;
	}

	@RequestMapping(value = "/follow", method = RequestMethod.GET)
	public String follow(String followId, HttpSession session) {

		kshFeedMapper mapper = sqlSession.getMapper(kshFeedMapper.class);

		String loginId = (String) session.getAttribute("userId");
		Relationship fu = new Relationship();
		fu.setFollowId(followId);
		fu.setLoginId(loginId);

		boolean insert = mapper.follow(fu);

		/* followId에 알람주기 */

		Alarm alarm = new Alarm();
		alarm.setLoginId(loginId);
		alarm.setOwnerId(followId);
		alarm.setNoticeType("follow");

		boolean alarmInsert = mapper.insertFollowAlarm(alarm);

		return "redirect:/profileForm?userId=" + fu.getFollowId();
	}

	@RequestMapping(value = "/unfollow", method = RequestMethod.GET)
	public String unfollow(String followId, HttpSession session) {

		String loginId = (String) session.getAttribute("userId");
		Relationship fu = new Relationship();
		fu.setFollowId(followId);
		fu.setLoginId(loginId);

		kshFeedMapper mapper = sqlSession.getMapper(kshFeedMapper.class);
		boolean delete = mapper.unfollow(fu);

		/* followId에 알람주기 */

		Alarm alarm = new Alarm();
		alarm.setLoginId(loginId);
		alarm.setOwnerId(followId);
		alarm.setNoticeType("unfollow");

		boolean alarmInsert = mapper.insertUnfollowAlarm(alarm);

		return "redirect:/profileForm?userId=" + fu.getFollowId();
	}

}
