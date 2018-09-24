package com.book.sns;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.UserMapper;
import com.book.sns.dto.SnsUser;


@Controller
public class UserLoginController {
	
	
	@Autowired SqlSession sqlSession;
	/*로그인 기능*/
	@RequestMapping(value = "/loginForm", method = RequestMethod.POST)
	public String login(SnsUser user,HttpSession hsession) {
		SnsUser result = new SnsUser();
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		result = mapper.login(user);
		String userId = user.getUserId();
		hsession.setAttribute("userId", result.getUserId());
		hsession.setAttribute("email", result.getEmail() );
		hsession.setAttribute("saveFile", result.getSaveFile());
		return "redirect:/getFeed?userId=" + userId;
	}
	/*로그아웃 기능*/
	@RequestMapping(value = "/userLogout", method = RequestMethod.GET)
	public String logout(HttpSession hsession) {
		hsession.invalidate();
		return "redirect:/";
	}
	/*user 회원탈퇴*/
	@RequestMapping(value = "/userdelete", method = RequestMethod.POST)
	public String delete(HttpSession hsession) {
		
		String userId = (String) hsession.getAttribute("userId");
		
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		mapper.deleteUser(userId);
		hsession.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/login_Check",method=RequestMethod.GET)
	   public @ResponseBody int loginIdCheck(SnsUser snsUser) {
	      
	      UserMapper mapper = sqlSession.getMapper(UserMapper.class);
	      
	      int result2 = mapper.loginCheck(snsUser);
	      
	      if(result2==0) {
	         System.out.println("틀림");
	      }
	      System.out.println(result2);
	      
	      return result2;
	   }
}
