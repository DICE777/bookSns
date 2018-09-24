<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<link rel="stylesheet" type="text/css" href="http://localhost:8888/sns/resources/css/feed.css">
	
	<title>검색결과</title>

</head>
<body>

<!-- ================================================= MENU ================================================= -->

	<jsp:include page="./topMenu.jsp" flush="false"/>
	<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- =============================================== UserList =============================================== -->

	<div class="defaultMain ui bottom attached padded">
		<div class="ui main text container">
			<div class="ui cards">
				<c:choose>
					<c:when test="${result.type == 'user'}">
						<c:forEach var="user" items="${result.userList}">
							<div class="card">
								<div class="blurring dimmable image">
									<div class="ui dimmer">
										<div class="content">
											<div class="center">
												<c:set var="flag" value="false"/>
												<c:forEach var="relation" items="${result.relationList}">
													<c:if test="${flag == 'false'}">
														<c:if test="${relation.followId == user.userId}">
															<div class="ui inverted button">Follow</div>
															<c:set var="flag" value="true"/>
															<%-- <% break;%> --%>
															<%-- <jsp:scriptlet>break;</jsp:scriptlet> --%> 
														</c:if>
													</c:if>
												</c:forEach>
												
												<c:if test="${flag == 'true'}">
													<div class="ui inverted button">UnFollow</div>
												</c:if>
											</div>
										</div>
									</div>
									<c:if test="${user.saveFile ne null}">
										<img src="http://localhost:8888/sns/resources/images/FileRepo/${user.saveFile}">
									</c:if>
									<c:if test="${user.saveFile eq null}">
										<img src="http://localhost:8888/sns/resources/images/defaultAvatar.png">
									</c:if>
								</div>
								<div class="content">
									<a class="header" href="/sns/profileForm?userId=${user.userId}">${user.userId}</a>
									<!-- <div class="meta">
										<span class="date">Created in Sep 2014</span>
									</div> -->
								</div>
								<div class="extra content">
									<a> <i class="book icon"></i> ${result.bookCount} 권 보유
									</a>
								</div>
							</div>
						</c:forEach>
					</c:when>
					
					<c:when test="${result.feed}">
						<c:forEach var="feed" items="${result.feedlist}">
						</c:forEach>
					</c:when>
				</c:choose>
				
<!-- ================================================= end ==================================================== -->
				
			</div>
		</div>
	</div>
</body>
</html>