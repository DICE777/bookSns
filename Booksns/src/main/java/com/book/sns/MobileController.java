package com.book.sns;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.AlarmMapper;
import com.book.sns.dao.BookMapper;
import com.book.sns.dao.UserMapper;
import com.book.sns.dao.kshFeedMapper;
import com.book.sns.dto.Alarm;
import com.book.sns.dto.Book;
import com.book.sns.dto.Result;
import com.book.sns.dto.SnsUser;

@Controller
@RequestMapping(value="/mobile")
public class MobileController {

	@Autowired SqlSession sqlSession;
	
	/**
	 * login
	 * @author MinJeJung
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody Result login(@RequestBody SnsUser user) {
		System.out.println("from Mobile: " + user);
		
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		SnsUser resultUser = mapper.login(user);
		System.out.println("from DB: " + user);
		
		Result result = null;
		if(resultUser != null) {
			result = new Result("success", resultUser.getUserId());
		} else {
			result = new Result("fail", null);
		}
		System.out.println(result);
		
		return result;
	}
	
	/**
	 * insert into book
	 * @author MinJeJung
	 * @param book
	 * @return
	 */
	@RequestMapping(value = "/bookAdd", method = RequestMethod.POST)
	public @ResponseBody Result bookAdd(@RequestBody Book book,HttpSession session) {
		System.out.println("from Mobile: " + book);
		
		BookMapper mapper = sqlSession.getMapper(BookMapper.class);
		
		kshFeedMapper mapper1=sqlSession.getMapper(kshFeedMapper.class);
		int bookNum=0;
		bookNum=mapper1.selectNextVal();
		book.setBookNum(bookNum);
		mapper.insertBook(book);
		
		
		boolean result = mapper.insertBook(book);
		
		
		
		
		//알람을 집어넣는 부분.
		
				AlarmMapper alarmMapper	= sqlSession.getMapper(AlarmMapper.class);	
			      if(book.getReadYN().equals("N")) {
			    	  Date date=new Date(System.currentTimeMillis());
			    	  
			    	  Alarm al=null;
			            al=new Alarm();
			            al.setFkNum(book.getBookNum());
			            al.setNoticeType("book");
			            al.setAlarmCheck("N");
			            al.setLoginId((String)session.getAttribute("userId"));
			            al.setOwnerId((String)session.getAttribute("userId"));
			            
			            alarmMapper.insertBookAlarm(al);
			    	  
			      }
		
		if(result == true) return new Result("success", null);
		else return new Result("false", null);
	}
	
	
}
