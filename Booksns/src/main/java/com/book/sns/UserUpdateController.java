package com.book.sns;

import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.book.sns.dao.UserUpdateMapper;
import com.book.sns.dto.SnsUser;

@Controller
public class UserUpdateController {
	private static final String UPLOADPATH="C:\\sh\\booksns\\src\\main\\webapp\\resources\\images\\FileRepo";
   @Autowired
   SqlSession sqlsession;
   

   
   
   @RequestMapping(value = "/userUpdateForm", method = RequestMethod.GET)
   public String user_update_form(Model model,HttpSession hsession) {
         UserUpdateMapper mapper=sqlsession.getMapper(UserUpdateMapper.class);
      String userid=null;
            userid=(String)hsession.getAttribute("userId");
            SnsUser user=null;
            user=mapper.selectOneUser(userid);
            
            
            model.addAttribute("user", user);
      
      
      return "userUpdateForm";
   }
   
   @RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
   public String user_update(SnsUser user,HttpSession hsession,MultipartFile upload) {
      UserUpdateMapper mapper=sqlsession.getMapper(UserUpdateMapper.class);
      String userid=null;
      userid=(String)hsession.getAttribute("userId");
      user.setUserId(userid);
      System.out.println(upload);
      if(upload!=null) {
         UUID uuid=UUID.randomUUID();
         String saveName= uuid+"_"+upload.getOriginalFilename();
         //�삤由ъ��궇 �뙆�씪怨� �꽭�씠釉뚮뱶 �뙆�씪�쓣 uploadfile�뿉�꽌 �굹�닠�꽌 遺꾨같�빐以�.
         user.setOriginFile(upload.getOriginalFilename());
         user.setSaveFile(saveName);
         File file=new File(UPLOADPATH,saveName);
         //�뿬湲곗꽌 �씠�젣 ���옣�릺寃좎�?
         try {
            upload.transferTo(file);   
         } catch (Exception e) {   
            e.printStackTrace();
         }
      }
      System.out.println(user);
      int result =0;
      result=mapper.updateUser(user);
      
      return "redirect:/profileForm?userId=" + userid;
   }
   
   @RequestMapping(value="/emailCheck", method =RequestMethod.GET)
   public@ResponseBody int emailCheck(String email) {
      UserUpdateMapper mapper=sqlsession.getMapper(UserUpdateMapper.class);
      SnsUser user = null;
      
      user=mapper.emailCheck(email);
      
      if(user == null) {
         return 0;
      }else {
         return 1;
      }
   }
   
   
   
   
   
   
   
/*public void fileSave(MultipartFile uploadfile) {

      UUID uuid=UUID.randomUUID();
      String saveName= uuid+"_"+uploadfile.getOriginalFilename();
      File file=new File(UPLOADPATH,saveName);
      try {
         uploadfile.transferTo(file);   
      } catch (Exception e) {   
         e.printStackTrace();
      }
      
   }*/
}
