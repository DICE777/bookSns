package com.book.sns;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.book.sns.dao.BookMapper;
import com.book.sns.dto.Book;
import com.book.sns.util.PageNavigator;


@Controller
public class BookShelfController {

   
   @Autowired
   SqlSession sqlSession;
   
   final int countPerPage = 9;
   final int pagePerGroup = 5;

   
   //등록된 책 가져오기
   @RequestMapping(value = "/bookShelf", method = RequestMethod.GET)
   public String bookShelf(Model model, String userId, Book book, @RequestParam(value="page", defaultValue="1") int page) {
      //서재 정보 가져오기
      BookMapper mapper = sqlSession.getMapper(BookMapper.class);
      ArrayList<Book> result = new ArrayList<>();
      
      book.setUserId(userId);
      
      int total = mapper.getTotal();
      
      //페이징처리
      PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
   
      RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage()); 
      book.setUserId(userId);
      result = mapper.selectBookCover(book,rb); //rb는 처음부터 끝까지 설정해주는 것. 제한을 두기 때문에 rb가 필요
      
      
      model.addAttribute("bookShelf",result);
      model.addAttribute("navi", navi);
      model.addAttribute("userId", userId);

      
      return "bookShelf";
   }
   
   //책 클릭시 이동
   @RequestMapping(value = "/goBookContent", method = RequestMethod.GET)
   public String goBookContent(Model model, String bookNum, String userId) {
	  
	  BookMapper mapper = sqlSession.getMapper(BookMapper.class);
	  Book book = mapper.selectOneBook(bookNum);
	  model.addAttribute("book", book);
	  model.addAttribute("userId", userId);
      
      return "/bookShelfContent";
   }

   
   //등록된 책 Y/N 변경
      @RequestMapping(value = "/updateBook", method = RequestMethod.POST)
      public String updateBook(Book book) {
          
    	  BookMapper mapper = sqlSession.getMapper(BookMapper.class);    	  
    	  int result = mapper.bookUpdate(book);
    	  int bookNum = book.getBookNum();
    	  
          return "redirect:/goBookContent?bookNum=" + bookNum;
      }
      
  
   @RequestMapping(value = "/deleteBook", method = RequestMethod.GET)
   public String deleteBook(HttpSession session, String bookNum) {
	  
	  BookMapper mapper = sqlSession.getMapper(BookMapper.class);
	  mapper.deleteBook(bookNum);
	  String userId = (String) session.getAttribute("userId");
      
      return "redirect:/bookShelf?userId=" + userId;
   }
   
}