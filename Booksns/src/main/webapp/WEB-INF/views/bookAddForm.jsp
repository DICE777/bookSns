<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Book add </title>

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
			$('#selfBtn').click(function(){
				location.href="selfAdd";
			});
		});
	</script>
</head>
<body>

<!-- ================================================= MENU ================================================= -->

	<jsp:include page="./topMenu.jsp" flush="false"/>
	<input type="hidden" id="login" value="${sessionScope.userId }">
	
<!-- =============================================== contetnt =============================================== -->
<div class="ui hidden divider"></div>
	<div class="ui main text container" >
		<c:if test="${book != null}">
			<div class="searchresult ui segment">
			
				<form action="bookAdd" method="post" id="bookAdd">
					<input type="hidden" name="thumbnail" value="${book.thumbnail}">
					<input type="hidden" name="title" id="title" value="${book.title}">
					<input type="hidden" name="authors" id="authors" value="${book.authors}">
					<input type="hidden"name="publisher" value="${book.publisher}"> 
					<input type="hidden" name="contents" value="${book.contents}"> 
					<input type="hidden" name="categories" value="${book.categories}">
					<input type="hidden" name="isbn" id="isbn" value="${book.isbn}">
					<input type="hidden" name="memo" id="memoInput" value=""> 
					<input type="hidden" name="readYN" id="readYN" value="">
				</form>

				<div class="ui list">
					<div class="item">
						<img src="${book.thumbnail}">
					</div>

					<div class="item">
						<h3 class="ui header">Title</h3>
						${book.title}
					</div>

					<div class="item">
						<h3 class="ui header">Author</h3>
						${book.authors}
					</div>

					<div class="item">
						<h3 class="ui header">Publisher</h3>
						${book.publisher }
					</div>

					<div class="item">
						<h3 class="ui header">ISBN</h3>
						${book.isbn}
					</div>

					<div class="item">
						<h3 class="ui header">Description</h3>
						${book.contents}
					</div>

					<div class="item">
						<h3 class="ui header">Category</h3>
						${book.categories}
					</div>

					<div class="item">
						<h3 class="ui header">Read</h3>
						<div class="ui input">
							<input type="radio" name="readYN" value="Y">읽음 
							<input type="radio" name="readYN" value="N" checked="checked">안읽음
						</div>
					</div>

					<div class="item">
						<h3 class="ui header">Memo</h3>
						<textarea class="ten thirteen wide column" name="memo" id="memo"></textarea>
					</div>

					<div class="item">
						<button class="ui basic right floated button" id="bookAddBtn">
							<i class="plus icon"></i>
							책장에 넣기
						</button>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>