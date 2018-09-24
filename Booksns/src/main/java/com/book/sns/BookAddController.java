package com.book.sns;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.book.sns.dao.AlarmMapper;
import com.book.sns.dao.BookMapper;
import com.book.sns.dao.kshFeedMapper;
import com.book.sns.dto.Alarm;
import com.book.sns.dto.Book;
import com.book.sns.util.PageNavigator;


@Controller
public class BookAddController {

	private static final String UPLOADPATH="C:\\sh\\booksns\\src\\main\\webapp\\resources\\images\\FileRepo";
	
	@Autowired
	SqlSession sqlSession;
	
	private final int countPerPage = 10;
	private final int pagePerGroup = 10;
	
	/**
	 * go to bookAddForm
	 * @return
	 */
	@RequestMapping(value = "/bookAddForm", method = RequestMethod.GET)
	public String bookAddForm() {
		
		return "bookAddForm";
	}
	
	@RequestMapping(value = "/selfAdd", method = RequestMethod.GET)
	public String selfAdd() {
		
		return "selfAdd";
	}
	
	
	@RequestMapping(value = "/bookFind", method = RequestMethod.GET)
	public String bookAdd(String searchIsbn, Model model, @RequestParam(value="page", defaultValue="1") int page) {
		
		
		String authorization = "KakaoAK 62f3a956ce11a4820b9408378304d68d";
		String result = "";
		ArrayList<Book> book = new ArrayList<>();
		try {
        	
        	String keyword = URLEncoder.encode(searchIsbn, "UTF-8");
            String apiURL = "https://dapi.kakao.com/v2/search/book?page=" + page + "&target=title&target=isbn&target=publisher&query=" + keyword;
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", authorization);
            int responseCode = con.getResponseCode();
            
            System.out.println("response code : " + responseCode);
             	
            
            BufferedReader br;
            if(responseCode==200) { 													
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  																	
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;

            while ((inputLine = br.readLine()) != null) {
                result = result + inputLine.trim();
                
                System.out.println(inputLine);
                
            }
            br.close();
            
            JSONParser jp = new JSONParser();
            JSONObject obj = (JSONObject) jp.parse(result);
      
            JSONObject meta = (JSONObject) obj.get("meta");
            boolean pageable = (boolean) meta.get("is_end");
            
            
            /*페이지 더 불러올 코드*/
            if (pageable == false) {
            	System.out.println("페이지 더 있음");
            	long longTotal = (long) meta.get("pageable_count");
            	int total = (int) longTotal;
            	PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
            	model.addAttribute("page", navi);
            } 
            
            
            JSONArray documents = (JSONArray) obj.get("documents");
            for (int i = 0; i < documents.size(); i++) {
            	String author = "";
            	JSONObject document = (JSONObject) documents.get(i);
            	JSONArray authors = (JSONArray) document.get("authors");
            	
            	for (int j = 0; j < authors.size(); j++) {
            		String tmp = (String) authors.get(j);
            		author = author + " " + tmp;
            	}
            	
            	Book oneBook = new Book();
            	
            	String category = (String) document.get("category").toString();
            	String contents = (String) document.get("contents").toString();
            	String isbn = (String) document.get("isbn").toString();
            	String publisher = (String) document.get("publisher").toString();
            	String thumbnail = (String) document.get("thumbnail").toString();
            	String title = (String) document.get("title").toString();
            	String price = (String) document.get("price").toString();
            	
            	oneBook.setAuthors(author);
            	oneBook.setContents(contents);
            	oneBook.setCategories(category);
            	oneBook.setIsbn(isbn);
            	oneBook.setPublisher(publisher);
            	oneBook.setThumbnail(thumbnail);
            	oneBook.setTitle(title);
            	oneBook.setPrice(price);
            	
            	book.add(oneBook);
            	
            }
            
            for (Book b : book) {
            	System.out.println(b);
            }
            
            //error
        } catch (Exception e) {
            System.out.println(e);
        }
        
		model.addAttribute("book", book);
		model.addAttribute("currentPage", "bookFind");
		model.addAttribute("keyword", searchIsbn);
		return "/bookFind";
	}
	
	
	
	/**
	 * insert into book
	 * @param book
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/bookAdd", method = RequestMethod.POST)
	public String bookAdd(Book book, HttpSession session, MultipartFile thumb) {
		
		String userId = (String) session.getAttribute("userId");
		
		book.setUserId(userId);

		BookMapper mapper = sqlSession.getMapper(BookMapper.class);
		
		
		kshFeedMapper mapper1=sqlSession.getMapper(kshFeedMapper.class);
		int bookNum=0;
		bookNum=mapper1.selectNextVal();
		book.setBookNum(bookNum);
		mapper.insertBook(book);
		
		
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
	    	  

		return "redirect:/bookFind";
	}
	
	
	/**
	 * insert into book
	 * @param book
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/selfAdd", method = RequestMethod.POST)
	public String selfAdd(Book book, HttpSession session, MultipartFile thumb) {
		
		System.out.println(book);
		System.out.println(thumb);
		String userId = (String) session.getAttribute("userId");
		
		book.setUserId(userId);
		
		System.out.println("up : " + thumb);
		
		if (book.getThumbnail() == null) {
			book.setThumbnail("./resources/images/bookmark.png");
		} else {
			
			UUID uuid = UUID.randomUUID();
		    String saveName = uuid.toString();
		    book.setThumbnail("./resources/images/FileRepo/" + saveName);
		    
		    File file = new File(UPLOADPATH, saveName);
		    
		    System.out.println(book);

		    //�뿬湲곗꽌 �씠�젣 ���옣�릺寃좎�?
		    try {
		    	thumb.transferTo(file);   
		    } catch (Exception e) {   
		       e.printStackTrace();
		    }
	    }
		
		
		BookMapper mapper = sqlSession.getMapper(BookMapper.class);
		
		kshFeedMapper mapper1=sqlSession.getMapper(kshFeedMapper.class);
		int bookNum=0;
		bookNum=mapper1.selectNextVal();
		book.setBookNum(bookNum);
		mapper.insertBook(book);
		
		
		
		mapper.insertBook(book);
		
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
		
		return "redirect:/bookFind";
	}
	
	@RequestMapping(value = "/goBookAdd", method = RequestMethod.GET)
	public String goBookAdd(Model model, String searchIsbn) {
		
		String authorization = "KakaoAK 62f3a956ce11a4820b9408378304d68d";
		String result = "";
		Book oneBook = new Book();
		String[] num = searchIsbn.split(" ");
		
		System.out.println("isbn : " + num[1]);
		String tmp = num[1];
		
		try {
        	
        	String keyword = URLEncoder.encode(tmp, "UTF-8");
            String apiURL = "https://dapi.kakao.com/v2/search/book?target=isbn&query=" + keyword;
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", authorization);
            int responseCode = con.getResponseCode();
            
            System.out.println("response code : " + responseCode);
            
            
            BufferedReader br;
            if(responseCode==200) { 													// �젙�긽 �샇異�
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  																	// �뿉�윭 諛쒖깮
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;

            while ((inputLine = br.readLine()) != null) {
                result = result + inputLine.trim();
                
                System.out.println(inputLine);
                
            }
            br.close();
            
            JSONParser jp = new JSONParser();
            JSONObject obj = (JSONObject) jp.parse(result);
            JSONArray documents = (JSONArray) obj.get("documents");
            String author = "";
            for (int i = 0; i < documents.size(); i++) {
            	JSONObject document = (JSONObject) documents.get(i);
            	JSONArray authors = (JSONArray) document.get("authors");
            	Iterator<String> iterator = authors.iterator();
            	while (iterator.hasNext()) {
            		author = author + " " + iterator.next();
            	}
            	
            	String category = (String) document.get("category").toString();
            	String contents = (String) document.get("contents").toString();
            	String isbn = (String) document.get("isbn").toString();
            	String publisher = (String) document.get("publisher").toString();
            	String thumbnail = (String) document.get("thumbnail").toString();
            	String title = (String) document.get("title").toString();
            	String price = (String) document.get("price").toString();
            	
            	oneBook.setAuthors(author);
            	oneBook.setContents(contents);
            	oneBook.setCategories(category);
            	oneBook.setIsbn(isbn);
            	oneBook.setPublisher(publisher);
            	oneBook.setThumbnail(thumbnail);
            	oneBook.setTitle(title);
            	oneBook.setPrice(price);
            	
            	
            }
            

            
            //error
        } catch (Exception e) {
            System.out.println(e);
        }
        
		model.addAttribute("book", oneBook);
		
		
		return "/bookAddForm";
	}
	
	
	//validation
	@RequestMapping(value = "/dbBookFind", method = RequestMethod.POST)
	public @ResponseBody boolean dbBookFind(Book book, HttpSession session) {
		
		BookMapper mapper = sqlSession.getMapper(BookMapper.class);
		String userId = (String) session.getAttribute("userId");
		book.setUserId(userId);
		
		
		ArrayList<Book> result = mapper.dbBookFind(book);
		
		boolean tf = result.isEmpty();
		
		return tf;
	}
}
