package com.book.sns;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.FavoriteMapper;
import com.book.sns.dao.ProfileMapper;
import com.book.sns.dao.StorageMapper;
import com.book.sns.dto.Favorite;
import com.book.sns.dto.Feed;
import com.book.sns.dto.PersonalStatistics;
import com.book.sns.dto.Photo;
import com.book.sns.dto.Relationship;
import com.book.sns.dto.SnsUser;

@Controller
public class StorageController {

	
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * profile �럹�씠吏�
	 * @return
	 */
	@RequestMapping(value = "storage", method = RequestMethod.GET)
	public String profileForm(String userId, Model model, HttpSession session) {

		StorageMapper mapper = sqlSession.getMapper(StorageMapper.class);
		String loginId = (String) session.getAttribute("userId");
		FavoriteMapper mapper2 = sqlSession.getMapper(FavoriteMapper.class);
		
	
		ArrayList<Feed> feed = mapper.selectFeed(loginId);

					
			
		for (int i = 0; i < feed.size(); i++) {
			if (feed.get(i).getTargetId() != null) {
				String[] targetId = feed.get(i).getTargetId().split("@");
						
				feed.get(i).setViewTargetId(targetId);
			}
			feed.get(i).getFeedNum();
			Favorite fav = new Favorite();
			fav.setFeedNum(feed.get(i).getFeedNum());
			fav.setId(loginId);
					
			feed.get(i).setFavoriteCheck(mapper2.selectFavorite(fav));
			}
				
				
			ArrayList<Photo> photo = new ArrayList<Photo>();
			for (int i = 0; i < feed.size(); i++) {
					
					if (feed.get(i).getPhotoYN().equals("Y")) {
						photo = mapper.selectPhoto(feed.get(i).getFeedNum());
						String saveFile="";
						
						for(int j=0;j<photo.size();j++) {
							
							
							if(j<photo.size()-1) {
								saveFile+=photo.get(j).getSaveImg()+",";
							}else {
								saveFile+=photo.get(j).getSaveImg();
							}
							
						}
						
						feed.get(i).setSaveFile(saveFile);
				
					}
				}
				
				
				for (int i = 0; i < feed.size(); i++) {
					System.out.println(i + "번째 : " + feed.get(i));
				}
				
				model.addAttribute("feed", feed);

	
		return "storageForm";
	}
	
	
}
