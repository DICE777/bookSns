package com.book.sns;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.book.sns.dao.UserMapper;
import com.book.sns.dto.SnsUser;


@Controller
public class UserJoinController {

	
	@Autowired
	SqlSession sqlSession;
	
	//회원가입처리
	@RequestMapping(value = "/user_join", method = RequestMethod.POST)
	public String userJoin(SnsUser snsUser, HttpSession session) {
		
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		
		int result = mapper.userJoin(snsUser);
		
		System.out.println(snsUser);
		
		if(result==1) {
			System.out.println("가입 O");
			String userId = snsUser.getUserId();
			String introduce = snsUser.getIntroduce();
			session.setAttribute("introduce", introduce);
			session.setAttribute("userId", userId);
			session.setAttribute("saveFile", snsUser.getSaveFile());
		}else{
			System.out.println("가입 X");
		}
		return "redirect:/bookFind";
	}
	
	//아이디 중복확인
	@RequestMapping(value="/user_idCheck",method=RequestMethod.GET)
	public @ResponseBody int idCheck(String userId) {
		
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		
		int result = mapper.idCheck(userId);
		
		if(result==1) {
			System.out.println("중복 O");
		}else{
			System.out.println("중복 X");
		}
		System.out.println(result);
		
		return result;
	}
	

	
}
