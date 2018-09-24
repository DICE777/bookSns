package com.book.sns.dao;

import java.util.Map;

import com.book.sns.dto.Favorite;

public interface FavoriteMapper {
	public int insertFavorite(Favorite fav);
	public int deleteFavorite(Favorite fav);
	public int selectFavorite(Favorite fav);
	public int updateFavorite(Map<String,Integer> val); //feed like cnt 
}
