<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Book add</title>

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<!-- semantic UI -->
	<link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
	<script src="./resources/semanticUI/semantic.js"></script>
	
	<!-- CSS & JavaScript -->
	<script src="./resources/js/bookAdd.js"></script>
	<link rel="stylesheet" href="./resources/css/bookAdd.css">

	<script>
		$(function() {
			$('#selfBtn').click(function() {
				location.href="selfAdd";
			});
		});
		
		function bookAdd(num) {
			var isbn = document.getElementById("isbn"+num).value;
			location.href="goBookAdd?searchIsbn="+isbn;
		}
	</script>
</head>
<body>

<!-- ================================================= MENU ================================================= -->

<jsp:include page="./topMenu.jsp" flush="false"/>
<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- =============================================== contetnt =============================================== -->
<div class="ui hidden divider"></div>
	<div class="defaultMain ui bottom attached padded">
		<div class="ui main text container">
			<c:if test="${book != null && keyword != null}">
				<c:forEach varStatus="idx" var="item" items="${book }">
					<div class="searchresult ui segment" onclick="bookAdd(${idx.index})">
						<div class="ui list">
												
							<input type="hidden" id="isbn${idx.index }" value="${item.isbn }">
												
							<div class="item">
								<h2 class="ui header">
									<img class="ui image" src="${item.thumbnail }">
									<div class="content">
									${item.title }
									</div>
								</h2>
													
								<div class="item">
									<div class="ui large basic label">Author</div>
									${item.authors }
								</div>
								<div class="item">
									<div class="ui large basic label">Publisher</div>
									${item.publisher }
								</div>
								<div class="item">
									<div class="ui large basic label">ISBN</div>
									${item.isbn }
								</div>
							</div>
						</div>			
					</div>
				</c:forEach>
				
				
				<!-- page -->
				
					<div class="ui hidden divider"></div>
					<div class="page" align="center">
						
						<a href="bookFind?page=1&searchIsbn=${keyword}">
							<i class="big angle double left icon"></i>
						</a>
						
						<a href="bookFind?page=${page.currentPage-1}&searchIsbn=${keyword}">
							<i class="big angle left icon"></i>
						</a>
	   
	                    <c:forEach var="pageNum" begin="${page.startPageGroup }" end="${page.endPageGroup }">
	                       <a href="bookFind?page=${pageNum}&searchIsbn=${keyword}">
                               ${pageNum}
	                       </a>
	                    </c:forEach>
	   
	                    <a href="bookFind?page=${page.currentPage+1}&searchIsbn=${keyword}">
	                     	<i class="big angle right icon"></i>
	                    </a>
	                    
	                    <a href="bookFind?page=50&searchIsbn=${keyword}">
							<i class="big angle double right icon"></i>
						</a>
						
					</div>
					<div class="ui hidden divider"></div>
			</c:if>
		</div>
	</div>
			
<div class="defaultMain ui bottom attached padded">
	<div class="ui main text container">								
		<c:if test="${book == '[]'}">
			<div class="btnContainer" align="center">
				<button class="large ui basic button" id="selfBtn">
					<i class="plus icon"></i>
					직접 등록하기
				</button>
			</div>
			<br>
			<div class="disabled ui big image" align="center">
				<img src="./resources/images/bookmark.png">
			</div>
				
		</c:if>
	</div>
</div>
</body>
</html>