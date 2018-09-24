package com.book.sns.dto;

public class Alarm {
   private int noticeNum; 
   private String noticeType;
   private String ownerId;
   private String loginId;
   private int fkNum;
   private String regDate;
   private String noticeDate;
   private String alarmCheck;
   private String profilePic;
   private String content;
   private String tag;
   private String saveFile;
   private int likeCount;
   public Alarm(int noticeNum, String noticeType, String ownerId, String loginId, int fkNum, String regDate,
         String noticeDate, String alarmCheck, String profilePic, String content, String tag, String saveFile,
         int likeCount) {
      super();
      this.noticeNum = noticeNum;
      this.noticeType = noticeType;
      this.ownerId = ownerId;
      this.loginId = loginId;
      this.fkNum = fkNum;
      this.regDate = regDate;
      this.noticeDate = noticeDate;
      this.alarmCheck = alarmCheck;
      this.profilePic = profilePic;
      this.content = content;
      this.tag = tag;
      this.saveFile = saveFile;
      this.likeCount = likeCount;
   }
   public Alarm() {
      super();
   }
   public int getNoticeNum() {
      return noticeNum;
   }
   public void setNoticeNum(int noticeNum) {
      this.noticeNum = noticeNum;
   }
   public String getNoticeType() {
      return noticeType;
   }
   public void setNoticeType(String noticeType) {
      this.noticeType = noticeType;
   }
   public String getOwnerId() {
      return ownerId;
   }
   public void setOwnerId(String ownerId) {
      this.ownerId = ownerId;
   }
   public String getLoginId() {
      return loginId;
   }
   public void setLoginId(String loginId) {
      this.loginId = loginId;
   }
   public int getFkNum() {
      return fkNum;
   }
   public void setFkNum(int fkNum) {
      this.fkNum = fkNum;
   }
   public String getRegDate() {
      return regDate;
   }
   public void setRegDate(String regDate) {
      this.regDate = regDate;
   }
   public String getNoticeDate() {
      return noticeDate;
   }
   public void setNoticeDate(String noticeDate) {
      this.noticeDate = noticeDate;
   }
   public String getAlarmCheck() {
      return alarmCheck;
   }
   public void setAlarmCheck(String alarmCheck) {
      this.alarmCheck = alarmCheck;
   }
   public String getProfilePic() {
      return profilePic;
   }
   public void setProfilePic(String profilePic) {
      this.profilePic = profilePic;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getTag() {
      return tag;
   }
   public void setTag(String tag) {
      this.tag = tag;
   }
   public String getSaveFile() {
      return saveFile;
   }
   public void setSaveFile(String saveFile) {
      this.saveFile = saveFile;
   }
   public int getLikeCount() {
      return likeCount;
   }
   public void setLikeCount(int likeCount) {
      this.likeCount = likeCount;
   }
   @Override
   public String toString() {
      return "Alarm [noticeNum=" + noticeNum + ", noticeType=" + noticeType + ", ownerId=" + ownerId + ", loginId="
            + loginId + ", fkNum=" + fkNum + ", regDate=" + regDate + ", noticeDate=" + noticeDate + ", alarmCheck="
            + alarmCheck + ", profilePic=" + profilePic + ", content=" + content + ", tag=" + tag + ", saveFile="
            + saveFile + ", likeCount=" + likeCount + "]";
   }
   
   
   
   

}