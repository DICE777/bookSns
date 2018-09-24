<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${sessionScope.userId}</title>


	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-base.min.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/themes/coffee.min.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-ui.min.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-exports.min.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-radar.min.js"></script>
	<link rel="stylesheet" href="https://cdn.anychart.com/releases/8.3.0/css/anychart-ui.min.css" />
	<link rel="stylesheet" href="https://cdn.anychart.com/releases/8.3.0/fonts/css/anychart-font.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
	<script src="./resources/semanticUI/semantic.js"></script>
	<link rel="stylesheet" href="./resources/css/menubar.css">
	<script src="./resources/js/menubar.js"></script>
	<script src="./resources/js/modal.js"></script>
	<script src="./resources/js/chart.js"></script>
	
<style type="text/css">

.description {
  overflow: hidden; 
  text-overflow: ellipsis;
  white-space: nowrap; 
  width: 258px;
  height: 26.4px;
}

</style>

<script>


$(function(){
	$('.ui.top.left.pointing.dropdown').dropdown({
		action: 'hide',
		onChange: function($selectedItem) {
			alert($selectedItem);
 			if ($selectedItem == 'unfollow') {
				$('#targetUnfollow').submit();
			}
			if ($selectedItem == 'follow') {
				$('#targetFollow').submit();
			}
		}
	});

});


$(function(){
	$('#follow').click(function(){
		$('#followForm').submit();
	});
});


</script>

</head>
<body>


<!-- ====================================MENU================================================= -->

<jsp:include page="./topMenu.jsp" flush="false"/>
<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- ============================================= List ================================================ -->
<div class="ui hidden divider"></div>
<div class="defaultMain ui bottom attached padded">
	<div class="ui main text container" align="center">		     
		
		<c:if test="${follower != '[]' }">
			<c:forEach var="follower" items="${follower}" varStatus="fNum">
				<div class="ui card">
					<div class="blurring dimmable image">
						<c:if test="${follower.saveFile ne null}">
							<img src="http://localhost:8888/sns/resources/images/FileRepo/${follower.saveFile}">
						</c:if>
						<c:if test="${follower.saveFile eq null}">
							<img src="http://localhost:8888/sns/resources/images/defaultAvatar.png">
						</c:if>
					</div>
					<div class="content">
						<a class="header left floated" href="/sns/profileForm?userId=${follower.userId}">${follower.userId}</a>
						<c:set var="flag" value="false"/>
						<c:forEach var="following" items="${following }">
							<c:if test="${following.followId == follower.userId && not flag}">
								<a href="unfollow?followId=${follower.userId}">
									<button class="ui basic right floated button">Unfollow</button>
								</a>
								<c:set var="flag" value="true"/>
							</c:if>
							<c:if test="${following.followId != follower.userId && not flag}">
								<a href="unfollow?followId=${follower.userId}">
									<button class="ui basic right floated button">Follow</button>
								</a>
								<c:set var="flag" value="true"/>
							</c:if>
						</c:forEach>
					</div>
					<div class="description" align="left">
						${follower.introduce }
					</div>
					<div class="extra content" align="left">
						<c:forEach var="count" items="${count }" varStatus="cNum">
							<c:if test="${fNum.index == cNum.index }">
								<i class="book icon"></i> ${count}권 보유
							</c:if>
						</c:forEach>
					</div>
				</div>		
			</c:forEach>	
		</c:if>
		
		<c:if test="${follower == '[]' }">
			새로운 친구를 찾아보세요!
		</c:if>
		
	</div>
</div>	
    


</body>
</html>



