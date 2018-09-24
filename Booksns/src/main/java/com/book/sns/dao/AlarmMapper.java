package com.book.sns.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.book.sns.dto.Alarm;
import com.book.sns.dto.DmAlarm;
import com.book.sns.dto.DmList;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;

public interface AlarmMapper {
   public List<Alarm> selectListAlarm(String userid);
   public int insertFavoriteAlarm(Alarm alarm);
      public int countFavoriteAlarm(SnsUser snsUser);
      public int updateFavoritAlarm(Alarm alarm);
      public ArrayList<Relationship> selectFollowingId(SnsUser snsUser); //팔로잉리스트 가져오기
      public int updateReading(String userId);
      public int insertBookAlarm(Alarm alarm);
      public List<Alarm> overNoticeDate();
      public int insertDmAlarm(DmAlarm dmAlarm);//dm알람
      public int updateDmAlarm(DmAlarm dmAlarm); //알람확인,채팅방유저존재
      public int checkDmAlarm(String userId);	//메뉴바 알람 확인용, 유저에게 DM알람이 있는지
}