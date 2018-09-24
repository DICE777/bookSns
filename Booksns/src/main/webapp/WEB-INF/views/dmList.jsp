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
   <link rel="stylesheet" href="./resources/css/menubar.css">
   <script src="./resources/js/menubar.js"></script>
   
   <!-- CSS & JavaScript -->
	<link rel="stylesheet" href="http://localhost:8888/sns/resources/css/topMenu.css">
	<script src="http://localhost:8888/sns/resources/js/topMenu.js"></script>

<style type="text/css">
body{
   overflow: hidden;
   
}

.dmContainer {
  width: 100%;
  height: 100vh;
  max-width: 650px;
  max-height: 590px;
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  -webkit-transform: translateX(-50%);
  overflow: hidden;
}

.dmContent {

   width: 600px;
	
}

#dmList{
  position:absolute;
  top:50%;
  left:50%;
  transform:translate(-50%, -50%);
}

#recentList{
	background:white;
	display: flex;
	margin-top: 10px;
	width: 500px; 
	color: black;
	
}
</style>

<style type="text/css">
.btn {
  display: inline-block;
  background: transparent;
  text-transform: uppercase;
  font-weight: 500;
  font-style: normal;
  font-size: 0.625rem;
  letter-spacing: 0.3em;
  color: rgba(223,190,106,0.7);
  border-radius: 0;
  padding: 18px 80px 20px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin: 0.625rem;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
  position:absolute;
  top:80%;
  left:50%;
  transform:translate(-50%, -50%);
}

.btn:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: $white;
  background-position: 99% 50%;
}

</style>

</head>
<body>
<!-- ====================================MENU================================================= -->

	<jsp:include page="./topMenu.jsp" flush="false"/>

<!-- ==============================================contetnt====================================================== -->

<div class="dmContainer" style="margin-top: 80px; border: 1px solid #dddddd;  background: #231f20;   color: #fff;">
   <div class="row">
      
         <div class="title"  style="margin-top: 100px; height: 100px; text-align: center;">
         	<font size="100px;"> CHAT HISTORY</font>
         </div>
         <div>
             <a href="dmFollowingListGo" class="btn" >DM</a> 
         </div>
         <div id="dmList" class="dmList">
            <!-- dm방 출력되는 곳 -->
      	   <c:forEach var="list" items="${dmContentList}">
        		<div id="recentList">
	         		 <div style="margin-left: 10px;">@<a href="dmRoomGo?followId=${list.toId}">${list.toId}</a></div>
	         		 <div style="width:200px; margin-left: 20px; text-overflow: ellipsis; overflow:hidden;">${list.dmContent} </div>
	         		 <c:if test="${list.alarmCheck==0}">
	         		 <div><img src="./resources/images/problem_icon.png" style="width: 20px; height: 20px;"></div>
	         		 </c:if>
	         		 <div style="margin-left: 15%;">${list.dmRegdate}</div>
        		</div>
           </c:forEach>
         </div>
         
      </div>
</div>

</body>
</html>