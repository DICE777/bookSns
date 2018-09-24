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
	<script src="http://localhost:8888/sns/resources/js/topMenu.js"></script>
	
</head>

<!-- ================================================= MENU ================================================= -->

	<div class="ui top attached inverted menu" style="background-color: #754f44; margin-top: 0px;">
		<div class="ui fluid container">

<!-- =============================================== iconMenu =============================================== -->
		
			<a href="getFeed?userId=${sessionScope.userId }" class="item">
				<i class="big bookmark outline icon"  style="margin: 0px;"></i>
			</a>
			<a href="dmGo" class="item">
				<i class="big envelope outline icon" style="margin: 0px;"></i>
				<span class="dmAlarmBox"></span>
			</a>
			<a href="alarmView" class="item">
         		<i class="big bell outline icon" style="margin: 0px;"></i>
            	<span class="notification-counter"></span>
         	</a>
			<a href="" class="item">
				<i class="big chart bar outline icon"  style="margin: 0px;"></i>
			</a>

<!-- ============================================== search bar ============================================== -->
			
			<div class="item">
				<div class="ui right action left icon input" style="width: 600px;">
					<i class="search icon"></i>
						<input type="hidden" id="nowPage" value="${currentPage}"/>
						<input type="text" id="keyword" name="searchIsbn" placeholder="Search" value="${keyword}">
					<c:if test="${currentPage ne 'bookFind'}">
						<div class="ui compact selection dropdown searchCategory" style="width: 100px;">
							
							<c:choose>
								<c:when test="${category ne null and category == 'book'}">
									<div class="text">책</div>
								</c:when>
								<c:when test="${category ne null and category == 'feed'}">
									<div class="text">피드</div>
								</c:when>
								<c:when test="${category ne null and category == 'user'}">
									<div class="text">사용자</div>
								</c:when>
								<c:when test="${category ne null and category == 'tag'}">
									<div class="text">태그</div>
								</c:when>
								<c:otherwise>
									<div class="text">선택</div>
								</c:otherwise>
							</c:choose>
							<i class="dropdown icon"></i>
							<div class="menu">
								<div class="item" data-value="book">책</div>
								<div class="item" data-value="feed">피드</div>
								<div class="item" data-value="user">사용자</div>
								<div class="item" data-value="tag">태그</div>
							</div>
						</div>
					</c:if>
					<div id="btnSearch" class="ui button">Search</div>
				</div>
			</div>
			
<!-- ============================================= dropdown Menu ============================================ -->
			
<%-- 			<div class="right item">
				<div id="right" class="ui selection dropdown right aligned allMenu">
					<input type="hidden" id="login" value="${sessionScope.userId}">
					<div class="default text">Menu</div>
					<div class="menu">
						<div class="item" data-value="profile">
							<c:if test="${sessionScope.saveFile == null}">
								<img class="profileImg" src="http://localhost:8888/sns/resources/images/defaultAvatar.png"><br>
								${sessionScope.userId}
							</c:if>
							<c:if test="${user.saveFile != null}">
								<img class="profileImg" src="http://localhost:8888/sns/resources/images/FileRepo/${sessionScope.saveFile }"><br>
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
			</div> --%>
	<div class="right item">
		<div id="slidebtn" class="slideBtn">&#9776;</div>  
		<div id="sidenav" class="sidenav">
			<div class="menu" align="center">
				<c:if test="${sessionScope.saveFile == null}">
					<img class="profile" src="http://localhost:8888/sns/resources/images/defaultAvatar.png"><br>
					${sessionScope.userId}
				</c:if>
				<c:if test="${user.saveFile != null}">
					<img class="profile" src="http://localhost:8888/sns/resources/images/FileRepo/${sessionScope.saveFile }"><br>
					${sessionScope.userId}
				</c:if>	
			</div>
			<div class="ui divider"></div>
			<div class="menu" id="home">Home</div>
			<div class="menu" id="profile">프로필</div>
			<div class="menu" id="add">등록</div>
			<div class="menu" id="library">서재</div>
			<div class="menu" id="ranking">랭킹</div>
			<div class="menu" id="dm">쪽지</div>
			<div class="menu" id="alarm">알람</div>
			<div class="menu" id="logout">로그아웃</div>
		</div>
	</div>


		<!-- ================================================= end ==================================================== -->			
			
		</div>
	</div>
	
</html>