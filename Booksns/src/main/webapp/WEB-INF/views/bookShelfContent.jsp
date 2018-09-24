<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Book add </title>


   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
   <script src="./resources/semanticUI/semantic.js"></script>
   <script src="./resources/js/bookAdd.js"></script>
   <script src="./resources/js/menubar.js"></script>
   <link rel="stylesheet" href="./resources/css/menubar.css">
   <link rel="stylesheet" href="./resources/css/bookAdd.css">

<script>


$(function(){
   
	
	var bookNum = $('#bookNum').val();
	$('#bookDeleteBtn').click(function(){
		alert("삭제하였습니다!");
		location.href = "deleteBook?bookNum=" + bookNum;
	});
	
	
	$('#bookUpdateBtn').click(function(){
		
		var memo = $('#memo').val();
		$('#memoInput').val(memo);
		var read = $('input[name="readYN"]:checked').val();
		$('#readYN').val(read);
		
		$('#updateBook').submit();
		
	});
	
	var userId = $('#userId').val();
	$('#backBtn').click(function(){
		location.href = "bookShelf?userId=" + userId;
	});
	
});

</script>

</head>
<body>

<!-- ====================================MENU================================================= -->
<jsp:include page="./topMenu.jsp" flush="false"/>
<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- ==============================================contetnt====================================================== -->
<div class="ui main text container" >
		<c:if test="${book != null}">
			<div class="searchresult ui segment">
				<form action="updateBook" method="post" id="updateBook">
					<input type="hidden" name="bookNum" id="bookNum" value="${book.bookNum }">
					<input type="hidden" id="userId" value="${userId }">
					<%-- <input type="hidden" name="thumbnail" value="${book.thumbnail}">
					<input type="hidden" name="title" id="title" value="${book.title}">
					<input type="hidden" name="authors" value="${book.authors}">
					<input type="hidden" name="publisher" value="${book.publisher}">
					<input type="hidden" name="contents" value="${book.contents}">
					<input type="hidden" name="categories" value="${book.categories}">
					<input type="hidden" name="isbn" value="${book.isbn}">  --%>
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
							<c:if test="${sessionScope.userId == userId }">
								<c:if test="${book.readYN == 'Y' }">
									<input type="radio" name="readYN" value="Y" checked="checked">읽음 
									<input type="radio" name="readYN" value="N">안읽음
								</c:if>
								<c:if test="${book.readYN == 'N' }">
									<input type="radio" name="readYN" value="Y">읽음 
									<input type="radio" name="readYN" value="N" checked="checked">안읽음
								</c:if>
							</c:if>
							<c:if test="${sessionScope.userId != userId }">
								<c:if test="${book.readYN == 'Y' }">
									<input type="radio" name="readYN" value="Y" checked="checked" disabled="disabled">읽음 
									<input type="radio" name="readYN" value="N" disabled="disabled">안읽음
								</c:if>
								<c:if test="${book.readYN == 'N' }">
									<input type="radio" name="readYN" value="Y" disabled="disabled">읽음 
									<input type="radio" name="readYN" value="N" checked="checked" disabled="disabled">안읽음
								</c:if>
							</c:if>
					</div>

					<div class="item">
						<h3 class="ui header">Memo</h3>
						<c:if test="${sessionScope.userId == userId }">
							<textarea name="memo" id="memo">${book.memo }</textarea>
						</c:if>
						<c:if test="${sessionScope.userId != userId }">
							<textarea name="memo" id="memo" readonly="readonly">${book.memo }</textarea>
						</c:if>
					</div>

					<div class="item">
						<c:if test="${sessionScope.userId == userId }">
							<button class="ui basic right floated button" id="bookDeleteBtn">
								<i class="trash icon"></i>
								삭제하기
							</button>
							
							<button class="ui basic right floated button" id="bookUpdateBtn">
								<i class="eraser icon"></i>
								수정하기
							</button>
							<button class="ui basic right floated button" id="backBtn">
								<i class="arrow left icon"></i>
								서재로
							</button>
						</c:if>
						<c:if test="${sessionScope.userId != userId }">
							<button class="ui basic right floated button" id="backBtn">
								<i class="arrow left icon"></i>
								서재로
							</button>
						</c:if>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>