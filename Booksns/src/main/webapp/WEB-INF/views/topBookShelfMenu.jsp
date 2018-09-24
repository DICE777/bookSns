<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

   <!-- jquery -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   
   <!-- semantic UI -->
   <link rel="stylesheet" type="text/css" href="http://localhost:8888/sns/resources/semanticUI/semantic.css">
   <script src="http://localhost:8888/sns/resources/semanticUI/semantic.js"></script>
   
   <!-- CSS & JavaScript -->
   <link rel="stylesheet" href="http://localhost:8888/sns/resources/css/topMenu.css">
   <script src="http://localhost:8888/sns/resources/js/topBookShelfMenu.js"></script>
   
</head>

<!-- ================================================= MENU ================================================= -->

   <div class="ui top attached inverted menu" style="background-color: #754f44; margin-top: 0px;">
      <div class="ui fluid container">

<!-- =============================================== iconMenu =============================================== -->
      
         <a href="" class="item">
            <i class="big bookmark outline icon"  style="margin: 0px;"></i>
         </a>
         <a href="dmGo" class="item">
            <i class="big envelope outline icon" style="margin: 0px;"></i>
         </a>
         <a href="" class="item">
            <i class="big bell outline icon" style="margin: 0px;"></i>
         </a>
         <a href="" class="item">
            <i class="big chart bar outline icon"  style="margin: 0px;"></i>
         </a>

<!-- ============================================== search bar ============================================== -->
         
         <div class="item">
            <div class="ui right action left icon input" style="width: 600px;">
               <i class="search icon"></i>
               <input type="hidden" id="currentPage" value="${currentPage}"/>
               <input type="text" id="keyword" placeholder="Search" value="${keyword}">
               <div id="btnSearch" class="ui button">Search</div>
            </div>
         </div>
         
<!-- ============================================= dropdown Menu ============================================ -->
         
         <div class="right item">
            <div id="right" class="ui selection dropdown right aligned allMenu">
               <input type="hidden" id="login" value="${sessionScope.userId}">
               <div class="default text">Menu</div>
               <div class="menu">
                  <div class="item" data-value="profile">
                     <c:if test="${user.saveFile == null}">a
                        <img class="profileImg" src="http://localhost:8888/sns/resources/images/defaultAvatar.png"><br>
                        ${sessionScope.userId}
                     </c:if>
                     <c:if test="${user.saveFile != null}">
                        <img class="profileImg" src="http://localhost:8888/sns/resources/images/FileRepo/${user.saveFile }"><br>
                        ${sessionScope.userId}
                     </c:if>   
                  </div>
                  <div class="item">Home</div>
                  <div class="item">프로필</div>
                  <div class="item">서재</div>
                  <div class="item">책 등록</div>
                  <div class="item">랭킹</div>
                  <div class="item">쪽지</div>
                  <div class="item">알람</div>
                  <div class="item">로그아웃</div>
               </div>
            </div>
         </div>
         
<!-- ================================================= end ==================================================== -->         
         
      </div>
   </div>
   
</html>