<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>존재하지 않는 사용자입니다</title>

</head>
<body>


<!-- ====================================MENU================================================= -->

<jsp:include page="./topMenu.jsp" flush="false"/>
<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- ============================================= List ================================================ -->
<div class="ui hidden divider"></div>
<div class="defaultMain ui bottom attached padded">
	<div class="ui main text container" align="center">		     
		
		탈퇴한 회원이거나 존재하지 않는 사용자입니다.
		
	</div>
</div>	
    


</body>
</html>



