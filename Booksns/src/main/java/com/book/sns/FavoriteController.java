package com.book.sns;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.AlarmMapper;
import com.book.sns.dao.FavoriteMapper;
import com.book.sns.dto.Alarm;
import com.book.sns.dto.Favorite;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;


@Controller
public class FavoriteController {
   
   @Autowired
   SqlSession sqlSession;
   

   @RequestMapping(value = "goFavorite", method = RequestMethod.POST)
   public @ResponseBody int favorite1(int feedNum,HttpSession session) {
     
     FavoriteMapper mapper = sqlSession.getMapper(FavoriteMapper.class);
     AlarmMapper mapper2 = sqlSession.getMapper(AlarmMapper.class);
     
     System.out.println(feedNum);
      String id = (String)session.getAttribute("userId");
      System.out.println(id);
      
      Favorite fav = new Favorite();
      fav.setFeedNum(feedNum);
      fav.setId(id);
      
      SnsUser snsUser = new SnsUser();
      snsUser.setUserId(id);
      Alarm alarm = new Alarm();
      ArrayList<Relationship> follow = new ArrayList<Relationship>();
      follow = mapper2.selectFollowingId(snsUser);
      alarm.setFkNum(feedNum);
      alarm.setNoticeType("like");
      alarm.setLoginId(id);
      
      System.out.println("aa"+follow);
      for(Relationship r:follow) {
         alarm.setOwnerId(r.getLoginId());
         mapper2.insertFavoriteAlarm(alarm);
      }
      
      int exist = mapper.selectFavorite(fav);
      if(exist ==1) {
         mapper.deleteFavorite(fav);
         mapper2.insertFavoriteAlarm(alarm);
         //String : 蹂��닔�씠由�  || Integer : value
         Map<String,Integer> val = new HashMap<String, Integer>();
         val.put("feedNum", feedNum);
         val.put("add", -1);
         
         mapper.updateFavorite(val);
         
         
         return 0;
      }else {
         mapper.insertFavorite(fav);
         
         Map<String,Integer> val = new HashMap<String, Integer>();
         val.put("feedNum", feedNum);
         val.put("add", 1);
         
         mapper.updateFavorite(val);
         return 1;
      }
      
   }
   
}