package com.book.sns.dao;

import java.util.ArrayList;
import java.util.Map;

import com.book.sns.dto.DmContent;
import com.book.sns.dto.DmContentList;
import com.book.sns.dto.DmList;
import com.book.sns.dto.FollowingList;
import com.book.sns.dto.Relationship;

public interface SnsDmMapper {
   public ArrayList<FollowingList> selectFollowingId(FollowingList followingList); 	 //팔로잉리스트 가져오기
   public DmList dmCheck(DmList dmList); //방 중복 확인
   public int dmRoomCreate(DmList dmList); //DM방 생성
   public int dmSubmit(DmContent dmContent);//dm 전송
   public ArrayList<DmContent> selectDm(Map<String, Object> map); //dm 내용불러오기
   public ArrayList<DmContentList> getDmRecentById(String userId); //dm 최근 내용 (방가져오기)
   public int updateDmAlarm(Map<String, Object> map);
}