package com.book.sns.dto;

import java.util.Arrays;

public class Feed {

   
   private int feedNum;
   private String content;
   private String userId;
   private String targetId;
   private String[] viewTargetId;
   private int targetFeedNum;
   private int originalFeedNum;
   private String regDate;
   private String tag;
   private int likeCount;
   private int spreadCount;
   private int depth;
   private String photoYN;
   private String saveFile;
   private String profilePic;
   private int favoriteCheck;
   public Feed() {
      super();
      // TODO Auto-generated constructor stub
   }
   public Feed(int feedNum, String content, String userId, String targetId, String[] viewTargetId, int targetFeedNum,
         int originalFeedNum, String regDate, String tag, int likeCount, int spreadCount, int depth, String photoYN,
         String saveFile, String profilePic, int favoriteCheck) {
      super();
      this.feedNum = feedNum;
      this.content = content;
      this.userId = userId;
      this.targetId = targetId;
      this.viewTargetId = viewTargetId;
      this.targetFeedNum = targetFeedNum;
      this.originalFeedNum = originalFeedNum;
      this.regDate = regDate;
      this.tag = tag;
      this.likeCount = likeCount;
      this.spreadCount = spreadCount;
      this.depth = depth;
      this.photoYN = photoYN;
      this.saveFile = saveFile;
      this.profilePic = profilePic;
      this.favoriteCheck = favoriteCheck;
   }
   public int getFeedNum() {
      return feedNum;
   }
   public void setFeedNum(int feedNum) {
      this.feedNum = feedNum;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getUserId() {
      return userId;
   }
   public void setUserId(String userId) {
      this.userId = userId;
   }
   public String getTargetId() {
      return targetId;
   }
   public void setTargetId(String targetId) {
      this.targetId = targetId;
   }
   public String[] getViewTargetId() {
      return viewTargetId;
   }
   public void setViewTargetId(String[] viewTargetId) {
      this.viewTargetId = viewTargetId;
   }
   public int getTargetFeedNum() {
      return targetFeedNum;
   }
   public void setTargetFeedNum(int targetFeedNum) {
      this.targetFeedNum = targetFeedNum;
   }
   public int getOriginalFeedNum() {
      return originalFeedNum;
   }
   public void setOriginalFeedNum(int originalFeedNum) {
      this.originalFeedNum = originalFeedNum;
   }
   public String getRegDate() {
      return regDate;
   }
   public void setRegDate(String regDate) {
      this.regDate = regDate;
   }
   public String getTag() {
      return tag;
   }
   public void setTag(String tag) {
      this.tag = tag;
   }
   public int getLikeCount() {
      return likeCount;
   }
   public void setLikeCount(int likeCount) {
      this.likeCount = likeCount;
   }
   public int getSpreadCount() {
      return spreadCount;
   }
   public void setSpreadCount(int spreadCount) {
      this.spreadCount = spreadCount;
   }
   public int getDepth() {
      return depth;
   }
   public void setDepth(int depth) {
      this.depth = depth;
   }
   public String getPhotoYN() {
      return photoYN;
   }
   public void setPhotoYN(String photoYN) {
      this.photoYN = photoYN;
   }
   public String getSaveFile() {
      return saveFile;
   }
   public void setSaveFile(String saveFile) {
      this.saveFile = saveFile;
   }
   public String getProfilePic() {
      return profilePic;
   }
   public void setProfilePic(String profilePic) {
      this.profilePic = profilePic;
   }
   public int getFavoriteCheck() {
      return favoriteCheck;
   }
   public void setFavoriteCheck(int favoriteCheck) {
      this.favoriteCheck = favoriteCheck;
   }
   @Override
   public String toString() {
      return "Feed [feedNum=" + feedNum + ", content=" + content + ", userId=" + userId + ", targetId=" + targetId
            + ", viewTargetId=" + Arrays.toString(viewTargetId) + ", targetFeedNum=" + targetFeedNum
            + ", originalFeedNum=" + originalFeedNum + ", regDate=" + regDate + ", tag=" + tag + ", likeCount="
            + likeCount + ", spreadCount=" + spreadCount + ", depth=" + depth + ", photoYN=" + photoYN
            + ", saveFile=" + saveFile + ", profilePic=" + profilePic + ", favoriteCheck=" + favoriteCheck + "]";
   }
   
   
   
}